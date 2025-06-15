
import React, { useState } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { Siren, Upload, MapPin } from "lucide-react";
import { useAuth } from "@/hooks/useAuth";
import { supabase } from "@/integrations/supabase/client";
import { useToast } from "@/hooks/use-toast";

const formSchema = z.object({
  gender: z.enum(["nino", "nina"], {
    required_error: "Debes seleccionar el género del menor",
  }),
  child_full_name: z.string().min(2, "El nombre debe tener al menos 2 caracteres"),
  child_nickname: z.string().optional(),
  last_seen_location: z.string().min(5, "Indica dónde fue visto por última vez"),
  disappearance_time: z.string().min(1, "La fecha y hora son requeridas"),
  medical_conditions: z.string().optional(),
  contact_number: z.string().min(10, "El número de contacto es requerido"),
  additional_details: z.string().optional(),
});

const AmberAlert = () => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [selectedPhoto, setSelectedPhoto] = useState<File | null>(null);
  const [photoPreview, setPhotoPreview] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      gender: undefined,
      child_full_name: "",
      child_nickname: "",
      last_seen_location: "",
      disappearance_time: "",
      medical_conditions: "",
      contact_number: "",
      additional_details: "",
    },
  });

  const selectedGender = form.watch("gender");

  const handlePhotoChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file) {
      setSelectedPhoto(file);
      const reader = new FileReader();
      reader.onload = (e) => {
        setPhotoPreview(e.target?.result as string);
      };
      reader.readAsDataURL(file);
    }
  };

  const onSubmit = async (values: z.infer<typeof formSchema>) => {
    if (!user) {
      toast({
        title: "Error",
        description: "Debes iniciar sesión para crear una alerta",
        variant: "destructive",
      });
      return;
    }

    setIsSubmitting(true);

    try {
      let photoUrl = null;

      // Subir foto si existe
      if (selectedPhoto) {
        const fileExt = selectedPhoto.name.split('.').pop();
        const fileName = `${Date.now()}.${fileExt}`;
        
        const { error: uploadError } = await supabase.storage
          .from('amber-alert-photos')
          .upload(fileName, selectedPhoto);

        if (uploadError) {
          throw uploadError;
        }

        const { data: { publicUrl } } = supabase.storage
          .from('amber-alert-photos')
          .getPublicUrl(fileName);

        photoUrl = publicUrl;
      }

      // Crear la alerta Amber
      const { error } = await supabase
        .from('amber_alerts')
        .insert({
          user_id: user.id,
          child_full_name: values.child_full_name,
          child_nickname: values.child_nickname || null,
          last_seen_location: values.last_seen_location,
          disappearance_time: new Date(values.disappearance_time).toISOString(),
          medical_conditions: values.medical_conditions || null,
          contact_number: values.contact_number,
          additional_details: values.additional_details || null,
          child_photo_url: photoUrl,
          is_active: true,
        });

      if (error) {
        throw error;
      }

      toast({
        title: "Alerta Amber creada",
        description: "La alerta ha sido enviada exitosamente. Las autoridades han sido notificadas.",
      });

      // Limpiar formulario
      form.reset();
      setSelectedPhoto(null);
      setPhotoPreview(null);

    } catch (error) {
      console.error('Error creating amber alert:', error);
      toast({
        title: "Error",
        description: "No se pudo crear la alerta. Inténtalo nuevamente.",
        variant: "destructive",
      });
    } finally {
      setIsSubmitting(false);
    }
  };

  const getGenderText = (field: string) => {
    if (!selectedGender) return field;
    
    const maleTerms: Record<string, string> = {
      "el menor": "el niño",
      "El menor": "El niño",
      "llevaba puesta": "llevaba puesto",
      "desaparecida": "desaparecido",
      "Desaparecida": "Desaparecido"
    };

    const femaleTerms: Record<string, string> = {
      "el menor": "la niña",
      "El menor": "La niña",
      "llevaba puesto": "llevaba puesta",
      "desaparecido": "desaparecida",
      "Desaparecido": "Desaparecida"
    };

    if (selectedGender === "nino") {
      return Object.entries(maleTerms).reduce((text, [key, value]) => 
        text.replace(new RegExp(key, 'g'), value), field
      );
    } else {
      return Object.entries(femaleTerms).reduce((text, [key, value]) => 
        text.replace(new RegExp(key, 'g'), value), field
      );
    }
  };

  return (
    <div className="container mx-auto p-6 max-w-4xl">
      <div className="text-center mb-8">
        <div className="mx-auto bg-amber-100 p-4 rounded-full w-fit mb-4">
          <Siren className="h-12 w-12 text-amber-600" />
        </div>
        <h1 className="text-3xl font-bold text-amber-800 mb-2">Alerta Amber</h1>
        <p className="text-gray-600">
          Sistema de alerta para menores desaparecidos. Complete toda la información disponible.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-xl text-amber-700">Información del Menor Desaparecido</CardTitle>
          <CardDescription>
            Por favor, complete todos los campos con la mayor precisión posible.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <Form {...form}>
            <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
              {/* Selector de Género */}
              <FormField
                control={form.control}
                name="gender"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel className="text-base font-semibold">Género *</FormLabel>
                    <FormControl>
                      <RadioGroup
                        onValueChange={field.onChange}
                        value={field.value}
                        className="flex gap-6"
                      >
                        <div className="flex items-center space-x-2">
                          <RadioGroupItem value="nino" id="nino" />
                          <Label htmlFor="nino" className="cursor-pointer">Niño</Label>
                        </div>
                        <div className="flex items-center space-x-2">
                          <RadioGroupItem value="nina" id="nina" />
                          <Label htmlFor="nina" className="cursor-pointer">Niña</Label>
                        </div>
                      </RadioGroup>
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              {/* Información Básica */}
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <FormField
                  control={form.control}
                  name="child_full_name"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Nombre completo *</FormLabel>
                      <FormControl>
                        <Input placeholder={`Nombre completo ${selectedGender ? (selectedGender === 'nino' ? 'del niño' : 'de la niña') : 'del menor'}`} {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name="child_nickname"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Apodo o sobrenombre</FormLabel>
                      <FormControl>
                        <Input placeholder="Apodo común" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>

              {/* Ubicación y Fecha */}
              <div className="space-y-4">
                <h3 className="text-lg font-semibold text-gray-800">Información de la Desaparición</h3>
                <FormField
                  control={form.control}
                  name="last_seen_location"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="flex items-center gap-2">
                        <MapPin className="h-4 w-4" />
                        Ubicación donde fue visto por última vez *
                      </FormLabel>
                      <FormControl>
                        <Input placeholder="Dirección, barrio, punto de referencia" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name="disappearance_time"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Fecha y hora de la desaparición *</FormLabel>
                      <FormControl>
                        <Input type="datetime-local" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>

              {/* Información Médica */}
              <FormField
                control={form.control}
                name="medical_conditions"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Condiciones médicas especiales</FormLabel>
                    <FormControl>
                      <Textarea 
                        placeholder={getGenderText("Medicamentos que toma el menor, condiciones médicas importantes, alergias, etc.")}
                        className="min-h-[80px]"
                        {...field} 
                      />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              {/* Contacto */}
              <FormField
                control={form.control}
                name="contact_number"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Número de contacto *</FormLabel>
                    <FormControl>
                      <Input placeholder="Número de teléfono para contacto" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              {/* Información Adicional */}
              <FormField
                control={form.control}
                name="additional_details"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Detalles adicionales</FormLabel>
                    <FormControl>
                      <Textarea 
                        placeholder={getGenderText("Cualquier información adicional que pueda ayudar a localizar al menor")}
                        className="min-h-[80px]"
                        {...field} 
                      />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              {/* Subir Foto */}
              <div className="space-y-4">
                <Label className="text-base font-semibold">Fotografía {selectedGender ? (selectedGender === 'nino' ? 'del niño' : 'de la niña') : 'del menor'}</Label>
                <div className="border-2 border-dashed border-gray-300 rounded-lg p-6 text-center">
                  <input
                    type="file"
                    accept="image/*"
                    onChange={handlePhotoChange}
                    className="hidden"
                    id="photo-upload"
                  />
                  <label htmlFor="photo-upload" className="cursor-pointer">
                    {photoPreview ? (
                      <div className="space-y-2">
                        <img 
                          src={photoPreview} 
                          alt="Preview" 
                          className="mx-auto max-h-48 rounded-lg"
                        />
                        <p className="text-sm text-gray-600">Clic para cambiar la foto</p>
                      </div>
                    ) : (
                      <div className="space-y-2">
                        <Upload className="mx-auto h-12 w-12 text-gray-400" />
                        <p className="text-gray-600">
                          Clic para subir una foto reciente {selectedGender ? (selectedGender === 'nino' ? 'del niño' : 'de la niña') : 'del menor'}
                        </p>
                        <p className="text-sm text-gray-500">JPG, PNG hasta 10MB</p>
                      </div>
                    )}
                  </label>
                </div>
              </div>

              {/* Botón de Envío */}
              <div className="pt-6">
                <Button 
                  type="submit" 
                  className="w-full bg-amber-600 hover:bg-amber-700 text-white py-3 text-lg"
                  disabled={isSubmitting}
                >
                  {isSubmitting ? "Enviando Alerta..." : "Enviar Alerta Amber"}
                </Button>
              </div>
            </form>
          </Form>
        </CardContent>
      </Card>
    </div>
  );
};

export default AmberAlert;
