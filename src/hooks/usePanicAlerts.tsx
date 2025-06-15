
import { useState, useEffect, useRef } from 'react';
import { useAuth } from '@/hooks/useAuth';
import { supabase } from '@/integrations/supabase/client';

export interface PanicAlert {
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
  const { user } = useAuth();
  const [alerts, setAlerts] = useState<PanicAlert[]>([]);
  const [loading, setLoading] = useState(false);
  const channelRef = useRef<any>(null);

  const fetchActiveAlerts = async () => {
    if (!user) return;

    try {
      const { data, error } = await supabase
        .from('panic_alerts')
        .select('*')
        .eq('is_active', true)
        .order('created_at', { ascending: false });

      if (error) throw error;
      setAlerts(data || []);
    } catch (error) {
      console.error('Error fetching panic alerts:', error);
    }
  };

  const createPanicAlert = async (locationDescription?: string) => {
    if (!user) return null;

    setLoading(true);
    try {
      // Get user's profile for full name
      const { data: profile } = await supabase
        .from('profiles')
        .select('first_name, last_name')
        .eq('id', user.id)
        .single();

      const fullName = profile ? `${profile.first_name} ${profile.last_name}` : user.email || 'Usuario';

      const { data, error } = await supabase
        .from('panic_alerts')
        .insert({
          user_id: user.id,
          user_full_name: fullName,
          location_description: locationDescription,
          is_active: true
        })
        .select()
        .single();

      if (error) throw error;
      console.log('Panic alert created:', data);
      return data;
    } catch (error) {
      console.error('Error creating panic alert:', error);
      throw error;
    } finally {
      setLoading(false);
    }
  };

  const resolvePanicAlert = async (alertId: string) => {
    if (!user) return;

    try {
      const { error } = await supabase
        .from('panic_alerts')
        .update({
          is_active: false,
          resolved_at: new Date().toISOString(),
          resolved_by: user.id
        })
        .eq('id', alertId);

      if (error) throw error;
      console.log('Panic alert resolved:', alertId);
    } catch (error) {
      console.error('Error resolving panic alert:', error);
      throw error;
    }
  };

  useEffect(() => {
    if (user) {
      fetchActiveAlerts();

      // Clean up existing channel if it exists
      if (channelRef.current) {
        supabase.removeChannel(channelRef.current);
        channelRef.current = null;
      }

      // Create a new channel with a unique name
      const channelName = `panic-alerts-${user.id}-${Date.now()}`;
      channelRef.current = supabase
        .channel(channelName)
        .on(
          'postgres_changes',
          {
            event: '*',
            schema: 'public',
            table: 'panic_alerts'
          },
          (payload) => {
            console.log('Panic alert change:', payload);
            fetchActiveAlerts(); // Refresh alerts when any change occurs
          }
        )
        .subscribe();

      return () => {
        if (channelRef.current) {
          supabase.removeChannel(channelRef.current);
          channelRef.current = null;
        }
      };
    }
  }, [user]);

  return {
    alerts,
    loading,
    createPanicAlert,
    resolvePanicAlert,
    fetchActiveAlerts
  };
};
