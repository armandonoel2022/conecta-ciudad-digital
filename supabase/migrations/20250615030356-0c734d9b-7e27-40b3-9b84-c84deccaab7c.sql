
-- Crear tabla para las alertas de pánico
CREATE TABLE public.panic_alerts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  user_full_name TEXT NOT NULL,
  latitude DECIMAL(10, 8),
  longitude DECIMAL(11, 8),
  location_description TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  resolved_at TIMESTAMP WITH TIME ZONE,
  resolved_by UUID REFERENCES auth.users(id)
);

-- Habilitar RLS
ALTER TABLE public.panic_alerts ENABLE ROW LEVEL SECURITY;

-- Política para que todos los usuarios autenticados puedan ver las alertas activas
CREATE POLICY "Usuarios pueden ver alertas activas de pánico"
  ON public.panic_alerts FOR SELECT
  TO authenticated
  USING (is_active = true);

-- Política para que los usuarios puedan crear sus propias alertas
CREATE POLICY "Usuarios pueden crear alertas de pánico"
  ON public.panic_alerts FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- Política para que los usuarios puedan resolver alertas (marcarlas como no activas)
CREATE POLICY "Usuarios pueden resolver alertas de pánico"
  ON public.panic_alerts FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Habilitar realtime para esta tabla
ALTER TABLE public.panic_alerts REPLICA IDENTITY FULL;
ALTER PUBLICATION supabase_realtime ADD TABLE public.panic_alerts;
