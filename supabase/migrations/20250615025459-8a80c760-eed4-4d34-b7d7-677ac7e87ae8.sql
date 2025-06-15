
-- Crear tabla para facturas de basura
CREATE TABLE public.garbage_bills (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users NOT NULL,
  bill_number TEXT NOT NULL UNIQUE,
  billing_period_start DATE NOT NULL,
  billing_period_end DATE NOT NULL,
  amount_due INTEGER NOT NULL, -- En centavos para evitar problemas de precisión
  due_date DATE NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'paid', 'overdue', 'cancelled')),
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Crear tabla para pagos de basura
CREATE TABLE public.garbage_payments (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users NOT NULL,
  bill_id UUID REFERENCES public.garbage_bills(id) NOT NULL,
  stripe_session_id TEXT UNIQUE,
  amount_paid INTEGER NOT NULL, -- En centavos
  payment_method TEXT DEFAULT 'stripe',
  payment_status TEXT NOT NULL DEFAULT 'pending' CHECK (payment_status IN ('pending', 'completed', 'failed', 'refunded')),
  payment_date TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Habilitar Row Level Security
ALTER TABLE public.garbage_bills ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.garbage_payments ENABLE ROW LEVEL SECURITY;

-- Políticas para facturas - usuarios solo pueden ver sus propias facturas
CREATE POLICY "Users can view their own bills" 
  ON public.garbage_bills 
  FOR SELECT 
  USING (auth.uid() = user_id);

CREATE POLICY "Service can insert bills" 
  ON public.garbage_bills 
  FOR INSERT 
  WITH CHECK (true);

CREATE POLICY "Service can update bills" 
  ON public.garbage_bills 
  FOR UPDATE 
  USING (true);

-- Políticas para pagos - usuarios solo pueden ver sus propios pagos
CREATE POLICY "Users can view their own payments" 
  ON public.garbage_payments 
  FOR SELECT 
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own payments" 
  ON public.garbage_payments 
  FOR INSERT 
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Service can update payments" 
  ON public.garbage_payments 
  FOR UPDATE 
  USING (true);

-- Función para generar número de factura automático
CREATE OR REPLACE FUNCTION generate_bill_number()
RETURNS TEXT AS $$
DECLARE
  current_year TEXT;
  sequence_num TEXT;
BEGIN
  current_year := EXTRACT(YEAR FROM NOW())::TEXT;
  sequence_num := LPAD((SELECT COALESCE(MAX(CAST(SUBSTRING(bill_number FROM 6) AS INTEGER)), 0) + 1 
                       FROM garbage_bills 
                       WHERE bill_number LIKE current_year || '-%'), 6, '0');
  RETURN current_year || '-' || sequence_num;
END;
$$ LANGUAGE plpgsql;

-- Trigger para auto-generar número de factura
CREATE OR REPLACE FUNCTION set_bill_number()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.bill_number IS NULL OR NEW.bill_number = '' THEN
    NEW.bill_number := generate_bill_number();
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_set_bill_number
  BEFORE INSERT ON public.garbage_bills
  FOR EACH ROW
  EXECUTE FUNCTION set_bill_number();

-- Función para generar facturas automáticamente (simulación)
CREATE OR REPLACE FUNCTION generate_monthly_bills()
RETURNS INTEGER AS $$
DECLARE
  user_record RECORD;
  bills_generated INTEGER := 0;
  current_month_start DATE;
  current_month_end DATE;
  due_date DATE;
  base_amount INTEGER := 150000; -- $1,500 pesos en centavos
BEGIN
  -- Calcular fechas del mes actual
  current_month_start := DATE_TRUNC('month', CURRENT_DATE);
  current_month_end := (DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month - 1 day')::DATE;
  due_date := current_month_end + INTERVAL '15 days';
  
  -- Generar facturas para usuarios que no tienen factura del mes actual
  FOR user_record IN 
    SELECT DISTINCT p.id 
    FROM profiles p
    WHERE p.first_name IS NOT NULL 
    AND p.last_name IS NOT NULL
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
      base_amount + (RANDOM() * 50000)::INTEGER, -- Variación de ±$500
      due_date,
      'pending'
    );
    
    bills_generated := bills_generated + 1;
  END LOOP;
  
  RETURN bills_generated;
END;
$$ LANGUAGE plpgsql;
