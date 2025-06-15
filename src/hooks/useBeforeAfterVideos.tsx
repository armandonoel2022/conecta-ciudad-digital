
import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from './useAuth';
import { toast } from 'sonner';

interface BeforeAfterVideo {
  id: string;
  title: string;
  description: string | null;
  video_url: string;
  file_name: string;
  file_size: number | null;
  created_at: string;
  updated_at: string;
  user_id: string;
}

export const useBeforeAfterVideos = () => {
  const [videos, setVideos] = useState<BeforeAfterVideo[]>([]);
  const [loading, setLoading] = useState(true);
  const [uploading, setUploading] = useState(false);
  const { user } = useAuth();

  const fetchVideos = async () => {
    try {
      console.log('Fetching before-after videos...');
      const { data, error } = await supabase
        .from('before_after_videos')
        .select('*')
        .order('created_at', { ascending: false });

      if (error) throw error;

      console.log('Videos fetched:', data);
      setVideos(data || []);
    } catch (error) {
      console.error('Error fetching videos:', error);
      toast.error('Error al cargar los videos');
    } finally {
      setLoading(false);
    }
  };

  const uploadVideo = async (file: File, title: string, description?: string) => {
    if (!user) {
      toast.error('Debes estar autenticado para subir videos');
      return null;
    }

    setUploading(true);
    try {
      console.log('Starting video upload:', { fileName: file.name, size: file.size });

      // Upload file to storage
      const fileName = `${user.id}/${Date.now()}-${file.name}`;
      const { data: uploadData, error: uploadError } = await supabase.storage
        .from('before-after-videos')
        .upload(fileName, file);

      if (uploadError) {
        console.error('Upload error:', uploadError);
        throw uploadError;
      }

      console.log('File uploaded successfully:', uploadData);

      // Get public URL
      const { data: urlData } = supabase.storage
        .from('before-after-videos')
        .getPublicUrl(fileName);

      console.log('Public URL generated:', urlData.publicUrl);

      // Save video info to database
      const { data: videoData, error: dbError } = await supabase
        .from('before_after_videos')
        .insert({
          user_id: user.id,
          title,
          description: description || null,
          video_url: urlData.publicUrl,
          file_name: file.name,
          file_size: file.size,
        })
        .select()
        .single();

      if (dbError) {
        console.error('Database error:', dbError);
        throw dbError;
      }

      console.log('Video info saved to database:', videoData);
      toast.success('Video subido exitosamente');
      
      // Refresh videos list
      await fetchVideos();
      
      return videoData;
    } catch (error) {
      console.error('Error uploading video:', error);
      toast.error('Error al subir el video');
      return null;
    } finally {
      setUploading(false);
    }
  };

  const deleteVideo = async (videoId: string, fileName: string) => {
    if (!user) {
      toast.error('Debes estar autenticado para eliminar videos');
      return false;
    }

    try {
      console.log('Deleting video:', videoId);

      // Delete from storage
      const { error: storageError } = await supabase.storage
        .from('before-after-videos')
        .remove([`${user.id}/${fileName}`]);

      if (storageError) {
        console.error('Storage deletion error:', storageError);
      }

      // Delete from database
      const { error: dbError } = await supabase
        .from('before_after_videos')
        .delete()
        .eq('id', videoId);

      if (dbError) throw dbError;

      console.log('Video deleted successfully');
      toast.success('Video eliminado exitosamente');
      
      // Refresh videos list
      await fetchVideos();
      
      return true;
    } catch (error) {
      console.error('Error deleting video:', error);
      toast.error('Error al eliminar el video');
      return false;
    }
  };

  useEffect(() => {
    fetchVideos();
  }, []);

  return {
    videos,
    loading,
    uploading,
    uploadVideo,
    deleteVideo,
    refetch: fetchVideos,
  };
};
