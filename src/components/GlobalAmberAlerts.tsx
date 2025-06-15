
import React from 'react';
import { useAmberAlerts } from '@/hooks/useAmberAlerts';
import { useAuth } from '@/hooks/useAuth';
import AmberAlertOverlay from './AmberAlertOverlay';
import { useToast } from '@/hooks/use-toast';
import { useNavigate } from 'react-router-dom';

const GlobalAmberAlerts = () => {
  const { alerts, resolveAmberAlert } = useAmberAlerts();
  const { user } = useAuth();
  const { toast } = useToast();
  const navigate = useNavigate();

  // Show the most recent active alert
  const activeAlert = alerts.find(alert => alert.is_active);

  const handleResolve = async (alertId: string) => {
    try {
      await resolveAmberAlert(alertId);
      toast({
        title: "Alerta resuelta",
        description: "La Alerta Amber ha sido marcada como resuelta.",
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
      title: "Avistamiento reportado",
      description: "Se han contactado las autoridades. Gracias por tu ayuda.",
    });
    // Navigate to main page
    navigate('/');
  };

  if (!user || !activeAlert) {
    return null;
  }

  return (
    <AmberAlertOverlay
      alert={activeAlert}
      onResolve={handleResolve}
      onReport={handleReport}
    />
  );
};

export default GlobalAmberAlerts;
