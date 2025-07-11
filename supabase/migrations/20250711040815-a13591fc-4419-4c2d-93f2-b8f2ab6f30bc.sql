-- Actualizar coordenadas más precisas usando referencias específicas mencionadas por el usuario
-- Los Mina: Hospital San Lorenzo de Los Mina como referencia
-- Gazcue: Centro de Tecnología Universal (Centu) como referencia  
-- Alma Rosa: SDM Sistemas como referencia

-- Actualizar Los Mina con coordenadas más precisas del Hospital San Lorenzo
UPDATE reports 
SET 
  latitude = 18.485,
  longitude = -69.856,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%mina%' OR address ILIKE '%mina%';

-- Actualizar Gazcue con coordenadas precisas de Wikipedia/Centu
UPDATE reports 
SET 
  latitude = 18.500,
  longitude = -69.983,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%gazcue%' OR address ILIKE '%gazcue%';

-- Actualizar Alma Rosa con coordenadas estimadas del área
UPDATE reports 
SET 
  latitude = 18.500,
  longitude = -69.850,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%alma rosa%' OR address ILIKE '%alma rosa%';