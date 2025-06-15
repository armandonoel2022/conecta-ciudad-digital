
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
      console.log('Fetched active alerts:', data);
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

    console.log('Attempting to resolve panic alert:', alertId, 'by user:', user.id);
    
    try {
      const { data, error } = await supabase
        .from('panic_alerts')
        .update({
          is_active: false,
          resolved_at: new Date().toISOString(),
          resolved_by: user.id
        })
        .eq('id', alertId)
        .select();

      if (error) {
        console.error('Supabase update error:', error);
        throw error;
      }
      
      console.log('Panic alert resolved successfully:', data);
      
      // Update local state immediately to remove the resolved alert
      setAlerts(prevAlerts => 
        prevAlerts.filter(alert => alert.id !== alertId)
      );
      
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

      // Set up real-time subscription for panic alerts
      channelRef.current = supabase
        .channel(`panic-alerts-${user.id}-${Date.now()}`)
        .on(
          'postgres_changes',
          {
            event: '*',
            schema: 'public',
            table: 'panic_alerts'
          },
          (payload) => {
            console.log('Panic alert real-time change:', payload);
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
    } else {
      // Clean up channel when user logs out
      if (channelRef.current) {
        supabase.removeChannel(channelRef.current);
        channelRef.current = null;
      }
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
