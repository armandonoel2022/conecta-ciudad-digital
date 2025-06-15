
-- Actualizar el perfil del usuario con los nombres y apellidos separados
-- Asumiendo que el usuario actual es el que necesita la actualización
UPDATE public.profiles 
SET 
  first_name = 'Armando',
  last_name = 'Noel Charle'
WHERE full_name IS NOT NULL 
  AND first_name IS NULL 
  AND last_name IS NULL
  AND full_name LIKE '%Armando%';

-- Si no funciona el query anterior, podemos usar este más específico
-- (ejecutar solo si el anterior no actualiza ningún registro)
UPDATE public.profiles 
SET 
  first_name = 'Armando',
  last_name = 'Noel Charle'
WHERE id IN (
  SELECT id 
  FROM profiles 
  WHERE first_name IS NULL 
  ORDER BY created_at DESC 
  LIMIT 1
);
