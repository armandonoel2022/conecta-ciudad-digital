
import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from '@/hooks/useAuth';

export interface PanicAlert {
  id: string;
  user_id: string;
  user_full_name: string;
  latitude: number | null;
  longitude: number | null;
  address: string | null;
  created_at: string;
  expires_at: string;
  is_active: boolean;
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
        .order('created_at', { ascending: false });

      if (error) throw error;
      setAlerts(data || []);
    } catch (error) {
      console.error('Error fetching panic alerts:', error);
    } finally {
      setLoading(false);
    }
  };

  const createPanicAlert = async (location?: { latitude: number; longitude: number; address?: string }) => {
    if (!user) throw new Error('User not authenticated');

    // Get user profile for full name
    const { data: profile } = await supabase
      .from('profiles')
      .select('full_name, first_name, last_name')
      .eq('id', user.id)
      .single();

    const fullName = profile?.full_name || 
                    `${profile?.first_name || ''} ${profile?.last_name || ''}`.trim() || 
                    user.email || 'Usuario';

    const { data, error } = await supabase
      .from('panic_alerts')
      .insert({
        user_id: user.id,
        user_full_name: fullName,
        latitude: location?.latitude || null,
        longitude: location?.longitude || null,
        address: location?.address || null,
      })
      .select()
      .single();

    if (error) throw error;
    return data;
  };

  useEffect(() => {
    fetchAlerts();

    // Set up real-time subscription
    const channel = supabase
      .channel('panic_alerts_changes')
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'panic_alerts'
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
    refetch: fetchAlerts,
  };
};
