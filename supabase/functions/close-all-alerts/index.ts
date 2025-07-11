import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.50.0';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response(null, { headers: corsHeaders });
  }

  try {
    console.log('Cerrando todas las alertas activas...');

    const supabaseUrl = Deno.env.get('SUPABASE_URL')!;
    const supabaseServiceRoleKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
    
    const supabase = createClient(supabaseUrl, supabaseServiceRoleKey);

    // Cerrar alertas de pánico activas
    console.log('Desactivando alertas de pánico...');
    const { data: panicAlerts, error: panicSelectError } = await supabase
      .from('panic_alerts')
      .select('id')
      .eq('is_active', true);

    if (panicSelectError) {
      console.error('Error obteniendo alertas de pánico:', panicSelectError);
      throw panicSelectError;
    }

    let panicClosed = 0;
    if (panicAlerts && panicAlerts.length > 0) {
      const { error: panicUpdateError } = await supabase
        .from('panic_alerts')
        .update({ is_active: false })
        .eq('is_active', true);

      if (panicUpdateError) {
        console.error('Error cerrando alertas de pánico:', panicUpdateError);
        throw panicUpdateError;
      }
      panicClosed = panicAlerts.length;
    }

    // Cerrar alertas Amber activas
    console.log('Resolviendo alertas Amber...');
    const { data: amberAlerts, error: amberSelectError } = await supabase
      .from('amber_alerts')
      .select('id')
      .eq('is_active', true);

    if (amberSelectError) {
      console.error('Error obteniendo alertas Amber:', amberSelectError);
      throw amberSelectError;
    }

    let amberClosed = 0;
    if (amberAlerts && amberAlerts.length > 0) {
      const { error: amberUpdateError } = await supabase
        .from('amber_alerts')
        .update({ 
          is_active: false,
          resolved_at: new Date().toISOString()
        })
        .eq('is_active', true);

      if (amberUpdateError) {
        console.error('Error resolviendo alertas Amber:', amberUpdateError);
        throw amberUpdateError;
      }
      amberClosed = amberAlerts.length;
    }

    // Desactivar notificaciones de prueba globales
    console.log('Desactivando notificaciones de prueba...');
    const { data: testNotifications, error: testSelectError } = await supabase
      .from('global_test_notifications')
      .select('id')
      .eq('is_active', true);

    if (testSelectError) {
      console.error('Error obteniendo notificaciones de prueba:', testSelectError);
    }

    let testNotificationsClosed = 0;
    if (testNotifications && testNotifications.length > 0) {
      const { error: testUpdateError } = await supabase
        .from('global_test_notifications')
        .update({ is_active: false })
        .eq('is_active', true);

      if (testUpdateError) {
        console.error('Error desactivando notificaciones de prueba:', testUpdateError);
      } else {
        testNotificationsClosed = testNotifications.length;
      }
    }

    console.log('✅ Todas las alertas han sido cerradas exitosamente');

    return new Response(JSON.stringify({
      success: true,
      message: 'Todas las alertas activas han sido cerradas exitosamente',
      data: {
        panic_alerts_closed: panicClosed,
        amber_alerts_resolved: amberClosed,
        test_notifications_closed: testNotificationsClosed,
        total_closed: panicClosed + amberClosed + testNotificationsClosed,
        timestamp: new Date().toISOString()
      }
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });

  } catch (error) {
    console.error('Error cerrando alertas:', error);
    return new Response(JSON.stringify({ 
      error: 'Error cerrando alertas',
      details: error.message 
    }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});