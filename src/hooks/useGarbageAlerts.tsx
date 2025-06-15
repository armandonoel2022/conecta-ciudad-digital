
import { useState, useEffect } from 'react';

export const useGarbageAlerts = () => {
  const [showAlert, setShowAlert] = useState(false);

  useEffect(() => {
    const checkGarbageDay = () => {
      const now = new Date();
      const dayOfWeek = now.getDay(); // 0 = Sunday, 1 = Monday, etc.
      
      // Check if it's Monday (1), Wednesday (3), or Friday (5)
      const isGarbageDay = dayOfWeek === 1 || dayOfWeek === 3 || dayOfWeek === 5;
      
      if (isGarbageDay) {
        setShowAlert(true);
        console.log('Garbage collection day - showing alert');
      }
    };

    // Check immediately
    checkGarbageDay();

    // Set interval to check every 3 hours (3 * 60 * 60 * 1000 ms)
    const interval = setInterval(checkGarbageDay, 3 * 60 * 60 * 1000);

    return () => clearInterval(interval);
  }, []);

  const dismissAlert = () => {
    setShowAlert(false);
    
    // Don't show again for 3 hours
    setTimeout(() => {
      const now = new Date();
      const dayOfWeek = now.getDay();
      const isGarbageDay = dayOfWeek === 1 || dayOfWeek === 3 || dayOfWeek === 5;
      
      if (isGarbageDay) {
        setShowAlert(true);
      }
    }, 3 * 60 * 60 * 1000);
  };

  return {
    showAlert,
    dismissAlert
  };
};
