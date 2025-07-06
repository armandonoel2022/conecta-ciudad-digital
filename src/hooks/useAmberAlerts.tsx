
import { useState, useEffect, useRef } from 'react';
import { useAuth } from '@/hooks/useAuth';
import { supabase } from '@/integrations/supabase/client';

export interface AmberAlert {
  id: string;
  user_id: string;
  child_full_name: string;
  child_nickname?: string;
  child_photo_url?: string;
  last_seen_location: string;
  disappearance_time: string;
  medical_conditions?: string;
  contact_number: string;
  additional_details?: string;
  is_active: boolean;
  created_at: string;
  resolved_at?: string;
  resolved_by?: string;
}

export interface CreateAmberAlertData {
  child_full_name: string;
  child_nickname?: string;
  child_photo_url?: string;
  last_seen_location: string;
  disappearance_time: string;
  medical_conditions?: string;
  contact_number: string;
  additional_details?: string;
}

export const useAmberAlerts = () => {
  const { user } = useAuth();
  const [alerts, setAlerts] = useState<AmberAlert[]>([]);
  const [loading, setLoading] = useState(false);
  const channelRef = useRef<any>(null);

  const fetchActiveAlerts = async () => {
    if (!user) return;

    try {
      const { data, error } = await supabase
        .from('amber_alerts')
        .select('*')
        .eq('is_active', true)
        .order('created_at', { ascending: false });

      if (error) throw error;
      setAlerts(data || []);
    } catch (error) {
      console.error('Error fetching Amber alerts:', error);
    }
  };

  const createAmberAlert = async (alertData: CreateAmberAlertData) => {
    if (!user) return null;

    setLoading(true);
    try {
      const { data, error } = await supabase
        .from('amber_alerts')
        .insert({
          user_id: user.id,
          ...alertData
        })
        .select()
        .single();

      if (error) throw error;
      console.log('Amber alert created:', data);
      return data;
    } catch (error) {
      console.error('Error creating Amber alert:', error);
      throw error;
    } finally {
      setLoading(false);
    }
  };

  const resolveAmberAlert = async (alertId: string) => {
    if (!user) return;

    try {
      const { error } = await supabase
        .from('amber_alerts')
        .update({
          is_active: false,
          resolved_at: new Date().toISOString(),
          resolved_by: user.id
        })
        .eq('id', alertId);

      if (error) throw error;
      console.log('Amber alert resolved:', alertId);
    } catch (error) {
      console.error('Error resolving Amber alert:', error);
      throw error;
    }
  };

  const uploadPhoto = async (file: File): Promise<string> => {
    try {
      const fileExt = file.name.split('.').pop();
      const fileName = `${Date.now()}.${fileExt}`;
      const filePath = `amber-photos/${fileName}`;

      const { error: uploadError } = await supabase.storage
        .from('amber-alert-photos')
        .upload(filePath, file);

      if (uploadError) throw uploadError;

      const { data: { publicUrl } } = supabase.storage
        .from('amber-alert-photos')
        .getPublicUrl(filePath);

      return publicUrl;
    } catch (error) {
      console.error('Error uploading photo:', error);
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

      // Set up real-time subscription with a unique channel name
      const channelName = `amber-alerts-${Date.now()}-${Math.random()}`;
      const channel = supabase
        .channel(channelName)
        .on(
          'postgres_changes',
          {
            event: '*',
            schema: 'public',
            table: 'amber_alerts'
          },
          (payload) => {
            console.log('Amber alert change:', payload);
            fetchActiveAlerts(); // Refresh alerts when any change occurs
          }
        )
        .subscribe();

      channelRef.current = channel;

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
    createAmberAlert,
    resolveAmberAlert,
    uploadPhoto,
    fetchActiveAlerts
  };
};
