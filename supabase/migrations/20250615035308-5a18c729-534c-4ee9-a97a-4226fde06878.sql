
-- Create a table for job applications
CREATE TABLE public.job_applications (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users NOT NULL,
  
  -- Personal Information
  full_name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT NOT NULL,
  address TEXT,
  birth_date DATE,
  document_type TEXT,
  document_number TEXT,
  
  -- Academic Information
  education_level TEXT NOT NULL,
  institution_name TEXT,
  career_field TEXT,
  graduation_year INTEGER,
  additional_courses TEXT,
  
  -- Professional Information
  work_experience TEXT,
  skills TEXT,
  availability TEXT,
  expected_salary TEXT,
  
  -- CV Upload
  cv_file_url TEXT,
  cv_file_name TEXT,
  
  -- Application Status
  status TEXT NOT NULL DEFAULT 'pending',
  notes TEXT,
  
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Add Row Level Security (RLS)
ALTER TABLE public.job_applications ENABLE ROW LEVEL SECURITY;

-- Create policies for job applications
CREATE POLICY "Users can view their own applications" 
  ON public.job_applications 
  FOR SELECT 
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own applications" 
  ON public.job_applications 
  FOR INSERT 
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own applications" 
  ON public.job_applications 
  FOR UPDATE 
  USING (auth.uid() = user_id);

-- Create storage bucket for CV files
INSERT INTO storage.buckets (id, name, public)
VALUES ('cv-files', 'cv-files', false);

-- Create storage policies for CV files
CREATE POLICY "Users can upload their own CV files"
  ON storage.objects FOR INSERT
  WITH CHECK (
    bucket_id = 'cv-files' AND
    auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "Users can view their own CV files"
  ON storage.objects FOR SELECT
  USING (
    bucket_id = 'cv-files' AND
    auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "Users can update their own CV files"
  ON storage.objects FOR UPDATE
  USING (
    bucket_id = 'cv-files' AND
    auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "Users can delete their own CV files"
  ON storage.objects FOR DELETE
  USING (
    bucket_id = 'cv-files' AND
    auth.uid()::text = (storage.foldername(name))[1]
  );
