
-- Eliminar todas las políticas existentes para panic_alerts
DROP POLICY IF EXISTS "Permitir resolver alertas activas" ON public.panic_alerts;
DROP POLICY IF EXISTS "Cualquier usuario puede resolver alertas de pánico activas" ON public.panic_alerts;
DROP POLICY IF EXISTS "Usuarios pueden resolver alertas de pánico" ON public.panic_alerts;

-- Crear una política completamente permisiva para UPDATE
CREATE POLICY "Usuarios autenticados pueden actualizar alertas"
  ON public.panic_alerts FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);
