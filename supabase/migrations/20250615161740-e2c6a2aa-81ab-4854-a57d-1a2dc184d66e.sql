
-- Create a table for help messages
CREATE TABLE public.help_messages (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users NOT NULL,
  subject TEXT NOT NULL,
  message TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending',
  priority TEXT NOT NULL DEFAULT 'normal',
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  resolved_at TIMESTAMP WITH TIME ZONE,
  admin_response TEXT,
  user_email TEXT NOT NULL,
  user_full_name TEXT NOT NULL
);

-- Add Row Level Security (RLS)
ALTER TABLE public.help_messages ENABLE ROW LEVEL SECURITY;

-- Create policies for help messages
CREATE POLICY "Users can view their own help messages" 
  ON public.help_messages 
  FOR SELECT 
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create help messages" 
  ON public.help_messages 
  FOR INSERT 
  WITH CHECK (auth.uid() = user_id);

-- Create index for better performance
CREATE INDEX idx_help_messages_user_id ON public.help_messages(user_id);
CREATE INDEX idx_help_messages_status ON public.help_messages(status);
CREATE INDEX idx_help_messages_created_at ON public.help_messages(created_at DESC);
