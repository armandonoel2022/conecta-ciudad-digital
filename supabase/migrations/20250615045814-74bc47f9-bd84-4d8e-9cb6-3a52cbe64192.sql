
-- Eliminar la política existente que está causando problemas
DROP POLICY IF EXISTS "Cualquier usuario puede resolver alertas de pánico activas" ON public.panic_alerts;

-- Crear una nueva política más permisiva para resolver alertas
CREATE POLICY "Permitir resolver alertas activas"
  ON public.panic_alerts FOR UPDATE
  TO authenticated
  USING (is_active = true)
  WITH CHECK (
    -- Permite marcar como inactiva (resolved) cualquier alerta activa
    is_active = false OR 
    -- O permite actualizar otros campos si sigue activa
    is_active = true
  );
