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

  try {
    const { sessionId } = await req.json();
    if (!sessionId) throw new Error("Session ID is required");

    // Initialize Stripe
    const stripe = new Stripe(Deno.env.get("STRIPE_SECRET_KEY") || "", {
      apiVersion: "2023-10-16",
    });

    // Retrieve the checkout session
    const session = await stripe.checkout.sessions.retrieve(sessionId);
    
    if (!session) throw new Error("Session not found");

    // Use service role to update payment status
    const supabase = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "",
      { auth: { persistSession: false } }
    );

    const billId = session.metadata?.billId;
    const userId = session.metadata?.userId;

    if (!billId || !userId) throw new Error("Missing metadata in session");

    // Update payment status
    if (session.payment_status === "paid") {
      // Update payment record
      await supabase
        .from("garbage_payments")
        .update({
          payment_status: "completed",
          payment_date: new Date().toISOString(),
          updated_at: new Date().toISOString(),
        })
        .eq("stripe_session_id", sessionId);

      // Update bill status
      await supabase
        .from("garbage_bills")
        .update({
          status: "paid",
          updated_at: new Date().toISOString(),
        })
        .eq("id", billId);

      return new Response(JSON.stringify({ 
        success: true, 
        status: "paid",
        message: "Payment completed successfully"
      }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 200,
      });
    } else {
      // Update payment as failed
      await supabase
        .from("garbage_payments")
        .update({
          payment_status: "failed",
          updated_at: new Date().toISOString(),
        })
        .eq("stripe_session_id", sessionId);

      return new Response(JSON.stringify({ 
        success: false, 
        status: session.payment_status,
        message: "Payment was not completed"
      }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 200,
      });
    }
  } catch (error) {
    console.error("Error verifying payment:", error);
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 500,
    });
  }
});