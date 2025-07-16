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
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "",
    { auth: { persistSession: false } }
  );

  try {
    console.log("=== AUTO BILLING MANAGER START ===");
    
    // Ejecutar la función para marcar facturas vencidas
    const { data: overdueCount, error: overdueError } = await supabaseClient
      .rpc('mark_overdue_bills');
    
    if (overdueError) {
      console.error('Error marking overdue bills:', overdueError);
    } else {
      console.log(`Marked ${overdueCount} bills as overdue`);
    }

    // Ejecutar la función para generar facturas automáticamente
    const { data: generatedCount, error: generateError } = await supabaseClient
      .rpc('auto_generate_monthly_bills');
    
    if (generateError) {
      console.error('Error generating monthly bills:', generateError);
    } else {
      console.log(`Generated ${generatedCount} new monthly bills`);
    }

    console.log("=== AUTO BILLING MANAGER SUCCESS ===");

    return new Response(JSON.stringify({ 
      success: true,
      overdueCount: overdueCount || 0,
      generatedCount: generatedCount || 0,
      message: `Marked ${overdueCount || 0} bills as overdue and generated ${generatedCount || 0} new bills`
    }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 200,
    });

  } catch (error) {
    console.error("=== AUTO BILLING MANAGER ERROR ===");
    console.error("Error details:", error);
    
    return new Response(JSON.stringify({ 
      success: false,
      error: error.message 
    }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 500,
    });
  }
});