
import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { GarbageAlertConfig } from './useGarbageAlertConfigs';

export const useGarbageAlerts = (userSector?: string) => {
  const [showAlert, setShowAlert] = useState(false);
  const [currentConfig, setCurrentConfig] = useState<GarbageAlertConfig | null>(null);

  const getActiveConfigs = async () => {
    try {
      let query = supabase
        .from('garbage_alert_configs')
        .select('*')
        .eq('is_active', true);

      // Si se proporciona un sector específico, buscar por sector, sino usar General
      if (userSector) {
        query = query.or(`sector.eq.${userSector},sector.eq.General`);
      } else {
        query = query.eq('sector', 'General');
      }

      const { data, error } = await query.order('sector', { ascending: false }); // Prioriza sector específico sobre General

      if (error) throw error;
      return data?.[0] || null; // Retorna la primera configuración (más específica)
    } catch (error) {
      console.error('Error fetching active configs:', error);
      return null;
    }
  };

  const isWithinActiveHours = (config: GarbageAlertConfig) => {
    const now = new Date();
    const hour = now.getHours();
    return hour >= config.start_hour && hour < config.end_hour;
  };

  const isGarbageDay = (config: GarbageAlertConfig) => {
    const now = new Date();
    const dayOfWeek = now.getDay();
    return config.days_of_week.includes(dayOfWeek);
  };

  const checkGarbageAlert = async () => {
    const config = await getActiveConfigs();
    if (!config) {
      // Fallback a la configuración por defecto
      const now = new Date();
      const hour = now.getHours();
      const dayOfWeek = now.getDay();
      
      if ((dayOfWeek === 1 || dayOfWeek === 3 || dayOfWeek === 5) && 
          hour >= 6 && hour < 18) {
        setShowAlert(true);
        console.log('Garbage collection day (default config) - showing alert');
      }
      return;
    }

    setCurrentConfig(config);
    
    if (isGarbageDay(config) && isWithinActiveHours(config)) {
      setShowAlert(true);
      console.log(`Garbage collection day for ${config.sector} - showing alert`);
    }
  };

  useEffect(() => {
    // Check immediately
    checkGarbageAlert();

    // Set interval based on configuration (default 3 hours if no config)
    const getInterval = async () => {
      const config = await getActiveConfigs();
      return (config?.frequency_hours || 3) * 60 * 60 * 1000;
    };

    getInterval().then(intervalMs => {
      const interval = setInterval(checkGarbageAlert, intervalMs);
      return () => clearInterval(interval);
    });
  }, [userSector]);

  const dismissAlert = async () => {
    setShowAlert(false);
    
    // Don't show again for the configured frequency
    const config = currentConfig || await getActiveConfigs();
    const frequencyMs = (config?.frequency_hours || 3) * 60 * 60 * 1000;
    
    setTimeout(async () => {
      await checkGarbageAlert();
    }, frequencyMs);
  };

  // Función para probar la alerta manualmente
  const triggerTestAlert = () => {
    setShowAlert(true);
    console.log('Test alert triggered manually');
  };

  return {
    showAlert,
    dismissAlert,
    triggerTestAlert
  };
};
