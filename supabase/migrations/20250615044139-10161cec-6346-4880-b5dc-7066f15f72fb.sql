
-- Eliminar la política restrictiva actual
DROP POLICY IF EXISTS "Usuarios pueden resolver alertas de pánico" ON public.panic_alerts;

-- Crear nueva política que permite a cualquier usuario autenticado resolver alertas activas
CREATE POLICY "Cualquier usuario puede resolver alertas de pánico activas"
  ON public.panic_alerts FOR UPDATE
  TO authenticated
  USING (is_active = true)
  WITH CHECK (true);
