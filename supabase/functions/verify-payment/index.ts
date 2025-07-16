import { serve } from "https://deno.land/std@0.190.0/http/server.ts";
import Stripe from "https://esm.sh/stripe@14.21.0";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.45.0";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response(null, { headers: corsHeaders });
  }

  const supabaseClient = createClient(
    Deno.env.get("SUPABASE_URL") ?? "",
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
  );

  try {
    // Retrieve authenticated user
    const authHeader = req.headers.get("Authorization")!;
    const token = authHeader.replace("Bearer ", "");
    const { data } = await supabaseClient.auth.getUser(token);
    const user = data.user;
    if (!user?.email) throw new Error("User not authenticated or email not available");

    // Parse request body to get session ID
    const { sessionId } = await req.json();
    if (!sessionId) {
      throw new Error("Session ID is required");
    }

    console.log(`Verifying payment for session: ${sessionId}`);

    // Initialize Stripe
    const stripe = new Stripe(Deno.env.get("STRIPE_SECRET_KEY") || "", {
      apiVersion: "2023-10-16",
    });

    // Retrieve the checkout session
    const session = await stripe.checkout.sessions.retrieve(sessionId);
    console.log(`Session status: ${session.payment_status}, mode: ${session.mode}`);

    if (session.payment_status === 'paid') {
      // Payment successful - update database
      console.log(`Payment successful for user ${user.id}`);

      // If it's a subscription, handle subscription logic
      if (session.mode === 'subscription' && session.subscription) {
        console.log(`Subscription created: ${session.subscription}`);
        
        // For now, we'll create a mock bill and mark it as paid
        // This simulates the subscription creating a bill that gets immediately paid
        const mockBill = {
          user_id: user.id,
          bill_number: `SUB-${Date.now()}`,
          billing_period_start: new Date().toISOString().split('T')[0],
          billing_period_end: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
          amount_due: session.amount_total || 0,
          due_date: new Date(Date.now() + 15 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
          status: 'paid'
        };

        const { data: createdBill, error: billError } = await supabaseClient
          .from('garbage_bills')
          .insert(mockBill)
          .select()
          .single();

        if (billError) {
          console.error('Error creating bill:', billError);
        } else {
          console.log('Mock bill created and marked as paid');
          
          // Create payment record
          const { error: paymentError } = await supabaseClient
            .from('garbage_payments')
            .insert({
              user_id: user.id,
              bill_id: createdBill.id,
              stripe_session_id: sessionId,
              amount_paid: session.amount_total || 0,
              payment_method: 'stripe',
              payment_status: 'completed',
              payment_date: new Date().toISOString()
            });

          if (paymentError) {
            console.error('Error creating payment record:', paymentError);
          }
        }
      }

      // If it's a one-time payment, handle bill payment
      if (session.mode === 'payment') {
        console.log(`One-time payment completed: ${session.payment_intent}`);
        
        // Find the specific bill from the session metadata first
        let billToUpdate = null;
        
        if (session.metadata?.billId) {
          const { data: specificBill, error: specificBillError } = await supabaseClient
            .from('garbage_bills')
            .select('*')
            .eq('id', session.metadata.billId)
            .eq('user_id', user.id)
            .in('status', ['pending', 'overdue'])
            .single();
          
          if (!specificBillError && specificBill) {
            billToUpdate = specificBill;
          }
        }
        
        // If no specific bill found, get the oldest pending or overdue bill
        if (!billToUpdate) {
          const { data: pendingBills, error: billsError } = await supabaseClient
            .from('garbage_bills')
            .select('*')
            .eq('user_id', user.id)
            .in('status', ['pending', 'overdue'])
            .order('created_at', { ascending: true })
            .limit(1);

          if (billsError) {
            console.error('Error fetching bills:', billsError);
          } else if (pendingBills && pendingBills.length > 0) {
            billToUpdate = pendingBills[0];
          }
        }

        if (billToUpdate) {
          // Update bill status to paid
          const { error: updateError } = await supabaseClient
            .from('garbage_bills')
            .update({ 
              status: 'paid',
              updated_at: new Date().toISOString()
            })
            .eq('id', billToUpdate.id);

          if (updateError) {
            console.error('Error updating bill:', updateError);
          } else {
            console.log(`Bill ${billToUpdate.bill_number} marked as paid`);
          }

          // Create payment record
          const { error: paymentError } = await supabaseClient
            .from('garbage_payments')
            .insert({
              user_id: user.id,
              bill_id: billToUpdate.id,
              stripe_session_id: sessionId,
              amount_paid: session.amount_total || 0,
              payment_method: 'stripe',
              payment_status: 'completed',
              payment_date: new Date().toISOString()
            });

          if (paymentError) {
            console.error('Error creating payment record:', paymentError);
          } else {
            console.log('Payment record created');
          }
        } else {
          console.warn('No pending bills found for payment');
        }
      }

      return new Response(JSON.stringify({ 
        success: true, 
        message: 'Payment verified successfully',
        session_status: session.payment_status 
      }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 200,
      });
    } else {
      console.log(`Payment not completed. Status: ${session.payment_status}`);
      return new Response(JSON.stringify({ 
        success: false, 
        message: 'Payment not completed',
        session_status: session.payment_status 
      }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 200,
      });
    }

  } catch (error) {
    console.error("Error verifying payment:", error);
    return new Response(JSON.stringify({ 
      success: false, 
      error: error.message 
    }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 500,
    });
  }
});