
-- Crear el enum para los roles de la aplicación
CREATE TYPE public.app_role AS ENUM ('admin', 'community_leader', 'community_user');

-- Crear la tabla para asignar roles a los usuarios
CREATE TABLE public.user_roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    role app_role NOT NULL,
    assigned_by UUID REFERENCES auth.users(id) ON DELETE SET NULL,
    assigned_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
    is_active BOOLEAN NOT NULL DEFAULT true,
    UNIQUE (user_id, role)
);

-- Habilitar Row Level Security
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

-- Crear función de seguridad para verificar roles sin recursividad
CREATE OR REPLACE FUNCTION public.has_role(_user_id UUID, _role app_role)
RETURNS BOOLEAN
LANGUAGE SQL
STABLE
SECURITY DEFINER
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.user_roles
    WHERE user_id = _user_id
      AND role = _role
      AND is_active = true
  )
$$;

-- Crear función para verificar si un usuario es admin
CREATE OR REPLACE FUNCTION public.is_admin(_user_id UUID)
RETURNS BOOLEAN
LANGUAGE SQL
STABLE
SECURITY DEFINER
AS $$
  SELECT public.has_role(_user_id, 'admin')
$$;

-- Políticas RLS para user_roles
-- Los admins pueden ver todos los roles
CREATE POLICY "Admins can view all user roles"
ON public.user_roles
FOR SELECT
TO authenticated
USING (public.is_admin(auth.uid()));

-- Los usuarios pueden ver sus propios roles
CREATE POLICY "Users can view their own roles"
ON public.user_roles
FOR SELECT
TO authenticated
USING (user_id = auth.uid());

-- Solo los admins pueden insertar/actualizar roles
CREATE POLICY "Only admins can manage user roles"
ON public.user_roles
FOR ALL
TO authenticated
USING (public.is_admin(auth.uid()))
WITH CHECK (public.is_admin(auth.uid()));

-- Asignar rol de admin al primer usuario (opcional - para facilitar desarrollo)
-- Este INSERT se ejecutará solo si no hay usuarios con rol admin
INSERT INTO public.user_roles (user_id, role, assigned_by)
SELECT 
    (SELECT id FROM auth.users ORDER BY created_at LIMIT 1),
    'admin'::app_role,
    (SELECT id FROM auth.users ORDER BY created_at LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM public.user_roles WHERE role = 'admin'::app_role AND is_active = true
);
