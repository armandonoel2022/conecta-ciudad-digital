-- Agregar restricciones de unicidad para prevenir registros duplicados
-- Email ya tiene unicidad en auth.users por defecto

-- Agregar restricción de unicidad para el teléfono (cuando no sea nulo)
ALTER TABLE public.profiles 
ADD CONSTRAINT profiles_phone_unique 
UNIQUE (phone) DEFERRABLE INITIALLY DEFERRED;

-- Agregar restricción de unicidad para el número de documento (cuando no sea nulo)  
ALTER TABLE public.profiles 
ADD CONSTRAINT profiles_document_number_unique 
UNIQUE (document_number) DEFERRABLE INITIALLY DEFERRED;