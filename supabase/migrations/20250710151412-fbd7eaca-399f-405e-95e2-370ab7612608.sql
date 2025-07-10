-- Add field to track if user needs to change password
ALTER TABLE public.profiles 
ADD COLUMN must_change_password BOOLEAN DEFAULT FALSE;

-- Create edge function to reset user password with temporary password
CREATE OR REPLACE FUNCTION public.reset_user_password_with_temp(user_email TEXT, temp_password TEXT)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  user_id UUID;
  result JSON;
BEGIN
  -- Find user by email
  SELECT id INTO user_id 
  FROM auth.users 
  WHERE email = user_email;
  
  IF user_id IS NULL THEN
    RETURN JSON_BUILD_OBJECT('success', false, 'error', 'Usuario no encontrado');
  END IF;
  
  -- Update user password in auth.users
  UPDATE auth.users 
  SET 
    encrypted_password = crypt(temp_password, gen_salt('bf')),
    updated_at = now()
  WHERE id = user_id;
  
  -- Mark user as needing password change
  INSERT INTO public.profiles (id, must_change_password)
  VALUES (user_id, true)
  ON CONFLICT (id) 
  DO UPDATE SET 
    must_change_password = true,
    updated_at = now();
  
  RETURN JSON_BUILD_OBJECT('success', true, 'message', 'Contraseña temporal establecida');
END;
$$;