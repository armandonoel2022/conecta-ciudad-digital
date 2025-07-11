-- Crear tabla para configuración de alertas de basura
CREATE TABLE public.garbage_alert_configs (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  sector TEXT NOT NULL,
  municipality TEXT NOT NULL DEFAULT 'Medellín',
  province TEXT NOT NULL DEFAULT 'Antioquia',
  days_of_week INTEGER[] NOT NULL DEFAULT '{1,3,5}', -- Lunes, Miércoles, Viernes
  frequency_hours INTEGER NOT NULL DEFAULT 3, -- Cada 3 horas
  start_hour INTEGER NOT NULL DEFAULT 6, -- 6:00 AM
  end_hour INTEGER NOT NULL DEFAULT 18, -- 6:00 PM
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  created_by UUID NULL
);

-- Enable RLS
ALTER TABLE public.garbage_alert_configs ENABLE ROW LEVEL SECURITY;

-- Crear políticas RLS
CREATE POLICY "Solo admins pueden gestionar configuraciones de alertas"
ON public.garbage_alert_configs
FOR ALL
USING (is_admin(auth.uid()))
WITH CHECK (is_admin(auth.uid()));

-- Crear función para actualizar updated_at
CREATE OR REPLACE FUNCTION public.update_garbage_alert_configs_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear trigger para actualizar timestamps
CREATE TRIGGER update_garbage_alert_configs_updated_at
BEFORE UPDATE ON public.garbage_alert_configs
FOR EACH ROW
EXECUTE FUNCTION public.update_garbage_alert_configs_updated_at();

-- Insertar configuración por defecto
INSERT INTO public.garbage_alert_configs (
  sector,
  municipality,
  province,
  days_of_week,
  frequency_hours,
  start_hour,
  end_hour
) VALUES (
  'General',
  'Medellín',
  'Antioquia',
  '{1,3,5}',
  3,
  6,
  18
);