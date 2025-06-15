
-- Actualizar los reportes de prueba para remover las URLs de ejemplo y dejarlas como null
UPDATE public.generated_reports 
SET 
  google_sheets_url = NULL,
  google_chart_url = NULL,
  pdf_url = NULL
WHERE 
  google_sheets_url LIKE '%example%' OR 
  google_chart_url LIKE '%example%' OR
  pdf_url LIKE '%example%';
