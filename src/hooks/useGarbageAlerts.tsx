
import { useState, useEffect } from 'react';

export const useGarbageAlerts = () => {
  const [showAlert, setShowAlert] = useState(false);

  const isWithinActiveHours = () => {
    const now = new Date();
    const hour = now.getHours();
    // Activo entre 6:00 AM (6) y 6:00 PM (18)
    return hour >= 6 && hour < 18;
  };

  const isGarbageDay = () => {
    const now = new Date();
    const dayOfWeek = now.getDay(); // 0 = Sunday, 1 = Monday, etc.
    // Check if it's Monday (1), Wednesday (3), or Friday (5)
    return dayOfWeek === 1 || dayOfWeek === 3 || dayOfWeek === 5;
  };

  useEffect(() => {
    const checkGarbageDay = () => {
      if (isGarbageDay() && isWithinActiveHours()) {
        setShowAlert(true);
        console.log('Garbage collection day and within active hours - showing alert');
      }
    };

    // Check immediately
    checkGarbageDay();

    // Set interval to check every 3 hours (as specified)
    const interval = setInterval(checkGarbageDay, 3 * 60 * 60 * 1000);

    return () => clearInterval(interval);
  }, []);

  const dismissAlert = () => {
    setShowAlert(false);
    
    // Don't show again for 3 hours
    setTimeout(() => {
      if (isGarbageDay() && isWithinActiveHours()) {
        setShowAlert(true);
      }
    }, 3 * 60 * 60 * 1000);
  };

  // Función para probar la alerta manualmente
  const triggerTestAlert = () => {
    setShowAlert(true);
    console.log('Test alert triggered manually');
  };

  return {
    showAlert,
    dismissAlert,
    triggerTestAlert
  };
};
