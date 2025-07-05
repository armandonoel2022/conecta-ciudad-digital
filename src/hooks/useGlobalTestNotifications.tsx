import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from '@/hooks/useAuth';

interface GlobalTestNotification {
  id: string;
  notification_type: string;
  triggered_by: string;
  triggered_at: string;
  expires_at: string;
  is_active: boolean;
  message?: string;
}

export const useGlobalTestNotifications = () => {
  const [activeNotification, setActiveNotification] = useState<GlobalTestNotification | null>(null);
  const { user } = useAuth();

  useEffect(() => {
    if (!user) return;

    // Escuchar cambios en tiempo real
    const channel = supabase
      .channel('global-test-notifications')
      .on(
        'postgres_changes',
        {
          event: 'INSERT',
          schema: 'public',
          table: 'global_test_notifications'
        },
        (payload) => {
          const notification = payload.new as GlobalTestNotification;
          if (notification.is_active && new Date(notification.expires_at) > new Date()) {
            setActiveNotification(notification);
            console.log('Nueva notificación global recibida:', notification.notification_type);
            
            // Auto-dismiss después del tiempo de expiración
            const timeToExpire = new Date(notification.expires_at).getTime() - Date.now();
            setTimeout(() => {
              setActiveNotification(null);
            }, Math.max(0, timeToExpire));
          }
        }
      )
      .subscribe();

    // Cleanup
    return () => {
      supabase.removeChannel(channel);
    };
  }, [user]);

  const triggerGlobalNotification = async (type: string, message?: string) => {
    if (!user) return false;

    try {
      const { error } = await supabase
        .from('global_test_notifications')
        .insert({
          notification_type: type,
          triggered_by: user.id,
          message: message || undefined
        });

      if (error) {
        console.error('Error triggering global notification:', error);
        return false;
      }

      console.log('Notificación global enviada:', type);
      return true;
    } catch (error) {
      console.error('Error triggering global notification:', error);
      return false;
    }
  };

  const dismissNotification = () => {
    setActiveNotification(null);
  };

  return {
    activeNotification,
    triggerGlobalNotification,
    dismissNotification
  };
};