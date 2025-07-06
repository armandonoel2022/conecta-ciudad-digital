-- Crear política para que los administradores puedan ver todos los perfiles
CREATE POLICY "Admins can view all profiles" 
ON public.profiles 
FOR SELECT 
USING (is_admin(auth.uid()));

-- Crear política para que los líderes comunitarios puedan ver todos los perfiles
CREATE POLICY "Community leaders can view all profiles" 
ON public.profiles 
FOR SELECT 
USING (has_role(auth.uid(), 'community_leader'::app_role));