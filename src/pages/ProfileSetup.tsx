
import React, { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { useAuth } from '@/hooks/useAuth';
import { supabase } from '@/integrations/supabase/client';
import { useNavigate } from 'react-router-dom';
import { toast } from 'sonner';
import { ArrowRight, User } from 'lucide-react';

const profileSchema = z.object({
  first_name: z.string().min(2, 'Los nombres deben tener al menos 2 caracteres'),
  last_name: z.string().min(2, 'Los apellidos deben tener al menos 2 caracteres'),
  document_type: z.enum(['cedula', 'pasaporte', 'tarjeta_identidad'], {
    required_error: 'Selecciona un tipo de documento'
  }),
  document_number: z.string().regex(/^\d{3}-\d{7}-\d{1}$/, 'La cédula debe tener el formato 000-0000000-0'),
  phone_prefix: z.enum(['809', '829', '849'], {
    required_error: 'Selecciona un prefijo'
  }),
  phone: z.string().regex(/^\d{7}$/, 'El teléfono debe tener exactamente 7 dígitos'),
  address: z.string().min(5, 'La dirección debe tener al menos 5 caracteres'),
  neighborhood: z.string().min(2, 'Ingresa tu barrio'),
  birth_date: z.string().min(1, 'Selecciona tu fecha de nacimiento'),
  gender: z.enum(['masculino', 'femenino', 'otro', 'prefiero_no_decir'], {
    required_error: 'Selecciona tu género'
  })
});

type ProfileFormData = z.infer<typeof profileSchema>;

const ProfileSetup = () => {
  const { user } = useAuth();
  const navigate = useNavigate();
  
  const {
    register,
    handleSubmit,
    setValue,
    watch,
    formState: { errors, isSubmitting }
  } = useForm<ProfileFormData>({
    resolver: zodResolver(profileSchema),
    defaultValues: {
      phone_prefix: '809',
      first_name: user?.user_metadata?.first_name || '',
      last_name: user?.user_metadata?.last_name || ''
    }
  });

  // Pre-poblar los campos con datos del usuario si están disponibles
  useEffect(() => {
    if (user?.user_metadata) {
      const metadata = user.user_metadata;
      if (metadata.first_name) {
        setValue('first_name', metadata.first_name);
      }
      if (metadata.last_name) {
        setValue('last_name', metadata.last_name);
      }
      // Si hay teléfono en los metadatos, parsearlo
      if (metadata.phone) {
        const phone = metadata.phone.replace(/\D/g, ''); // Solo números
        if (phone.length >= 10) {
          // Asumiendo formato +1829XXXXXXX o similar
          const prefix = phone.slice(-10, -7); // Los 3 dígitos del prefijo
          const number = phone.slice(-7); // Los últimos 7 dígitos
          setValue('phone_prefix', prefix || '809');
          setValue('phone', number);
        }
      }
    }
  }, [user, setValue]);

  const formatCedula = (value: string) => {
    // Remove all non-digits
    const numbers = value.replace(/\D/g, '');
    
    // Apply format: 000-0000000-0
    if (numbers.length <= 3) {
      return numbers;
    } else if (numbers.length <= 10) {
      return `${numbers.slice(0, 3)}-${numbers.slice(3)}`;
    } else {
      return `${numbers.slice(0, 3)}-${numbers.slice(3, 10)}-${numbers.slice(10, 11)}`;
    }
  };

  const handleCedulaChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const formatted = formatCedula(e.target.value);
    setValue('document_number', formatted, { shouldValidate: true });
    // Force re-render to show the formatted value
    e.target.value = formatted;
  };

  const handlePhoneChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    // Only allow digits and limit to 7
    const numbers = e.target.value.replace(/\D/g, '').slice(0, 7);
    setValue('phone', numbers, { shouldValidate: true });
    // Force re-render to show the formatted value
    e.target.value = numbers;
  };

  const onSubmit = async (data: ProfileFormData) => {
    if (!user) return;

    try {
      const fullPhoneNumber = `+1${data.phone_prefix}${data.phone}`;
      
      console.log('Submitting profile data:', data);
      
      const { error } = await supabase
        .from('profiles')
        .update({
          first_name: data.first_name,
          last_name: data.last_name,
          document_type: data.document_type,
          document_number: data.document_number,
          phone: fullPhoneNumber,
          address: data.address,
          neighborhood: data.neighborhood,
          birth_date: data.birth_date,
          gender: data.gender,
          full_name: `${data.first_name} ${data.last_name}`,
          updated_at: new Date().toISOString()
        })
        .eq('id', user.id);

      if (error) {
        console.error('Error updating profile:', error);
        
        // Manejar errores específicos de duplicados
        if (error.code === '23505') {
          if (error.message.includes('profiles_phone_unique')) {
            toast.error('Este número de teléfono ya está registrado. Usa un número diferente.');
          } else if (error.message.includes('profiles_document_number_unique')) {
            toast.error('Este número de documento ya está registrado. Verifica tu información.');
          } else {
            toast.error('Ya existe un registro con esta información. Verifica tus datos.');
          }
        } else {
          toast.error('Error al guardar el perfil. Intenta nuevamente.');
        }
        return;
      }

      console.log('Profile updated successfully');
      toast.success('¡Perfil completado exitosamente!');
      
      // Use window.location.href for a complete page refresh
      // This ensures the profile check hook will re-run and detect the completed profile
      setTimeout(() => {
        window.location.href = '/';
      }, 1000);
    } catch (error) {
      console.error('Error:', error);
      toast.error('Error inesperado. Intenta nuevamente.');
    }
  };

  const watchedPrefix = watch('phone_prefix');
  const watchedPhone = watch('phone');

  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-600 via-blue-600 to-indigo-700 p-4 flex items-center justify-center">
      <Card className="w-full max-w-2xl bg-white/95 backdrop-blur-sm shadow-2xl">
        <CardHeader className="text-center">
          <div className="w-16 h-16 bg-gradient-to-br from-purple-500 to-blue-600 rounded-full flex items-center justify-center mx-auto mb-4">
            <User className="w-8 h-8 text-white" />
          </div>
          <CardTitle className="text-2xl font-bold text-gray-800">
            Completa tu Perfil
          </CardTitle>
          <CardDescription className="text-gray-600">
            Necesitamos algunos datos adicionales para personalizar tu experiencia
          </CardDescription>
        </CardHeader>

        <CardContent>
          <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
            {/* Nombres */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="first_name">Nombres</Label>
                <Input
                  id="first_name"
                  {...register('first_name')}
                  placeholder="Tus nombres"
                  className="bg-white"
                />
                {errors.first_name && (
                  <p className="text-sm text-red-600">{errors.first_name.message}</p>
                )}
              </div>

              <div className="space-y-2">
                <Label htmlFor="last_name">Apellidos</Label>
                <Input
                  id="last_name"
                  {...register('last_name')}
                  placeholder="Tus apellidos"
                  className="bg-white"
                />
                {errors.last_name && (
                  <p className="text-sm text-red-600">{errors.last_name.message}</p>
                )}
              </div>
            </div>

            {/* Documento */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label>Tipo de Documento</Label>
                <Select onValueChange={(value) => setValue('document_type', value as any)}>
                  <SelectTrigger className="bg-white">
                    <SelectValue placeholder="Seleccionar" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="cedula">Cédula de Identidad</SelectItem>
                    <SelectItem value="pasaporte">Pasaporte</SelectItem>
                    <SelectItem value="tarjeta_identidad">Tarjeta de Identidad</SelectItem>
                  </SelectContent>
                </Select>
                {errors.document_type && (
                  <p className="text-sm text-red-600">{errors.document_type.message}</p>
                )}
              </div>

              <div className="space-y-2">
                <Label htmlFor="document_number">Número de Documento</Label>
                <Input
                  id="document_number"
                  {...register('document_number')}
                  onChange={handleCedulaChange}
                  placeholder="000-0000000-0"
                  className="bg-white"
                  maxLength={13}
                  value={watch('document_number') || ''}
                />
                {errors.document_number && (
                  <p className="text-sm text-red-600">{errors.document_number.message}</p>
                )}
              </div>
            </div>

            {/* Teléfono */}
            <div className="space-y-2">
              <Label>Teléfono</Label>
              <div className="flex gap-2">
                <div className="flex items-center bg-white border border-input rounded-md px-3 py-2 text-sm">
                  +1
                </div>
                <Select onValueChange={(value) => setValue('phone_prefix', value as any)} defaultValue="809">
                  <SelectTrigger className="bg-white w-20">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="809">809</SelectItem>
                    <SelectItem value="829">829</SelectItem>
                    <SelectItem value="849">849</SelectItem>
                  </SelectContent>
                </Select>
                <Input
                  {...register('phone')}
                  onChange={handlePhoneChange}
                  placeholder="0000000"
                  className="bg-white flex-1"
                  maxLength={7}
                  value={watch('phone') || ''}
                />
              </div>
              {watchedPrefix && watchedPhone && (
                <p className="text-xs text-gray-600">
                  Número completo: +1{watchedPrefix}{watchedPhone}
                </p>
              )}
              {errors.phone_prefix && (
                <p className="text-sm text-red-600">{errors.phone_prefix.message}</p>
              )}
              {errors.phone && (
                <p className="text-sm text-red-600">{errors.phone.message}</p>
              )}
            </div>

            {/* Dirección */}
            <div className="space-y-2">
              <Label htmlFor="address">Dirección</Label>
              <Input
                id="address"
                {...register('address')}
                placeholder="Tu dirección completa"
                className="bg-white"
              />
              {errors.address && (
                <p className="text-sm text-red-600">{errors.address.message}</p>
              )}
            </div>

            <div className="space-y-2">
              <Label htmlFor="neighborhood">Barrio</Label>
              <Input
                id="neighborhood"
                {...register('neighborhood')}
                placeholder="Tu barrio"
                className="bg-white"
              />
              {errors.neighborhood && (
                <p className="text-sm text-red-600">{errors.neighborhood.message}</p>
              )}
            </div>

            {/* Datos personales */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="birth_date">Fecha de Nacimiento</Label>
                <Input
                  id="birth_date"
                  type="date"
                  {...register('birth_date')}
                  className="bg-white"
                />
                {errors.birth_date && (
                  <p className="text-sm text-red-600">{errors.birth_date.message}</p>
                )}
              </div>

              <div className="space-y-2">
                <Label>Género</Label>
                <Select onValueChange={(value) => setValue('gender', value as any)}>
                  <SelectTrigger className="bg-white">
                    <SelectValue placeholder="Seleccionar" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="masculino">Masculino</SelectItem>
                    <SelectItem value="femenino">Femenino</SelectItem>
                    <SelectItem value="otro">Otro</SelectItem>
                    <SelectItem value="prefiero_no_decir">Prefiero no decir</SelectItem>
                  </SelectContent>
                </Select>
                {errors.gender && (
                  <p className="text-sm text-red-600">{errors.gender.message}</p>
                )}
              </div>
            </div>

            <Button
              type="submit"
              disabled={isSubmitting}
              className="w-full bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-700 hover:to-blue-700 text-white font-bold py-3 rounded-xl text-lg shadow-lg transform hover:scale-105 transition-all"
            >
              {isSubmitting ? (
                'Guardando...'
              ) : (
                <>
                  Completar Perfil
                  <ArrowRight className="ml-2 h-5 w-5" />
                </>
              )}
            </Button>
          </form>
        </CardContent>
      </Card>
    </div>
  );
};

export default ProfileSetup;
