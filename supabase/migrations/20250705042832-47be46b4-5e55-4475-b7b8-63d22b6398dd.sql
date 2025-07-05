-- Crear tabla para notificaciones globales de prueba
CREATE TABLE public.global_test_notifications (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  notification_type TEXT NOT NULL,
  triggered_by UUID REFERENCES auth.users(id) NOT NULL,
  triggered_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  expires_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT (now() + INTERVAL '30 seconds'),
  is_active BOOLEAN NOT NULL DEFAULT true,
  message TEXT
);

-- Habilitar RLS
ALTER TABLE public.global_test_notifications ENABLE ROW LEVEL SECURITY;

-- Política para que todos puedan ver las notificaciones activas
CREATE POLICY "Everyone can view active test notifications" 
ON public.global_test_notifications 
FOR SELECT 
USING (is_active = true AND expires_at > now());

-- Política para que solo admins puedan crear notificaciones
CREATE POLICY "Only admins can create test notifications" 
ON public.global_test_notifications 
FOR INSERT 
WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- Habilitar realtime
ALTER TABLE public.global_test_notifications REPLICA IDENTITY FULL;
ALTER PUBLICATION supabase_realtime ADD TABLE public.global_test_notifications;

-- Función para limpiar notificaciones expiradas
CREATE OR REPLACE FUNCTION public.deactivate_expired_test_notifications()
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE public.global_test_notifications 
  SET is_active = false 
  WHERE is_active = true 
  AND expires_at < now();
END;
$$;