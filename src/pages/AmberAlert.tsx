
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
  name: z.string().min(2, "El nombre debe tener al menos 2 caracteres"),
  age: z.string().min(1, "La edad es requerida"),
  height: z.string().min(1, "La estatura es requerida"),
  weight: z.string().min(1, "El peso es requerido"),
  hair_color: z.string().min(1, "El color de cabello es requerido"),
  eye_color: z.string().min(1, "El color de ojos es requerido"),
  skin_color: z.string().min(1, "El color de piel es requerido"),
  clothing_description: z.string().min(5, "Describe la ropa que llevaba puesta"),
  last_seen_location: z.string().min(5, "Indica dónde fue visto por última vez"),
  last_seen_date: z.string().min(1, "La fecha es requerida"),
  last_seen_time: z.string().min(1, "La hora es requerida"),
  circumstances: z.string().min(10, "Describe las circunstancias de la desaparición"),
  additional_info: z.string().optional(),
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
      name: "",
      age: "",
      height: "",
      weight: "",
      hair_color: "",
      eye_color: "",
      skin_color: "",
      clothing_description: "",
      last_seen_location: "",
      last_seen_date: "",
      last_seen_time: "",
      circumstances: "",
      additional_info: "",
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

      // Crear la alerta
      const { error } = await supabase
        .from('amber_alerts')
        .insert({
          user_id: user.id,
          gender: values.gender,
          name: values.name,
          age: parseInt(values.age),
          height: values.height,
          weight: values.weight,
          hair_color: values.hair_color,
          eye_color: values.eye_color,
          skin_color: values.skin_color,
          clothing_description: values.clothing_description,
          last_seen_location: values.last_seen_location,
          last_seen_date: values.last_seen_date,
          last_seen_time: values.last_seen_time,
          circumstances: values.circumstances,
          additional_info: values.additional_info || null,
          photo_url: photoUrl,
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
                  name="name"
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
                  name="age"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Edad *</FormLabel>
                      <FormControl>
                        <Input type="number" placeholder="Edad en años" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>

              {/* Características Físicas */}
              <div className="space-y-4">
                <h3 className="text-lg font-semibold text-gray-800">Características Físicas</h3>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                  <FormField
                    control={form.control}
                    name="height"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Estatura *</FormLabel>
                        <FormControl>
                          <Input placeholder="ej: 1.20 m" {...field} />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="weight"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Peso *</FormLabel>
                        <FormControl>
                          <Input placeholder="ej: 30 kg" {...field} />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="hair_color"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Color de cabello *</FormLabel>
                        <FormControl>
                          <Select onValueChange={field.onChange} value={field.value}>
                            <SelectTrigger>
                              <SelectValue placeholder="Seleccionar" />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="negro">Negro</SelectItem>
                              <SelectItem value="castano-oscuro">Castaño oscuro</SelectItem>
                              <SelectItem value="castano-claro">Castaño claro</SelectItem>
                              <SelectItem value="rubio">Rubio</SelectItem>
                              <SelectItem value="pelirrojo">Pelirrojo</SelectItem>
                              <SelectItem value="gris">Gris</SelectItem>
                              <SelectItem value="otro">Otro</SelectItem>
                            </SelectContent>
                          </Select>
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <FormField
                    control={form.control}
                    name="eye_color"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Color de ojos *</FormLabel>
                        <FormControl>
                          <Select onValueChange={field.onChange} value={field.value}>
                            <SelectTrigger>
                              <SelectValue placeholder="Seleccionar" />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="marrones">Marrones</SelectItem>
                              <SelectItem value="negros">Negros</SelectItem>
                              <SelectItem value="azules">Azules</SelectItem>
                              <SelectItem value="verdes">Verdes</SelectItem>
                              <SelectItem value="avellana">Avellana</SelectItem>
                              <SelectItem value="grises">Grises</SelectItem>
                            </SelectContent>
                          </Select>
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="skin_color"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Color de piel *</FormLabel>
                        <FormControl>
                          <Select onValueChange={field.onChange} value={field.value}>
                            <SelectTrigger>
                              <SelectValue placeholder="Seleccionar" />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="blanca">Blanca</SelectItem>
                              <SelectItem value="morena-clara">Morena clara</SelectItem>
                              <SelectItem value="morena">Morena</SelectItem>
                              <SelectItem value="morena-oscura">Morena oscura</SelectItem>
                              <SelectItem value="negra">Negra</SelectItem>
                            </SelectContent>
                          </Select>
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                </div>
              </div>

              {/* Ropa y Apariencia */}
              <FormField
                control={form.control}
                name="clothing_description"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Descripción de la ropa *</FormLabel>
                    <FormControl>
                      <Textarea 
                        placeholder={getGenderText("Describe detalladamente la ropa que el menor llevaba puesta al momento de la desaparición")}
                        className="min-h-[80px]"
                        {...field} 
                      />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              {/* Ubicación y Fecha */}
              <div className="space-y-4">
                <h3 className="text-lg font-semibold text-gray-800">Última Vez Visto</h3>
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

                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <FormField
                    control={form.control}
                    name="last_seen_date"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Fecha *</FormLabel>
                        <FormControl>
                          <Input type="date" {...field} />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="last_seen_time"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Hora aproximada *</FormLabel>
                        <FormControl>
                          <Input type="time" {...field} />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                </div>
              </div>

              {/* Circunstancias */}
              <FormField
                control={form.control}
                name="circumstances"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Circunstancias de la desaparición *</FormLabel>
                    <FormControl>
                      <Textarea 
                        placeholder={getGenderText("Describe detalladamente las circunstancias en las que el menor desaparecida")}
                        className="min-h-[100px]"
                        {...field} 
                      />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              {/* Información Adicional */}
              <FormField
                control={form.control}
                name="additional_info"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Información adicional</FormLabel>
                    <FormControl>
                      <Textarea 
                        placeholder={getGenderText("Cualquier otro detalle que pueda ayudar a localizar al menor (medicamentos, condiciones médicas, etc.)")}
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
