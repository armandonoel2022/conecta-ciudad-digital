-- Activar el rol de administrador existente para Ruth Esther Santana de Noel
UPDATE public.user_roles 
SET is_active = true 
WHERE user_id = 'e953b9ba-10a2-4efe-a8c6-f89590cbda92' 
AND role = 'admin';