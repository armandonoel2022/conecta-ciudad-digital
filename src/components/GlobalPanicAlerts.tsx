
import React, { useState, useEffect } from 'react';
import { usePanicAlerts } from '@/hooks/usePanicAlerts';
import { useAuth } from '@/hooks/useAuth';
import PanicAlertOverlay from './PanicAlertOverlay';

const GlobalPanicAlerts = () => {
  const { alerts } = usePanicAlerts();
  const { user } = useAuth();
  const [dismissedAlerts, setDismissedAlerts] = useState<Set<string>>(new Set());

  // Find the most recent active alert that hasn't been dismissed
  const activeAlert = alerts.find(alert => 
    alert.is_active && 
    new Date(alert.expires_at) > new Date() && 
    !dismissedAlerts.has(alert.id)
  );

  const handleDismiss = (alertId: string) => {
    setDismissedAlerts(prev => new Set([...prev, alertId]));
  };

  // Clean up dismissed alerts when they expire
  useEffect(() => {
    const interval = setInterval(() => {
      const now = new Date();
      setDismissedAlerts(prev => {
        const newSet = new Set(prev);
        let hasChanges = false;
        
        alerts.forEach(alert => {
          if (new Date(alert.expires_at) <= now && newSet.has(alert.id)) {
            newSet.delete(alert.id);
            hasChanges = true;
          }
        });
        
        return hasChanges ? newSet : prev;
      });
    }, 1000);

    return () => clearInterval(interval);
  }, [alerts]);

  if (!user || !activeAlert) {
    return null;
  }

  return (
    <PanicAlertOverlay
      alert={activeAlert}
      onDismiss={() => handleDismiss(activeAlert.id)}
    />
  );
};

export default GlobalPanicAlerts;
