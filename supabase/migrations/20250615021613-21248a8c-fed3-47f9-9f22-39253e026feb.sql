
-- Agregar columnas separadas para nombres y apellidos
ALTER TABLE public.profiles 
ADD COLUMN first_name TEXT,
ADD COLUMN last_name TEXT,
ADD COLUMN document_type TEXT CHECK (document_type IN ('cedula', 'pasaporte', 'tarjeta_identidad')),
ADD COLUMN document_number TEXT,
ADD COLUMN address TEXT,
ADD COLUMN neighborhood TEXT,
ADD COLUMN city TEXT DEFAULT 'Medellín',
ADD COLUMN birth_date DATE,
ADD COLUMN gender TEXT CHECK (gender IN ('masculino', 'femenino', 'otro', 'prefiero_no_decir'));

-- Agregar campos adicionales a la tabla de reportes para mejor análisis
ALTER TABLE public.reports
ADD COLUMN address TEXT,
ADD COLUMN neighborhood TEXT,
ADD COLUMN priority TEXT CHECK (priority IN ('baja', 'media', 'alta', 'critica')) DEFAULT 'media',
ADD COLUMN resolved_at TIMESTAMP WITH TIME ZONE,
ADD COLUMN assigned_to UUID,
ADD COLUMN resolution_notes TEXT,
ADD COLUMN citizen_satisfaction INTEGER CHECK (citizen_satisfaction >= 1 AND citizen_satisfaction <= 5);

-- Actualizar la función para manejar nombres separados
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, first_name, last_name)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email),
    NEW.raw_user_meta_data->>'first_name',
    NEW.raw_user_meta_data->>'last_name'
  );
  RETURN NEW;
END;
$$;

-- Crear índices para mejorar rendimiento en consultas de reportes
CREATE INDEX IF NOT EXISTS idx_reports_category ON public.reports(category);
CREATE INDEX IF NOT EXISTS idx_reports_status ON public.reports(status);
CREATE INDEX IF NOT EXISTS idx_reports_created_at ON public.reports(created_at);
CREATE INDEX IF NOT EXISTS idx_reports_neighborhood ON public.reports(neighborhood);
CREATE INDEX IF NOT EXISTS idx_reports_priority ON public.reports(priority);
CREATE INDEX IF NOT EXISTS idx_profiles_neighborhood ON public.profiles(neighborhood);
