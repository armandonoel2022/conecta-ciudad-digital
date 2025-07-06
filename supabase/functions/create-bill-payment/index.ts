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
    console.log("=== CREATE BILL PAYMENT START ===");

    // Parse request body first
    const body = await req.json();
    console.log("Request body:", body);
    
    const { billId } = body;
    if (!billId) {
      throw new Error("Bill ID is required");
    }

    // Initialize Stripe
    const stripeKey = Deno.env.get("STRIPE_SECRET_KEY");
    if (!stripeKey) {
      throw new Error("STRIPE_SECRET_KEY not configured");
    }
    
    const stripe = new Stripe(stripeKey, {
      apiVersion: "2023-10-16",
    });
    console.log("Stripe initialized");

    // Initialize Supabase
    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_ANON_KEY") ?? ""
    );

    // Get user
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) {
      throw new Error("No authorization header");
    }

    const token = authHeader.replace("Bearer ", "");
    const { data, error: userError } = await supabaseClient.auth.getUser(token);
    
    if (userError || !data.user?.email) {
      throw new Error("User not authenticated");
    }

    const user = data.user;
    console.log("User authenticated:", user.email);

    // Get the bill details using service role for reliable access
    const serviceSupabase = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
    );

    const { data: bill, error: billError } = await serviceSupabase
      .from('garbage_bills')
      .select('*')
      .eq('id', billId)
      .eq('user_id', user.id)
      .single();

    if (billError || !bill) {
      console.error("Bill fetch error:", billError);
      throw new Error("Bill not found or access denied");
    }

    console.log("Bill found:", bill.bill_number, "Status:", bill.status);

    if (bill.status !== 'pending') {
      throw new Error("Bill is not pending payment");
    }

    // Check if customer exists
    const customers = await stripe.customers.list({ 
      email: user.email, 
      limit: 1 
    });
    
    let customerId;
    if (customers.data.length > 0) {
      customerId = customers.data[0].id;
      console.log("Existing customer:", customerId);
    } else {
      console.log("New customer");
    }

    // Create payment session
    const session = await stripe.checkout.sessions.create({
      customer: customerId,
      customer_email: customerId ? undefined : user.email,
      line_items: [
        {
          price_data: {
            currency: "dop",
            product_data: { 
              name: `Factura ${bill.bill_number}`,
              description: `Recolección de basura - ${bill.billing_period_start} a ${bill.billing_period_end}`
            },
            unit_amount: bill.amount_due,
          },
          quantity: 1,
        },
      ],
      mode: "payment",
      success_url: `${req.headers.get("origin")}/pago-basura?payment=success&session_id={CHECKOUT_SESSION_ID}`,
      cancel_url: `${req.headers.get("origin")}/pago-basura?payment=cancelled`,
      metadata: {
        userId: user.id,
        billId: billId,
        paymentType: "bill_payment",
      },
    });

    console.log("Payment session created:", session.id);
    console.log("=== CREATE BILL PAYMENT SUCCESS ===");

    return new Response(JSON.stringify({ 
      url: session.url,
      sessionId: session.id
    }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 200,
    });

  } catch (error) {
    console.error("=== CREATE BILL PAYMENT ERROR ===");
    console.error("Error details:", error);
    
    return new Response(JSON.stringify({ 
      error: error.message,
      details: error.toString()
    }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 500,
    });
  }
});