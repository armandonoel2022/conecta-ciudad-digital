
-- Crear tabla de perfiles de usuarios
CREATE TABLE public.profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name TEXT,
  phone TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Crear enum para categorías de reportes
CREATE TYPE public.report_category AS ENUM (
  'basura',
  'iluminacion', 
  'baches',
  'seguridad',
  'otros'
);

-- Crear enum para estado de reportes
CREATE TYPE public.report_status AS ENUM (
  'pendiente',
  'en_proceso',
  'resuelto',
  'rechazado'
);

-- Crear tabla de reportes
CREATE TABLE public.reports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  category report_category NOT NULL,
  status report_status DEFAULT 'pendiente',
  latitude DECIMAL(10, 8),
  longitude DECIMAL(11, 8),
  image_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Habilitar RLS en todas las tablas
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reports ENABLE ROW LEVEL SECURITY;

-- Políticas RLS para perfiles
CREATE POLICY "Los usuarios pueden ver su propio perfil"
  ON public.profiles FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Los usuarios pueden actualizar su propio perfil"
  ON public.profiles FOR UPDATE
  USING (auth.uid() = id);

CREATE POLICY "Los usuarios pueden insertar su propio perfil"
  ON public.profiles FOR INSERT
  WITH CHECK (auth.uid() = id);

-- Políticas RLS para reportes
CREATE POLICY "Los usuarios pueden ver todos los reportes"
  ON public.reports FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Los usuarios pueden crear sus propios reportes"
  ON public.reports FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Los usuarios pueden actualizar sus propios reportes"
  ON public.reports FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id);

-- Función para crear perfil automáticamente cuando se registra un usuario
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email)
  );
  RETURN NEW;
END;
$$;

-- Trigger para crear perfil automáticamente
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
