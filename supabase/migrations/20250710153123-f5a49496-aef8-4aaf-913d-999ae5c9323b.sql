-- Crear tabla para almacenar configuración de 2FA
CREATE TABLE public.user_2fa (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  secret TEXT NOT NULL,
  enabled BOOLEAN NOT NULL DEFAULT false,
  backup_codes TEXT[], -- Códigos de respaldo
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  last_used_at TIMESTAMP WITH TIME ZONE,
  
  UNIQUE(user_id)
);

-- Habilitar RLS
ALTER TABLE public.user_2fa ENABLE ROW LEVEL SECURITY;

-- Políticas de seguridad
CREATE POLICY "Users can view their own 2FA config" 
ON public.user_2fa 
FOR SELECT 
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own 2FA config" 
ON public.user_2fa 
FOR INSERT 
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own 2FA config" 
ON public.user_2fa 
FOR UPDATE 
USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own 2FA config" 
ON public.user_2fa 
FOR DELETE 
USING (auth.uid() = user_id);

-- Función para actualizar updated_at
CREATE OR REPLACE FUNCTION public.update_user_2fa_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para actualizar updated_at automáticamente
CREATE TRIGGER update_user_2fa_updated_at
  BEFORE UPDATE ON public.user_2fa
  FOR EACH ROW
  EXECUTE FUNCTION public.update_user_2fa_updated_at();