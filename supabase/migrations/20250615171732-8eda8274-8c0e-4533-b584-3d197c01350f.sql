
-- Crear tabla para almacenar reportes generados
CREATE TABLE public.generated_reports (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    report_type VARCHAR(50) NOT NULL, -- 'monthly', 'weekly', 'custom', 'incident_summary'
    generated_by UUID REFERENCES auth.users(id) ON DELETE SET NULL,
    date_range_start DATE,
    date_range_end DATE,
    filters JSONB, -- Para almacenar filtros aplicados (categorías, barrios, etc.)
    google_sheets_url TEXT, -- URL del sheet de Google generado
    google_chart_url TEXT, -- URL del gráfico de Google generado
    pdf_url TEXT, -- URL del PDF generado
    status VARCHAR(20) DEFAULT 'generating', -- 'generating', 'completed', 'failed'
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Crear tabla para configuraciones de reportes automáticos
CREATE TABLE public.report_schedules (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    report_type VARCHAR(50) NOT NULL,
    frequency VARCHAR(20) NOT NULL, -- 'daily', 'weekly', 'monthly'
    filters JSONB,
    created_by UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    is_active BOOLEAN DEFAULT true,
    last_generated_at TIMESTAMP WITH TIME ZONE,
    next_generation_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Crear tabla para métricas y estadísticas
CREATE TABLE public.report_metrics (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    report_id UUID REFERENCES public.generated_reports(id) ON DELETE CASCADE,
    metric_name VARCHAR(100) NOT NULL,
    metric_value NUMERIC,
    metric_type VARCHAR(50), -- 'count', 'percentage', 'average', 'total'
    category VARCHAR(100), -- Para agrupar métricas
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Habilitar RLS en las nuevas tablas
ALTER TABLE public.generated_reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.report_schedules ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.report_metrics ENABLE ROW LEVEL SECURITY;

-- Políticas RLS para generated_reports
-- Admins pueden ver todos los reportes
CREATE POLICY "Admins can view all generated reports"
ON public.generated_reports
FOR SELECT
TO authenticated
USING (public.is_admin(auth.uid()));

-- Líderes comunitarios pueden ver reportes que ellos generaron
CREATE POLICY "Community leaders can view their reports"
ON public.generated_reports
FOR SELECT
TO authenticated
USING (generated_by = auth.uid() AND public.has_role(auth.uid(), 'community_leader'));

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
    (generated_by = auth.uid() AND public.has_role(auth.uid(), 'community_leader'))
);

-- Políticas RLS para report_schedules
CREATE POLICY "Admins can manage all schedules"
ON public.report_schedules
FOR ALL
TO authenticated
USING (public.is_admin(auth.uid()))
WITH CHECK (public.is_admin(auth.uid()));

CREATE POLICY "Leaders can manage their schedules"
ON public.report_schedules
FOR ALL
TO authenticated
USING (created_by = auth.uid() AND public.has_role(auth.uid(), 'community_leader'))
WITH CHECK (created_by = auth.uid() AND public.has_role(auth.uid(), 'community_leader'));

-- Políticas RLS para report_metrics
CREATE POLICY "Users can view metrics of accessible reports"
ON public.report_metrics
FOR SELECT
TO authenticated
USING (
    EXISTS (
        SELECT 1 FROM public.generated_reports gr
        WHERE gr.id = report_metrics.report_id
        AND (
            public.is_admin(auth.uid()) OR
            (gr.generated_by = auth.uid() AND public.has_role(auth.uid(), 'community_leader'))
        )
    )
);

CREATE POLICY "Admins and leaders can create metrics"
ON public.report_metrics
FOR INSERT
TO authenticated
WITH CHECK (
    public.is_admin(auth.uid()) OR 
    public.has_role(auth.uid(), 'community_leader')
);

-- Crear función para generar reportes automáticos
CREATE OR REPLACE FUNCTION public.generate_scheduled_reports()
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    schedule_record RECORD;
    reports_generated INTEGER := 0;
BEGIN
    -- Buscar reportes programados que necesitan ser generados
    FOR schedule_record IN 
        SELECT * FROM public.report_schedules
        WHERE is_active = true 
        AND (next_generation_at IS NULL OR next_generation_at <= now())
    LOOP
        -- Crear un nuevo reporte basado en la programación
        INSERT INTO public.generated_reports (
            title,
            description,
            report_type,
            generated_by,
            date_range_start,
            date_range_end,
            filters,
            status
        ) VALUES (
            schedule_record.name || ' - ' || to_char(now(), 'DD/MM/YYYY'),
            'Reporte generado automáticamente',
            schedule_record.report_type,
            schedule_record.created_by,
            CASE 
                WHEN schedule_record.frequency = 'daily' THEN current_date - interval '1 day'
                WHEN schedule_record.frequency = 'weekly' THEN current_date - interval '1 week'
                WHEN schedule_record.frequency = 'monthly' THEN current_date - interval '1 month'
            END,
            current_date,
            schedule_record.filters,
            'generating'
        );
        
        -- Actualizar las fechas de la programación
        UPDATE public.report_schedules
        SET 
            last_generated_at = now(),
            next_generation_at = CASE 
                WHEN frequency = 'daily' THEN now() + interval '1 day'
                WHEN frequency = 'weekly' THEN now() + interval '1 week'
                WHEN frequency = 'monthly' THEN now() + interval '1 month'
            END,
            updated_at = now()
        WHERE id = schedule_record.id;
        
        reports_generated := reports_generated + 1;
    END LOOP;
    
    RETURN reports_generated;
END;
$$;
