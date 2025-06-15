
import { useState, useEffect } from 'react';
import { useAuth } from '@/hooks/useAuth';
import { supabase } from '@/integrations/supabase/client';

export const useProfileCheck = () => {
  const { user } = useAuth();
  const [isProfileComplete, setIsProfileComplete] = useState<boolean | null>(null);
  const [loading, setLoading] = useState(true);

  const checkProfile = async () => {
    if (!user) {
      setLoading(false);
      return;
    }

    try {
      const { data, error } = await supabase
        .from('profiles')
        .select('first_name, last_name, document_type, document_number, phone, address, neighborhood')
        .eq('id', user.id)
        .single();

      if (error) {
        console.error('Error checking profile:', error);
        setIsProfileComplete(false);
      } else {
        // Check if essential fields are filled
        const isComplete = !!(
          data.first_name &&
          data.last_name &&
          data.document_type &&
          data.document_number &&
          data.phone &&
          data.address &&
          data.neighborhood
        );
        console.log('Profile completeness check:', { data, isComplete });
        setIsProfileComplete(isComplete);
      }
    } catch (error) {
      console.error('Error checking profile:', error);
      setIsProfileComplete(false);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    checkProfile();
  }, [user]);

  // Return the check function so it can be called manually
  return { isProfileComplete, loading, refetchProfile: checkProfile };
};
