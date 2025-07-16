import { useEffect, useState } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from '@/hooks/useAuth';

export const useAutoBilling = () => {
  const { user } = useAuth();
  const [isProcessing, setIsProcessing] = useState(false);
  const [lastRun, setLastRun] = useState<Date | null>(null);

  useEffect(() => {
    const runAutoBilling = async () => {
      if (!user) return;

      // Only run once per session and only if last run was more than 1 hour ago
      const now = new Date();
      if (lastRun && now.getTime() - lastRun.getTime() < 60 * 60 * 1000) {
        return;
      }

      setIsProcessing(true);
      
      try {
        console.log('Running auto-billing manager...');
        
        const { data, error } = await supabase.functions.invoke('auto-billing-manager');
        
        if (error) {
          console.error('Error in auto-billing:', error);
        } else {
          console.log('Auto-billing completed:', data);
          setLastRun(now);
        }
      } catch (error) {
        console.error('Error running auto-billing:', error);
      } finally {
        setIsProcessing(false);
      }
    };

    // Run on mount and then every 30 minutes
    runAutoBilling();
    const interval = setInterval(runAutoBilling, 30 * 60 * 1000);

    return () => clearInterval(interval);
  }, [user, lastRun]);

  return { isProcessing, lastRun };
};