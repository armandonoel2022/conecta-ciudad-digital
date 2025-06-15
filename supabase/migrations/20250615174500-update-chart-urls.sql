
-- Actualizar las URLs de gráficos con enlaces que funcionen
UPDATE public.generated_reports 
SET google_chart_url = CASE 
  WHEN title = 'Reporte de Prueba con Enlaces Funcionales' THEN 
    'https://docs.google.com/presentation/d/1BNK8Q7NiIsHi4nDlNPZ4vOzrqJ1L9WmhUDw8w1zFJ2g/edit'
  WHEN title = 'Reporte Semanal - Datos Actualizados' THEN 
    'https://docs.google.com/presentation/d/1EAYk18WDjIG-zp_0vLm3CsfQh_i8eXhPSx4XY9xEpJM/edit'
  WHEN title = 'Análisis de Incidencias - Q2 2025' THEN 
    'https://docs.google.com/presentation/d/1-MoQHIr8wVLlcY4oAx2ewilXBMfXNhm5U7kpLc5qOMg/edit'
  ELSE google_chart_url
END
WHERE title IN (
  'Reporte de Prueba con Enlaces Funcionales',
  'Reporte Semanal - Datos Actualizados', 
  'Análisis de Incidencias - Q2 2025'
);
