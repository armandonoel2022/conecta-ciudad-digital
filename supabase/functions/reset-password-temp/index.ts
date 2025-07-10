import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const { email } = await req.json()

    if (!email) {
      return new Response(
        JSON.stringify({ error: 'Email es requerido' }),
        { 
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
          status: 400 
        }
      )
    }

    // Generate unique temporary password
    const tempPassword = generateTemporaryPassword()

    // Create admin client
    const supabaseAdmin = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // Call the database function to reset password
    const { data, error } = await supabaseAdmin.rpc('reset_user_password_with_temp', {
      user_email: email,
      temp_password: tempPassword
    })

    if (error) {
      console.error('Error resetting password:', error)
      return new Response(
        JSON.stringify({ error: 'Error al restablecer contraseña' }),
        { 
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
          status: 500 
        }
      )
    }

    if (!data.success) {
      return new Response(
        JSON.stringify({ error: data.error }),
        { 
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
          status: 400 
        }
      )
    }

    return new Response(
      JSON.stringify({ 
        success: true, 
        tempPassword: tempPassword,
        message: 'Contraseña temporal generada exitosamente'
      }),
      { 
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      }
    )

  } catch (error) {
    console.error('Error in reset-password-temp function:', error)
    return new Response(
      JSON.stringify({ error: 'Error interno del servidor' }),
      { 
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 500 
      }
    )
  }
})

function generateTemporaryPassword(): string {
  const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789'
  const specialChars = '!@#$%&*'
  
  let password = ''
  
  // Add at least one uppercase, one lowercase, one number, one special char
  password += chars.charAt(Math.floor(Math.random() * 26)) // uppercase
  password += chars.charAt(Math.floor(Math.random() * 26) + 26) // lowercase  
  password += chars.charAt(Math.floor(Math.random() * 10) + 52) // number
  password += specialChars.charAt(Math.floor(Math.random() * specialChars.length))
  
  // Fill the rest randomly
  for (let i = 4; i < 12; i++) {
    const allChars = chars + specialChars
    password += allChars.charAt(Math.floor(Math.random() * allChars.length))
  }
  
  // Shuffle the password
  return password.split('').sort(() => Math.random() - 0.5).join('')
}