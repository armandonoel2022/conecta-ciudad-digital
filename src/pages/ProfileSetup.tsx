
import React from 'react';
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
  first_name: z.string().min(2, 'El nombre debe tener al menos 2 caracteres'),
  last_name: z.string().min(2, 'El apellido debe tener al menos 2 caracteres'),
  document_type: z.enum(['cedula', 'pasaporte', 'tarjeta_identidad'], {
    required_error: 'Selecciona un tipo de documento'
  }),
  document_number: z.string().min(5, 'El número de documento debe tener al menos 5 caracteres'),
  phone: z.string().min(10, 'El teléfono debe tener al menos 10 dígitos'),
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
    resolver: zodResolver(profileSchema)
  });

  const onSubmit = async (data: ProfileFormData) => {
    if (!user) return;

    try {
      const { error } = await supabase
        .from('profiles')
        .update({
          first_name: data.first_name,
          last_name: data.last_name,
          document_type: data.document_type,
          document_number: data.document_number,
          phone: data.phone,
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
        toast.error('Error al guardar el perfil. Intenta nuevamente.');
        return;
      }

      toast.success('¡Perfil completado exitosamente!');
      navigate('/');
    } catch (error) {
      console.error('Error:', error);
      toast.error('Error inesperado. Intenta nuevamente.');
    }
  };

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
                <Label htmlFor="first_name">Nombre</Label>
                <Input
                  id="first_name"
                  {...register('first_name')}
                  placeholder="Tu nombre"
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
                    <SelectItem value="cedula">Cédula de Ciudadanía</SelectItem>
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
                  placeholder="Número de documento"
                  className="bg-white"
                />
                {errors.document_number && (
                  <p className="text-sm text-red-600">{errors.document_number.message}</p>
                )}
              </div>
            </div>

            {/* Contacto */}
            <div className="space-y-2">
              <Label htmlFor="phone">Teléfono</Label>
              <Input
                id="phone"
                {...register('phone')}
                placeholder="Número de teléfono"
                className="bg-white"
              />
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
