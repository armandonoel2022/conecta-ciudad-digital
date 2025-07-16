-- Arreglar la función generate_bill_number que tiene error con LPAD
CREATE OR REPLACE FUNCTION public.generate_bill_number()
RETURNS text
LANGUAGE plpgsql
AS $$
DECLARE
  current_year TEXT;
  sequence_num TEXT;
  next_number INTEGER;
BEGIN
  current_year := EXTRACT(YEAR FROM NOW())::TEXT;
  
  -- Obtener el siguiente número de secuencia
  SELECT COALESCE(MAX(CAST(SUBSTRING(bill_number FROM 6) AS INTEGER)), 0) + 1 
  INTO next_number
  FROM garbage_bills 
  WHERE bill_number LIKE current_year || '-%';
  
  -- Formatear el número con ceros a la izquierda usando LPAD con cast explícito
  sequence_num := LPAD(next_number::TEXT, 6, '0');
  
  RETURN current_year || '-' || sequence_num;
END;
$$;