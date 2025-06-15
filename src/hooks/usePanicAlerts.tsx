
import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from './useAuth';

interface PanicAlert {
  id: string;
  user_id: string;
  user_full_name: string;
  latitude?: number;
  longitude?: number;
  location_description?: string;
  is_active: boolean;
  created_at: string;
  resolved_at?: string;
  resolved_by?: string;
}

export const usePanicAlerts = () => {
  const [alerts, setAlerts] = useState<PanicAlert[]>([]);
  const [loading, setLoading] = useState(true);
  const { user } = useAuth();

  const fetchAlerts = async () => {
    try {
      const { data, error } = await supabase
        .from('panic_alerts')
        .select('*')
        .eq('is_active', true)
        .order('created_at', { ascending: false });

      if (error) {
        console.error('Error fetching panic alerts:', error);
        return;
      }

      setAlerts(data || []);
    } catch (error) {
      console.error('Error fetching panic alerts:', error);
    } finally {
      setLoading(false);
    }
  };

  const createPanicAlert = async (alertData: {
    user_full_name: string;
    latitude?: number;
    longitude?: number;
    location_description?: string;
  }) => {
    if (!user) {
      throw new Error('Usuario no autenticado');
    }

    try {
      const { data, error } = await supabase
        .from('panic_alerts')
        .insert({
          user_id: user.id,
          user_full_name: alertData.user_full_name,
          latitude: alertData.latitude,
          longitude: alertData.longitude,
          location_description: alertData.location_description,
          is_active: true,
        })
        .select()
        .single();

      if (error) {
        console.error('Error creating panic alert:', error);
        throw error;
      }

      await fetchAlerts();
      return data;
    } catch (error) {
      console.error('Error creating panic alert:', error);
      throw error;
    }
  };

  const resolvePanicAlert = async (alertId: string) => {
    if (!user) {
      throw new Error('Usuario no autenticado');
    }

    try {
      const { error } = await supabase
        .from('panic_alerts')
        .update({
          is_active: false,
          resolved_at: new Date().toISOString(),
          resolved_by: user.id,
        })
        .eq('id', alertId);

      if (error) {
        console.error('Error resolving panic alert:', error);
        throw error;
      }

      await fetchAlerts();
    } catch (error) {
      console.error('Error resolving panic alert:', error);
      throw error;
    }
  };

  useEffect(() => {
    fetchAlerts();

    // Set up real-time subscription
    const channel = supabase
      .channel('panic-alerts-changes')
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'panic_alerts',
        },
        () => {
          fetchAlerts();
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, []);

  return {
    alerts,
    loading,
    createPanicAlert,
    resolvePanicAlert,
    refetch: fetchAlerts,
  };
};
