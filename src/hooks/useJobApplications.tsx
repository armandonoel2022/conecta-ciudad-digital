
import { useState } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from '@/hooks/useAuth';
import { toast } from 'sonner';

export interface JobApplication {
  id?: string;
  user_id?: string;
  full_name: string;
  email: string;
  phone: string;
  address?: string;
  birth_date?: string;
  document_type?: string;
  document_number?: string;
  education_level: string;
  institution_name?: string;
  career_field?: string;
  graduation_year?: number;
  additional_courses?: string;
  work_experience?: string;
  skills?: string;
  availability?: string;
  expected_salary?: string;
  cv_file_url?: string;
  cv_file_name?: string;
  status?: string;
  notes?: string;
  created_at?: string;
  updated_at?: string;
}

export const useJobApplications = () => {
  const { user } = useAuth();
  const queryClient = useQueryClient();
  const [isUploading, setIsUploading] = useState(false);

  const { data: applications, isLoading } = useQuery({
    queryKey: ['job-applications', user?.id],
    queryFn: async () => {
      if (!user?.id) return [];
      
      const { data, error } = await supabase
        .from('job_applications')
        .select('*')
        .eq('user_id', user.id)
        .order('created_at', { ascending: false });
      
      if (error) throw error;
      return data as JobApplication[];
    },
    enabled: !!user?.id,
  });

  const createApplication = useMutation({
    mutationFn: async (application: Omit<JobApplication, 'id' | 'user_id' | 'created_at' | 'updated_at'>) => {
      if (!user?.id) throw new Error('User not authenticated');
      
      const { data, error } = await supabase
        .from('job_applications')
        .insert({
          ...application,
          user_id: user.id,
        })
        .select()
        .single();
      
      if (error) throw error;
      return data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['job-applications'] });
      toast.success('Aplicación enviada exitosamente');
    },
    onError: (error) => {
      console.error('Error creating job application:', error);
      toast.error('Error al enviar la aplicación');
    },
  });

  const uploadCV = async (file: File): Promise<{ url: string; name: string }> => {
    if (!user?.id) throw new Error('User not authenticated');
    
    setIsUploading(true);
    
    try {
      const fileExt = file.name.split('.').pop();
      const fileName = `${user.id}/${Date.now()}.${fileExt}`;
      
      const { error: uploadError } = await supabase.storage
        .from('cv-files')
        .upload(fileName, file);
      
      if (uploadError) throw uploadError;
      
      const { data: { publicUrl } } = supabase.storage
        .from('cv-files')
        .getPublicUrl(fileName);
      
      return { url: publicUrl, name: file.name };
    } finally {
      setIsUploading(false);
    }
  };

  return {
    applications,
    isLoading,
    createApplication,
    uploadCV,
    isUploading,
  };
};
