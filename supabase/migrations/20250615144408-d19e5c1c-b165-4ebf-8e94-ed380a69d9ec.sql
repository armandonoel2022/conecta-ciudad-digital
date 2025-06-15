
-- Crear bucket para videos de antes y después
INSERT INTO storage.buckets (id, name, public)
VALUES ('before-after-videos', 'before-after-videos', true);

-- Crear políticas para el bucket de videos
CREATE POLICY "Allow public access to before-after videos"
ON storage.objects FOR SELECT
USING (bucket_id = 'before-after-videos');

CREATE POLICY "Allow authenticated users to upload before-after videos"
ON storage.objects FOR INSERT
WITH CHECK (bucket_id = 'before-after-videos' AND auth.role() = 'authenticated');

CREATE POLICY "Allow users to update their own before-after videos"
ON storage.objects FOR UPDATE
USING (bucket_id = 'before-after-videos' AND auth.uid()::text = (storage.foldername(name))[1]);

CREATE POLICY "Allow users to delete their own before-after videos"
ON storage.objects FOR DELETE
USING (bucket_id = 'before-after-videos' AND auth.uid()::text = (storage.foldername(name))[1]);

-- Crear tabla para almacenar información de los videos
CREATE TABLE public.before_after_videos (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  video_url TEXT NOT NULL,
  file_name TEXT NOT NULL,
  file_size INTEGER,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Habilitar RLS en la tabla
ALTER TABLE public.before_after_videos ENABLE ROW LEVEL SECURITY;

-- Crear políticas RLS
CREATE POLICY "Users can view all before-after videos"
  ON public.before_after_videos
  FOR SELECT
  USING (true);

CREATE POLICY "Users can create their own before-after videos"
  ON public.before_after_videos
  FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own before-after videos"
  ON public.before_after_videos
  FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own before-after videos"
  ON public.before_after_videos
  FOR DELETE
  USING (auth.uid() = user_id);
