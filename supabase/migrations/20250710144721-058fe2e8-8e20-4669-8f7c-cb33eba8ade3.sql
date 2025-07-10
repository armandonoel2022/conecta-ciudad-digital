-- Allow admins to delete user profiles
-- This will enable the delete functionality for admin users

-- Create RLS policy for admins to delete profiles
CREATE POLICY "Admins can delete profiles" 
ON public.profiles 
FOR DELETE 
USING (is_admin(auth.uid()));

-- Create RLS policy for admins to delete user roles when deleting users
CREATE POLICY "Admins can delete user roles" 
ON public.user_roles 
FOR DELETE 
USING (is_admin(auth.uid()));

-- Create function to safely delete a user and all their data
CREATE OR REPLACE FUNCTION public.delete_user_completely(user_id_to_delete uuid)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  current_user_id uuid;
BEGIN
  -- Get the current user ID
  current_user_id := auth.uid();
  
  -- Check if current user is admin
  IF NOT is_admin(current_user_id) THEN
    RAISE EXCEPTION 'Only admins can delete users';
  END IF;
  
  -- Check if trying to delete yourself
  IF current_user_id = user_id_to_delete THEN
    RAISE EXCEPTION 'Cannot delete your own account';
  END IF;
  
  -- Delete user data in order (respecting foreign key constraints)
  DELETE FROM public.garbage_payments WHERE user_id = user_id_to_delete;
  DELETE FROM public.garbage_bills WHERE user_id = user_id_to_delete;
  DELETE FROM public.help_messages WHERE user_id = user_id_to_delete;
  DELETE FROM public.job_applications WHERE user_id = user_id_to_delete;
  DELETE FROM public.message_recipients WHERE user_id = user_id_to_delete;
  DELETE FROM public.message_weekly_limits WHERE user_id = user_id_to_delete;
  DELETE FROM public.community_messages WHERE created_by = user_id_to_delete;
  DELETE FROM public.before_after_videos WHERE user_id = user_id_to_delete;
  DELETE FROM public.amber_alerts WHERE user_id = user_id_to_delete;
  DELETE FROM public.panic_alerts WHERE user_id = user_id_to_delete;
  DELETE FROM public.reports WHERE user_id = user_id_to_delete;
  DELETE FROM public.generated_reports WHERE generated_by = user_id_to_delete;
  DELETE FROM public.report_schedules WHERE created_by = user_id_to_delete;
  DELETE FROM public.global_test_notifications WHERE triggered_by = user_id_to_delete;
  
  -- Delete user roles
  DELETE FROM public.user_roles WHERE user_id = user_id_to_delete;
  
  -- Delete profile
  DELETE FROM public.profiles WHERE id = user_id_to_delete;
  
  -- Delete from auth.users (this will cascade to other auth-related tables)
  DELETE FROM auth.users WHERE id = user_id_to_delete;
  
  RETURN true;
END;
$$;