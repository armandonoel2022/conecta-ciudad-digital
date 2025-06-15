
import React from 'react';
import { usePanicAlerts } from '@/hooks/usePanicAlerts';
import { useAuth } from '@/hooks/useAuth';
import PanicAlertOverlay from './PanicAlertOverlay';
import { useToast } from '@/hooks/use-toast';
import { useNavigate } from 'react-router-dom';

const GlobalPanicAlerts = () => {
  const { alerts, resolvePanicAlert } = usePanicAlerts();
  const { user } = useAuth();
  const { toast } = useToast();
  const navigate = useNavigate();

  // Show the most recent active alert
  const activeAlert = alerts.find(alert => alert.is_active);

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
      title: "Autoridades contactadas",
      description: "Se han notificado a las autoridades correspondientes.",
    });
    // Navigate to report page or main page
    navigate('/');
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
