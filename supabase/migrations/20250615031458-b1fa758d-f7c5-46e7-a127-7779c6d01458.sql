
-- Crear tabla para las alertas Amber
CREATE TABLE public.amber_alerts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  child_full_name TEXT NOT NULL,
  child_nickname TEXT,
  child_photo_url TEXT,
  last_seen_location TEXT NOT NULL,
  disappearance_time TIMESTAMP WITH TIME ZONE NOT NULL,
  medical_conditions TEXT,
  contact_number TEXT NOT NULL,
  additional_details TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  resolved_at TIMESTAMP WITH TIME ZONE,
  resolved_by UUID REFERENCES auth.users(id)
);

-- Habilitar RLS
ALTER TABLE public.amber_alerts ENABLE ROW LEVEL SECURITY;

-- Política para que todos los usuarios autenticados puedan ver las alertas activas
CREATE POLICY "Usuarios pueden ver alertas Amber activas"
  ON public.amber_alerts FOR SELECT
  TO authenticated
  USING (is_active = true);

-- Política para que los usuarios puedan crear alertas Amber
CREATE POLICY "Usuarios pueden crear alertas Amber"
  ON public.amber_alerts FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- Política para que los usuarios puedan resolver alertas Amber
CREATE POLICY "Usuarios pueden resolver alertas Amber"
  ON public.amber_alerts FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Habilitar realtime para esta tabla
ALTER TABLE public.amber_alerts REPLICA IDENTITY FULL;
ALTER PUBLICATION supabase_realtime ADD TABLE public.amber_alerts;

-- Crear bucket para fotos de niños desaparecidos
INSERT INTO storage.buckets (id, name, public)
VALUES ('amber-alert-photos', 'amber-alert-photos', true);

-- Políticas para el bucket de fotos
CREATE POLICY "Usuarios pueden subir fotos para alertas Amber"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'amber-alert-photos');

CREATE POLICY "Usuarios pueden ver fotos de alertas Amber"
ON storage.objects FOR SELECT
TO authenticated
USING (bucket_id = 'amber-alert-photos');
