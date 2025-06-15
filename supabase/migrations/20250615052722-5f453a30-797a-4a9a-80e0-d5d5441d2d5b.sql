
-- Eliminar todas las políticas RLS de la tabla panic_alerts
DROP POLICY IF EXISTS "Usuarios pueden ver alertas activas de pánico" ON public.panic_alerts;
DROP POLICY IF EXISTS "Usuarios pueden crear alertas de pánico" ON public.panic_alerts;
DROP POLICY IF EXISTS "Usuarios pueden resolver alertas de pánico" ON public.panic_alerts;
DROP POLICY IF EXISTS "Permitir resolver alertas activas" ON public.panic_alerts;
DROP POLICY IF EXISTS "Cualquier usuario puede resolver alertas de pánico activas" ON public.panic_alerts;
DROP POLICY IF EXISTS "Usuarios autenticados pueden actualizar alertas" ON public.panic_alerts;

-- Remover la tabla de la publicación de realtime (sin IF EXISTS)
ALTER PUBLICATION supabase_realtime DROP TABLE public.panic_alerts;

-- Eliminar la tabla de panic_alerts
DROP TABLE IF EXISTS public.panic_alerts;
