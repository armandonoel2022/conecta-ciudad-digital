-- Actualizar la tabla job_applications para incluir los nuevos estados y respuestas
ALTER TABLE public.job_applications 
ADD COLUMN IF NOT EXISTS admin_response TEXT,
ADD COLUMN IF NOT EXISTS responded_at TIMESTAMP WITH TIME ZONE,
ADD COLUMN IF NOT EXISTS responded_by UUID;

-- Actualizar los posibles valores de status
ALTER TABLE public.job_applications 
ALTER COLUMN status SET DEFAULT 'pending';

-- Comentario sobre los estados disponibles:
-- 'pending' - Pendiente (estado inicial)
-- 'in_process' - En proceso
-- 'accepted' - Solicitud aceptada  
-- 'declined' - Solicitud declinada