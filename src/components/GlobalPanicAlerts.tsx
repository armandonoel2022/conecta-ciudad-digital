
import React from 'react';
import { usePanicAlerts } from '@/hooks/usePanicAlerts';
import { useAuth } from '@/hooks/useAuth';
import PanicAlertOverlay from './PanicAlertOverlay';
import { useToast } from '@/hooks/use-toast';

const GlobalPanicAlerts = () => {
  const { alerts, resolvePanicAlert } = usePanicAlerts();
  const { user } = useAuth();
  const { toast } = useToast();

  // Show the most recent active alert that's not from the current user
  const activeAlert = alerts.find(alert => alert.is_active && alert.user_id !== user?.id);

  const handleResolve = async (alertId: string) => {
    try {
      await resolvePanicAlert(alertId);
      toast({
        title: "Alerta resuelta",
        description: "La alerta de pánico ha sido marcada como resuelta.",
      });
    } catch (error) {
      toast({
        title: "Error",
        description: "No se pudo resolver la alerta. Inténtalo nuevamente.",
        variant: "destructive",
      });
    }
  };

  const handleReport = () => {
    toast({
      title: "Ayuda en camino",
      description: "Se han contactado las autoridades. Gracias por tu ayuda.",
    });
  };

  if (!user || !activeAlert) {
    return null;
  }

  return (
    <PanicAlertOverlay
      alert={activeAlert}
      onResolve={handleResolve}
      onReport={handleReport}
    />
  );
};

export default GlobalPanicAlerts;
