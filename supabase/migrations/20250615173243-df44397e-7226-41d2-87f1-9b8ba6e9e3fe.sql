
-- Eliminar políticas existentes si existen
DROP POLICY IF EXISTS "Admins can view all generated reports" ON public.generated_reports;
DROP POLICY IF EXISTS "Community leaders can view their reports" ON public.generated_reports;
DROP POLICY IF EXISTS "Admins and leaders can create reports" ON public.generated_reports;
DROP POLICY IF EXISTS "Admins and leaders can update reports" ON public.generated_reports;
DROP POLICY IF EXISTS "Users can view metrics of accessible reports" ON public.report_metrics;
DROP POLICY IF EXISTS "Admins and leaders can create metrics" ON public.report_metrics;

-- Crear políticas RLS mejoradas para generated_reports
-- Los administradores pueden ver todos los reportes
CREATE POLICY "Admins can view all generated reports"
ON public.generated_reports
FOR SELECT
TO authenticated
USING (public.is_admin(auth.uid()));

-- Los líderes comunitarios pueden ver todos los reportes (no solo los suyos)
CREATE POLICY "Community leaders can view all reports"
ON public.generated_reports
FOR SELECT
TO authenticated
USING (public.has_role(auth.uid(), 'community_leader'));

-- Solo admins y líderes comunitarios pueden crear reportes
CREATE POLICY "Admins and leaders can create reports"
ON public.generated_reports
FOR INSERT
TO authenticated
WITH CHECK (
    public.is_admin(auth.uid()) OR 
    public.has_role(auth.uid(), 'community_leader')
);

-- Solo admins y líderes comunitarios pueden actualizar reportes
CREATE POLICY "Admins and leaders can update reports"
ON public.generated_reports
FOR UPDATE
TO authenticated
USING (
    public.is_admin(auth.uid()) OR 
    public.has_role(auth.uid(), 'community_leader')
);

-- Solo admins y líderes comunitarios pueden eliminar reportes
CREATE POLICY "Admins and leaders can delete reports"
ON public.generated_reports
FOR DELETE
TO authenticated
USING (
    public.is_admin(auth.uid()) OR 
    public.has_role(auth.uid(), 'community_leader')
);

-- Actualizar políticas para report_metrics
CREATE POLICY "Users can view metrics of accessible reports"
ON public.report_metrics
FOR SELECT
TO authenticated
USING (
    public.is_admin(auth.uid()) OR 
    public.has_role(auth.uid(), 'community_leader')
);

CREATE POLICY "Admins and leaders can create metrics"
ON public.report_metrics
FOR INSERT
TO authenticated
WITH CHECK (
    public.is_admin(auth.uid()) OR 
    public.has_role(auth.uid(), 'community_leader')
);

-- Insertar algunos reportes de prueba para verificar que funciona
INSERT INTO public.generated_reports (
    title,
    description,
    report_type,
    generated_by,
    date_range_start,
    date_range_end,
    status,
    google_sheets_url,
    google_chart_url
) VALUES 
(
    'Reporte Mensual de Incidencias - Enero 2025',
    'Resumen de todas las incidencias reportadas durante enero 2025',
    'monthly',
    auth.uid(),
    '2025-01-01',
    '2025-01-31',
    'completed',
    'https://docs.google.com/spreadsheets/d/example1',
    'https://docs.google.com/presentation/d/example1'
),
(
    'Reporte Semanal de Limpieza - Semana 3',
    'Análisis de servicios de limpieza y recolección de basura',
    'weekly',
    auth.uid(),
    '2025-01-15',
    '2025-01-21',
    'completed',
    'https://docs.google.com/spreadsheets/d/example2',
    'https://docs.google.com/presentation/d/example2'
),
(
    'Reporte en Proceso',
    'Este reporte está siendo generado actualmente',
    'custom',
    auth.uid(),
    '2025-01-01',
    '2025-01-15',
    'generating',
    null,
    null
);
