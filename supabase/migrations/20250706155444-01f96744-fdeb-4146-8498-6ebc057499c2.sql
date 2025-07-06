-- Create community messages table for leaders to send messages to their community
CREATE TABLE public.community_messages (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  created_by UUID NOT NULL,
  title TEXT NOT NULL,
  message TEXT NOT NULL,
  image_url TEXT,
  sector TEXT,
  municipality TEXT NOT NULL,
  province TEXT NOT NULL,
  scheduled_at TIMESTAMP WITH TIME ZONE,
  sent_at TIMESTAMP WITH TIME ZONE,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Enable RLS
ALTER TABLE public.community_messages ENABLE ROW LEVEL SECURITY;

-- Create policies for community messages
CREATE POLICY "Community leaders can create messages" 
ON public.community_messages 
FOR INSERT 
WITH CHECK (has_role(auth.uid(), 'community_leader'::app_role) OR is_admin(auth.uid()));

CREATE POLICY "Community leaders can view their own messages" 
ON public.community_messages 
FOR SELECT 
USING (created_by = auth.uid() AND (has_role(auth.uid(), 'community_leader'::app_role) OR is_admin(auth.uid())));

CREATE POLICY "Admins can view all messages" 
ON public.community_messages 
FOR SELECT 
USING (is_admin(auth.uid()));

CREATE POLICY "Community leaders can update their own messages" 
ON public.community_messages 
FOR UPDATE 
USING (created_by = auth.uid() AND (has_role(auth.uid(), 'community_leader'::app_role) OR is_admin(auth.uid())));

CREATE POLICY "Admins can update all messages" 
ON public.community_messages 
FOR UPDATE 
USING (is_admin(auth.uid()));

CREATE POLICY "Community leaders can delete their own messages" 
ON public.community_messages 
FOR DELETE 
USING (created_by = auth.uid() AND (has_role(auth.uid(), 'community_leader'::app_role) OR is_admin(auth.uid())));

CREATE POLICY "Admins can delete all messages" 
ON public.community_messages 
FOR DELETE 
USING (is_admin(auth.uid()));

-- Create message recipients table to track who receives the messages
CREATE TABLE public.message_recipients (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  message_id UUID NOT NULL REFERENCES public.community_messages(id) ON DELETE CASCADE,
  user_id UUID NOT NULL,
  delivered_at TIMESTAMP WITH TIME ZONE,
  read_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Enable RLS for message recipients
ALTER TABLE public.message_recipients ENABLE ROW LEVEL SECURITY;

-- Create policies for message recipients
CREATE POLICY "Users can view messages sent to them" 
ON public.message_recipients 
FOR SELECT 
USING (auth.uid() = user_id);

CREATE POLICY "System can insert message recipients" 
ON public.message_recipients 
FOR INSERT 
WITH CHECK (true);

CREATE POLICY "Users can update their own message status" 
ON public.message_recipients 
FOR UPDATE 
USING (auth.uid() = user_id);

-- Create a table to track weekly message limits
CREATE TABLE public.message_weekly_limits (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL,
  week_start DATE NOT NULL,
  message_count INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  UNIQUE(user_id, week_start)
);

-- Enable RLS for weekly limits
ALTER TABLE public.message_weekly_limits ENABLE ROW LEVEL SECURITY;

-- Create policies for weekly limits
CREATE POLICY "Users can view their own weekly limits" 
ON public.message_weekly_limits 
FOR SELECT 
USING (auth.uid() = user_id);

CREATE POLICY "System can manage weekly limits" 
ON public.message_weekly_limits 
FOR ALL 
USING (true) 
WITH CHECK (true);

-- Create function to check weekly message limit
CREATE OR REPLACE FUNCTION public.check_weekly_message_limit(_user_id uuid)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  current_week_start DATE;
  message_count INTEGER;
BEGIN
  -- Calculate the start of the current week (Monday)
  current_week_start := date_trunc('week', CURRENT_DATE)::DATE;
  
  -- Get the current week's message count
  SELECT COALESCE(message_count, 0) INTO message_count
  FROM public.message_weekly_limits
  WHERE user_id = _user_id AND week_start = current_week_start;
  
  -- Return true if under the limit (3 messages per week)
  RETURN COALESCE(message_count, 0) < 3;
END;
$$;

-- Create function to increment weekly message count
CREATE OR REPLACE FUNCTION public.increment_weekly_message_count(_user_id uuid)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  current_week_start DATE;
BEGIN
  -- Calculate the start of the current week (Monday)
  current_week_start := date_trunc('week', CURRENT_DATE)::DATE;
  
  -- Insert or update the weekly count
  INSERT INTO public.message_weekly_limits (user_id, week_start, message_count)
  VALUES (_user_id, current_week_start, 1)
  ON CONFLICT (user_id, week_start)
  DO UPDATE SET 
    message_count = message_weekly_limits.message_count + 1,
    updated_at = now();
END;
$$;

-- Create trigger to check weekly limit before inserting messages
CREATE OR REPLACE FUNCTION public.check_message_limit_trigger()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  -- Check if user has role to send messages
  IF NOT (has_role(NEW.created_by, 'community_leader'::app_role) OR is_admin(NEW.created_by)) THEN
    RAISE EXCEPTION 'User does not have permission to send community messages';
  END IF;
  
  -- Check weekly limit (admins are exempt)
  IF NOT is_admin(NEW.created_by) AND NOT check_weekly_message_limit(NEW.created_by) THEN
    RAISE EXCEPTION 'Weekly message limit exceeded. Maximum 3 messages per week allowed.';
  END IF;
  
  -- Increment the weekly count
  PERFORM increment_weekly_message_count(NEW.created_by);
  
  RETURN NEW;
END;
$$;

-- Create the trigger
CREATE TRIGGER check_community_message_limit
  BEFORE INSERT ON public.community_messages
  FOR EACH ROW
  EXECUTE FUNCTION public.check_message_limit_trigger();

-- Create function to update timestamps
CREATE OR REPLACE FUNCTION public.update_community_messages_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;

-- Create trigger for updating timestamps
CREATE TRIGGER update_community_messages_updated_at
  BEFORE UPDATE ON public.community_messages
  FOR EACH ROW
  EXECUTE FUNCTION public.update_community_messages_updated_at();

-- Create storage bucket for community message images
INSERT INTO storage.buckets (id, name, public) VALUES ('community-messages', 'community-messages', true);

-- Create storage policies for community message images
CREATE POLICY "Community leaders can upload message images" 
ON storage.objects 
FOR INSERT 
WITH CHECK (bucket_id = 'community-messages' AND (
  EXISTS (
    SELECT 1 FROM public.user_roles ur 
    WHERE ur.user_id = auth.uid() 
    AND ur.role IN ('community_leader', 'admin') 
    AND ur.is_active = true
  )
));

CREATE POLICY "Community message images are publicly viewable" 
ON storage.objects 
FOR SELECT 
USING (bucket_id = 'community-messages');

CREATE POLICY "Community leaders can update their message images" 
ON storage.objects 
FOR UPDATE 
USING (bucket_id = 'community-messages' AND (
  EXISTS (
    SELECT 1 FROM public.user_roles ur 
    WHERE ur.user_id = auth.uid() 
    AND ur.role IN ('community_leader', 'admin') 
    AND ur.is_active = true
  )
));

CREATE POLICY "Community leaders can delete their message images" 
ON storage.objects 
FOR DELETE 
USING (bucket_id = 'community-messages' AND (
  EXISTS (
    SELECT 1 FROM public.user_roles ur 
    WHERE ur.user_id = auth.uid() 
    AND ur.role IN ('community_leader', 'admin') 
    AND ur.is_active = true
  )
));