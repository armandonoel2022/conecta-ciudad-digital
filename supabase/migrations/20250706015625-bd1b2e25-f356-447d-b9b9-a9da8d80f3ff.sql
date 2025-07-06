-- Insertar rol de administrador para Ruth Esther Santana de Noel
INSERT INTO public.user_roles (user_id, role, assigned_by, is_active)
VALUES (
    'e953b9ba-10a2-4efe-a8c6-f89590cbda92',
    'admin',
    '368be064-a35c-4b1b-9996-cf24dd021282',
    true
)
ON CONFLICT (user_id, role) 
DO UPDATE SET 
    is_active = true,
    assigned_at = now();