
-- Crear tabla para alertas de pánico
CREATE TABLE public.panic_alerts (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL,
  user_full_name TEXT NOT NULL,
  latitude NUMERIC,
  longitude NUMERIC,
  address TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  expires_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT (now() + INTERVAL '1 minute'),
  is_active BOOLEAN NOT NULL DEFAULT true
);

-- Habilitar Row Level Security
ALTER TABLE public.panic_alerts ENABLE ROW LEVEL SECURITY;

-- Política para que todos los usuarios autenticados puedan ver las alertas activas
CREATE POLICY "All authenticated users can view active alerts" 
  ON public.panic_alerts 
  FOR SELECT 
  TO authenticated
  USING (true);

-- Política para que los usuarios puedan crear sus propias alertas
CREATE POLICY "Users can create their own alerts" 
  ON public.panic_alerts 
  FOR INSERT 
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- Habilitar realtime para actualizaciones en tiempo real
ALTER TABLE public.panic_alerts REPLICA IDENTITY FULL;
ALTER PUBLICATION supabase_realtime ADD TABLE public.panic_alerts;

-- Función para desactivar alertas expiradas automáticamente
CREATE OR REPLACE FUNCTION public.deactivate_expired_panic_alerts()
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE public.panic_alerts 
  SET is_active = false 
  WHERE is_active = true 
  AND expires_at < now();
END;
$$;
