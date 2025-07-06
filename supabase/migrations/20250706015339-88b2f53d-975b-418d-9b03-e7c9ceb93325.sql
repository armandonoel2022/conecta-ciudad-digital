-- Desactivar todos los roles existentes de Ruth Esther Santana de Noel
UPDATE public.user_roles 
SET is_active = false 
WHERE user_id = 'e953b9ba-10a2-4efe-a8c6-f89590cbda92' 
AND is_active = true;

-- Asignar rol de administrador a Ruth Esther Santana de Noel
INSERT INTO public.user_roles (user_id, role, assigned_by, is_active)
VALUES (
    'e953b9ba-10a2-4efe-a8c6-f89590cbda92',
    'admin',
    (SELECT id FROM auth.users WHERE email = 'armandonoel@outlook.com' LIMIT 1),
    true
);