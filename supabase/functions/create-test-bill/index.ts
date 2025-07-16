import { serve } from "https://deno.land/std@0.190.0/http/server.ts";
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

    console.log(`Creating test bill for user: ${user.id}`);

    // Create a test bill with current month period
    const now = new Date();
    const currentMonth = now.getMonth();
    const currentYear = now.getFullYear();
    const monthStart = new Date(currentYear, currentMonth, 1);
    const monthEnd = new Date(currentYear, currentMonth + 1, 0);
    const dueDate = new Date(currentYear, currentMonth + 1, 15); // 15 days after month end
    
    const testBill = {
      user_id: user.id,
      bill_number: `TEST-${Date.now()}`,
      billing_period_start: monthStart.toISOString().split('T')[0],
      billing_period_end: monthEnd.toISOString().split('T')[0],
      amount_due: 32500 + Math.floor(Math.random() * 10000), // $325-$425 DOP in centavos
      due_date: dueDate.toISOString().split('T')[0],
      status: 'pending'
    };

    const { data: createdBill, error: billError } = await supabaseClient
      .from('garbage_bills')
      .insert(testBill)
      .select()
      .single();

    if (billError) {
      console.error('Error creating test bill:', billError);
      throw new Error(`Failed to create test bill: ${billError.message}`);
    }

    console.log(`Test bill created: ${createdBill.bill_number}`);

    return new Response(JSON.stringify({ 
      success: true, 
      message: 'Test bill created successfully',
      bill: createdBill
    }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 200,
    });

  } catch (error) {
    console.error("Error creating test bill:", error);
    return new Response(JSON.stringify({ 
      success: false, 
      error: error.message 
    }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 500,
    });
  }
});