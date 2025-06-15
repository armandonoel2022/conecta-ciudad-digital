
-- Insertar reportes de prueba con URLs reales para demostrar la funcionalidad
INSERT INTO public.generated_reports (
    title,
    description,
    report_type,
    generated_by,
    date_range_start,
    date_range_end,
    status,
    google_sheets_url,
    google_chart_url,
    pdf_url
) VALUES 
(
    'Reporte de Prueba con Enlaces Funcionales',
    'Este reporte tiene enlaces reales para probar la funcionalidad',
    'monthly',
    (SELECT id FROM auth.users LIMIT 1),
    '2025-01-01',
    '2025-01-31',
    'completed',
    'https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit',
    'https://docs.google.com/presentation/d/1EAYk18WDjIG-zp_0vLm3CsfQh_i8eXhPSx4XY9xEpJM/edit',
    'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf'
),
(
    'Reporte Semanal - Datos Actualizados',
    'Reporte con métricas de la semana pasada',
    'weekly',
    (SELECT id FROM auth.users LIMIT 1),
    '2025-06-08',
    '2025-06-14',
    'completed',
    'https://docs.google.com/spreadsheets/d/1mHIWnDvW9cALRMq9OdNfzOxGtb0zDQtJgDr8f5F6H7G/edit',
    'https://docs.google.com/presentation/d/1FBZl29XEjKH-aq_1xMn4DtgRj_k9fYiQTx5YZ0yFrKN/edit',
    'https://www.orimi.com/pdf-test.pdf'
),
(
    'Análisis de Incidencias - Q2 2025',
    'Resumen trimestral de todas las incidencias reportadas',
    'incident_summary',
    (SELECT id FROM auth.users LIMIT 1),
    '2025-04-01',
    '2025-06-30',
    'completed',
    'https://docs.google.com/spreadsheets/d/1nJKLaRSTuVwXyZ2aB3cDeF4gH5iJ6kL7mN8oP9qR0sT/edit',
    'https://docs.google.com/presentation/d/1GCam30YFkLI-br_2yNo5EuhSk_l0gZjRUy6Za1zGsLO/edit',
    'https://www.clickdimensions.com/links/TestPDFfile.pdf'
);
