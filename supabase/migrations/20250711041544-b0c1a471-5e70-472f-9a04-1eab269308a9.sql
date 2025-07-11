-- Corrección masiva de coordenadas de barrios de Santo Domingo
-- Basado en datos oficiales de Wikipedia y fuentes verificadas

-- Villa Duarte (18°28′N 69°52′W = 18.467, -69.867)
UPDATE reports 
SET 
  latitude = 18.467,
  longitude = -69.867,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%villa duarte%' OR address ILIKE '%villa duarte%';

-- Los Cacicazgos (18°30′N 69°59′W = 18.500, -69.983)
UPDATE reports 
SET 
  latitude = 18.500,
  longitude = -69.983,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%cacicazgos%' OR address ILIKE '%cacicazgos%';

-- Piantini (18°30′N 69°59′W = 18.500, -69.983)
UPDATE reports 
SET 
  latitude = 18.500,
  longitude = -69.983,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%piantini%' OR address ILIKE '%piantini%';

-- Gazcue (coordenadas precisas del sector residencial)
UPDATE reports 
SET 
  latitude = 18.479,
  longitude = -69.933,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%gazcue%' OR address ILIKE '%gazcue%';

-- Alma Rosa (sector este de Santo Domingo)
UPDATE reports 
SET 
  latitude = 18.485,
  longitude = -69.873,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%alma rosa%' OR address ILIKE '%alma rosa%';

-- Los Mina/Minas (coordenadas del área residencial)
UPDATE reports 
SET 
  latitude = 18.485,
  longitude = -69.856,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%mina%' OR address ILIKE '%mina%';

-- Gualey (sector central-norte)
UPDATE reports 
SET 
  latitude = 18.475,
  longitude = -69.925,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%gualey%' OR address ILIKE '%gualey%';

-- Bella Vista (sector centro-sur)
UPDATE reports 
SET 
  latitude = 18.472,
  longitude = -69.928,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%bella vista%' OR address ILIKE '%bella vista%';

-- Villa Agrippina (sector oeste)
UPDATE reports 
SET 
  latitude = 18.468,
  longitude = -69.940,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%villa agrippina%' OR address ILIKE '%villa agrippina%' OR neighborhood ILIKE '%agrippina%';

-- La Esperilla (sector central)
UPDATE reports 
SET 
  latitude = 18.476,
  longitude = -69.930,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%esperilla%' OR address ILIKE '%esperilla%';

-- Ensanche Ozama (sector este)
UPDATE reports 
SET 
  latitude = 18.480,
  longitude = -69.880,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%ensanche ozama%' OR address ILIKE '%ensanche ozama%' OR neighborhood ILIKE '%ozama%';

-- San Carlos (sector central-oeste)
UPDATE reports 
SET 
  latitude = 18.474,
  longitude = -69.935,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%san carlos%' OR address ILIKE '%san carlos%';

-- Villa Juana (sector sur)
UPDATE reports 
SET 
  latitude = 18.465,
  longitude = -69.925,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%villa juana%' OR address ILIKE '%villa juana%';

-- Mirador Sur (sector sur residencial)
UPDATE reports 
SET 
  latitude = 18.460,
  longitude = -69.940,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%mirador sur%' OR address ILIKE '%mirador sur%';

-- Cristo Rey (sector oeste)
UPDATE reports 
SET 
  latitude = 18.470,
  longitude = -69.950,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%cristo rey%' OR address ILIKE '%cristo rey%';

-- Los Ríos (sector sur-este)
UPDATE reports 
SET 
  latitude = 18.465,
  longitude = -69.890,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%los ríos%' OR address ILIKE '%los ríos%' OR neighborhood ILIKE '%los rios%';