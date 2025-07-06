import { useState, useEffect } from 'react';
import { useAuth } from '@/hooks/useAuth';
import { supabase } from '@/integrations/supabase/client';

export interface CommunityMessage {
  id: string;
  created_by: string;
  title: string;
  message: string;
  image_url?: string;
  sector?: string;
  municipality: string;
  province: string;
  scheduled_at?: string;
  sent_at?: string;
  is_active: boolean;
  created_at: string;
  updated_at: string;
}

export interface CreateMessageData {
  title: string;
  message: string;
  image_url?: string;
  sector?: string;
  municipality: string;
  province: string;
  scheduled_at?: string;
}

export interface WeeklyLimit {
  message_count: number;
  week_start: string;
}

export const useCommunityMessages = () => {
  const { user } = useAuth();
  const [messages, setMessages] = useState<CommunityMessage[]>([]);
  const [weeklyLimit, setWeeklyLimit] = useState<WeeklyLimit | null>(null);
  const [loading, setLoading] = useState(false);

  const fetchMessages = async () => {
    if (!user) return;

    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('community_messages')
        .select('*')
        .order('created_at', { ascending: false });

      if (error) throw error;
      setMessages(data || []);
    } catch (error) {
      console.error('Error fetching community messages:', error);
    } finally {
      setLoading(false);
    }
  };

  const fetchWeeklyLimit = async () => {
    if (!user) return;

    try {
      const currentWeekStart = new Date();
      currentWeekStart.setDate(currentWeekStart.getDate() - ((currentWeekStart.getDay() + 6) % 7));
      currentWeekStart.setHours(0, 0, 0, 0);
      
      const { data, error } = await supabase
        .from('message_weekly_limits')
        .select('*')
        .eq('user_id', user.id)
        .eq('week_start', currentWeekStart.toISOString().split('T')[0])
        .single();

      if (error && error.code !== 'PGRST116') {
        throw error;
      }

      setWeeklyLimit(data || { message_count: 0, week_start: currentWeekStart.toISOString().split('T')[0] });
    } catch (error) {
      console.error('Error fetching weekly limit:', error);
    }
  };

  const createMessage = async (messageData: CreateMessageData) => {
    if (!user) return null;

    setLoading(true);
    try {
      const { data, error } = await supabase
        .from('community_messages')
        .insert({
          created_by: user.id,
          ...messageData
        })
        .select()
        .single();

      if (error) throw error;
      
      // Refresh messages and weekly limit
      await Promise.all([fetchMessages(), fetchWeeklyLimit()]);
      
      return data;
    } catch (error) {
      console.error('Error creating community message:', error);
      throw error;
    } finally {
      setLoading(false);
    }
  };

  const updateMessage = async (id: string, messageData: Partial<CreateMessageData>) => {
    if (!user) return null;

    setLoading(true);
    try {
      const { data, error } = await supabase
        .from('community_messages')
        .update(messageData)
        .eq('id', id)
        .select()
        .single();

      if (error) throw error;
      
      // Refresh messages
      await fetchMessages();
      
      return data;
    } catch (error) {
      console.error('Error updating community message:', error);
      throw error;
    } finally {
      setLoading(false);
    }
  };

  const deleteMessage = async (id: string) => {
    if (!user) return;

    setLoading(true);
    try {
      const { error } = await supabase
        .from('community_messages')
        .delete()
        .eq('id', id);

      if (error) throw error;
      
      // Refresh messages
      await fetchMessages();
    } catch (error) {
      console.error('Error deleting community message:', error);
      throw error;
    } finally {
      setLoading(false);
    }
  };

  const uploadImage = async (file: File): Promise<string> => {
    try {
      const fileExt = file.name.split('.').pop();
      const fileName = `${Date.now()}.${fileExt}`;
      const filePath = `messages/${fileName}`;

      const { error: uploadError } = await supabase.storage
        .from('community-messages')
        .upload(filePath, file);

      if (uploadError) throw uploadError;

      const { data: { publicUrl } } = supabase.storage
        .from('community-messages')
        .getPublicUrl(filePath);

      return publicUrl;
    } catch (error) {
      console.error('Error uploading image:', error);
      throw error;
    }
  };

  const canSendMessage = () => {
    return !weeklyLimit || weeklyLimit.message_count < 3;
  };

  const getRemainingMessages = () => {
    if (!weeklyLimit) return 3;
    return Math.max(0, 3 - weeklyLimit.message_count);
  };

  useEffect(() => {
    if (user) {
      fetchMessages();
      fetchWeeklyLimit();
    }
  }, [user]);

  return {
    messages,
    weeklyLimit,
    loading,
    createMessage,
    updateMessage,
    deleteMessage,
    uploadImage,
    canSendMessage,
    getRemainingMessages,
    fetchMessages
  };
};