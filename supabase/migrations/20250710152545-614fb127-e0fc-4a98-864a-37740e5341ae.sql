-- Agregar restricciones de unicidad para prevenir registros duplicados
-- Primero eliminar duplicados existentes si los hay (el usuario ya los eliminó)

-- Agregar restricción de unicidad para el email en la tabla auth.users (ya existe)
-- Agregar restricciones de unicidad en la tabla profiles para teléfono y documento

-- Restricción de unicidad para el teléfono (cuando no sea nulo)
CREATE UNIQUE INDEX CONCURRENTLY idx_profiles_phone_unique 
ON public.profiles (phone) 
WHERE phone IS NOT NULL AND phone != '';

-- Restricción de unicidad para el número de documento (cuando no sea nulo)
CREATE UNIQUE INDEX CONCURRENTLY idx_profiles_document_unique 
ON public.profiles (document_number) 
WHERE document_number IS NOT NULL AND document_number != '';

-- Agregar restricciones de tabla basadas en los índices
ALTER TABLE public.profiles 
ADD CONSTRAINT profiles_phone_unique 
EXCLUDE USING btree (phone WITH =) 
WHERE (phone IS NOT NULL AND phone != '');

ALTER TABLE public.profiles 
ADD CONSTRAINT profiles_document_number_unique 
EXCLUDE USING btree (document_number WITH =) 
WHERE (document_number IS NOT NULL AND document_number != '');