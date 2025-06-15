
-- Enable RLS on amber_alerts table
ALTER TABLE public.amber_alerts ENABLE ROW LEVEL SECURITY;

-- Allow users to view all active amber alerts (public safety feature)
CREATE POLICY "Anyone can view active amber alerts" 
  ON public.amber_alerts 
  FOR SELECT 
  USING (is_active = true);

-- Allow users to create their own amber alerts
CREATE POLICY "Users can create their own amber alerts" 
  ON public.amber_alerts 
  FOR INSERT 
  WITH CHECK (auth.uid() = user_id);

-- Allow users to update their own amber alerts
CREATE POLICY "Users can update their own amber alerts" 
  ON public.amber_alerts 
  FOR UPDATE 
  USING (auth.uid() = user_id);

-- Allow users to view their own amber alerts (including resolved ones)
CREATE POLICY "Users can view their own amber alerts" 
  ON public.amber_alerts 
  FOR SELECT 
  USING (auth.uid() = user_id);
