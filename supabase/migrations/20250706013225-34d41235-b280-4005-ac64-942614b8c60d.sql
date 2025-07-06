-- Primero, asignar el rol community_user a todos los usuarios existentes que no tienen roles
INSERT INTO user_roles (user_id, role, assigned_by, is_active)
SELECT 
  p.id,
  'community_user'::app_role,
  '51d869f4-fa16-4633-9121-561817fce43d', -- ID del admin actual
  true
FROM profiles p
WHERE p.id NOT IN (
  SELECT DISTINCT user_id 
  FROM user_roles 
  WHERE is_active = true
);

-- Crear función para asignar automáticamente rol community_user a usuarios nuevos
CREATE OR REPLACE FUNCTION public.assign_default_role()
RETURNS TRIGGER AS $$
BEGIN
  -- Asignar rol community_user por defecto a usuarios nuevos
  INSERT INTO public.user_roles (user_id, role, is_active)
  VALUES (NEW.id, 'community_user', true);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Crear trigger para ejecutar la función cuando se crea un nuevo perfil
CREATE OR REPLACE TRIGGER on_profile_created
  AFTER INSERT ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION public.assign_default_role();