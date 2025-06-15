
import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from '@/hooks/useAuth';

export interface HelpMessage {
  id: string;
  user_id: string;
  subject: string;
  message: string;
  status: string;
  priority: string;
  created_at: string;
  updated_at: string;
  resolved_at: string | null;
  admin_response: string | null;
  user_email: string;
  user_full_name: string;
}

export const useHelpMessages = () => {
  const [messages, setMessages] = useState<HelpMessage[]>([]);
  const [loading, setLoading] = useState(true);
  const { user } = useAuth();

  const fetchMessages = async () => {
    if (!user) return;
    
    try {
      const { data, error } = await supabase
        .from('help_messages')
        .select('*')
        .eq('user_id', user.id)
        .order('created_at', { ascending: false });

      if (error) throw error;
      setMessages(data || []);
    } catch (error) {
      console.error('Error fetching help messages:', error);
    } finally {
      setLoading(false);
    }
  };

  const createHelpMessage = async (messageData: {
    subject: string;
    message: string;
    priority?: string;
  }) => {
    if (!user) throw new Error('User not authenticated');

    // Get user profile for full name
    const { data: profile } = await supabase
      .from('profiles')
      .select('full_name, first_name, last_name')
      .eq('id', user.id)
      .single();

    const fullName = profile?.full_name || 
                    `${profile?.first_name || ''} ${profile?.last_name || ''}`.trim() || 
                    user.email || 'Usuario';

    const { data, error } = await supabase
      .from('help_messages')
      .insert({
        user_id: user.id,
        subject: messageData.subject,
        message: messageData.message,
        priority: messageData.priority || 'normal',
        user_email: user.email || '',
        user_full_name: fullName,
      })
      .select()
      .single();

    if (error) throw error;
    return data;
  };

  useEffect(() => {
    fetchMessages();
  }, [user]);

  return {
    messages,
    loading,
    createHelpMessage,
    refetch: fetchMessages,
  };
};
