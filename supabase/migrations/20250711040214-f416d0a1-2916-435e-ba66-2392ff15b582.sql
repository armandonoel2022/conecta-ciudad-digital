-- Actualizar las coordenadas de Los Mina/Los Minas con las coordenadas correctas
-- Los Mina: 18.4769° N, 69.8605° W

UPDATE reports 
SET 
  latitude = 18.4769,
  longitude = -69.8605,
  updated_at = now()
WHERE 
  neighborhood ILIKE '%mina%' OR address ILIKE '%mina%';