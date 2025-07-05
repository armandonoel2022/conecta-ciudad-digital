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

    console.log('Setting up global test notifications subscription');

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
          console.log('Realtime notification received:', payload);
          const notification = payload.new as GlobalTestNotification;
          if (notification.is_active && new Date(notification.expires_at) > new Date()) {
            console.log('Activating notification:', notification.notification_type);
            setActiveNotification(notification);
            
            // Auto-dismiss después del tiempo de expiración
            const timeToExpire = new Date(notification.expires_at).getTime() - Date.now();
            setTimeout(() => {
              console.log('Auto-dismissing notification');
              setActiveNotification(null);
            }, Math.max(0, timeToExpire));
          }
        }
      )
      .subscribe((status) => {
        console.log('Subscription status:', status);
      });

    // Cleanup
    return () => {
      console.log('Cleaning up global test notifications subscription');
      supabase.removeChannel(channel);
    };
  }, [user]);

  const triggerGlobalNotification = async (type: string, message?: string) => {
    if (!user) {
      console.error('No user found for triggering notification');
      return false;
    }

    console.log('Triggering global notification:', type);

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
    console.log('Dismissing notification manually');
    setActiveNotification(null);
  };

  return {
    activeNotification,
    triggerGlobalNotification,
    dismissNotification
  };
};