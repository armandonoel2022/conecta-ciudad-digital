-- Crear función para marcar facturas como vencidas
CREATE OR REPLACE FUNCTION mark_overdue_bills()
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
  updated_count INTEGER := 0;
BEGIN
  -- Marcar como vencidas las facturas pendientes que pasaron su fecha de vencimiento
  UPDATE garbage_bills 
  SET 
    status = 'overdue',
    updated_at = now()
  WHERE 
    status = 'pending' 
    AND due_date < CURRENT_DATE;
  
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  
  RETURN updated_count;
END;
$$;

-- Crear función para generar facturas automáticamente
CREATE OR REPLACE FUNCTION auto_generate_monthly_bills()
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
  user_record RECORD;
  bills_generated INTEGER := 0;
  current_month_start DATE;
  current_month_end DATE;
  due_date DATE;
  base_amount INTEGER := 32500; -- $325 pesos en centavos
BEGIN
  -- Calcular fechas del mes actual
  current_month_start := DATE_TRUNC('month', CURRENT_DATE);
  current_month_end := (DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month - 1 day')::DATE;
  due_date := current_month_end + INTERVAL '15 days';
  
  -- Generar facturas para usuarios con perfil completo que no tienen factura del mes actual
  FOR user_record IN 
    SELECT DISTINCT p.id 
    FROM profiles p
    WHERE p.first_name IS NOT NULL 
    AND p.last_name IS NOT NULL
    AND p.phone IS NOT NULL
    AND p.address IS NOT NULL
    AND NOT EXISTS (
      SELECT 1 FROM garbage_bills gb 
      WHERE gb.user_id = p.id 
      AND gb.billing_period_start = current_month_start
    )
  LOOP
    INSERT INTO garbage_bills (
      user_id,
      billing_period_start,
      billing_period_end,
      amount_due,
      due_date,
      status
    ) VALUES (
      user_record.id,
      current_month_start,
      current_month_end,
      base_amount + (RANDOM() * 10000)::INTEGER, -- Variación de ±$100
      due_date,
      'pending'
    );
    
    bills_generated := bills_generated + 1;
  END LOOP;
  
  RETURN bills_generated;
END;
$$;