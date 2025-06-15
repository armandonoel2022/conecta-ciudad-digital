
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { MapPin, Paperclip, ArrowLeft } from "lucide-react";
import { Link, useNavigate } from "react-router-dom";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/hooks/useAuth";
import { useState, useEffect } from "react";
import { toast } from "sonner";

const formSchema = z.object({
  title: z.string().min(5, "El título debe tener al menos 5 caracteres"),
  category: z.enum(["basura", "iluminacion", "baches", "seguridad", "otros"], {
    required_error: "Selecciona una categoría",
  }),
  description: z.string().min(10, "La descripción debe tener al menos 10 caracteres"),
  address: z.string().optional(),
  neighborhood: z.string().optional(),
});

type FormData = z.infer<typeof formSchema>;

const ReportIssue = () => {
  const { user } = useAuth();
  const navigate = useNavigate();
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [currentLocation, setCurrentLocation] = useState<{
    latitude: number;
    longitude: number;
  } | null>(null);

  const form = useForm<FormData>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      title: "",
      category: undefined,
      description: "",
      address: "",
      neighborhood: "",
    },
  });

  useEffect(() => {
    // Get user's current location
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          setCurrentLocation({
            latitude: position.coords.latitude,
            longitude: position.coords.longitude,
          });
        },
        (error) => {
          console.log("Error getting location:", error);
        }
      );
    }
  }, []);

  const onSubmit = async (data: FormData) => {
    if (!user) {
      toast.error("Debes estar autenticado para enviar un reporte");
      return;
    }

    setIsSubmitting(true);

    try {
      const reportData = {
        user_id: user.id,
        title: data.title,
        category: data.category,
        description: data.description,
        address: data.address || null,
        neighborhood: data.neighborhood || null,
        latitude: currentLocation?.latitude || null,
        longitude: currentLocation?.longitude || null,
        status: 'pendiente' as const,
        priority: 'media' as const,
      };

      const { error } = await supabase
        .from('reports')
        .insert([reportData]);

      if (error) {
        console.error('Error creating report:', error);
        toast.error("Error al enviar el reporte. Inténtalo de nuevo.");
        return;
      }

      toast.success("¡Reporte enviado exitosamente!");
      navigate("/");
    } catch (error) {
      console.error('Error submitting report:', error);
      toast.error("Error al enviar el reporte. Inténtalo de nuevo.");
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-600 via-blue-600 to-indigo-700 p-4 animate-fade-in">
      <div className="max-w-md mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-4">
          <Link to="/" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold">REPORTAR</h1>
            <p className="text-white/80">Nueva incidencia</p>
          </div>
        </div>

        {/* Form Card */}
        <div className="bg-white rounded-[2rem] p-6 shadow-xl">
          <div className="space-y-6">
            <div className="text-center">
              <h2 className="text-xl font-bold text-gray-800 mb-2">Reportar una Incidencia</h2>
              <p className="text-gray-600 text-sm">
                Ayúdanos a mejorar la ciudad. Describe el problema con el mayor detalle posible.
              </p>
            </div>

            <Form {...form}>
              <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
                <FormField
                  control={form.control}
                  name="title"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="text-gray-800 font-semibold">Título del Reporte</FormLabel>
                      <FormControl>
                        <Input 
                          placeholder="Ej: Bache en la calle principal" 
                          className="rounded-xl border-2 border-gray-200 focus:border-purple-500"
                          {...field} 
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name="category"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="text-gray-800 font-semibold">Categoría</FormLabel>
                      <Select onValueChange={field.onChange} defaultValue={field.value}>
                        <FormControl>
                          <SelectTrigger className="rounded-xl border-2 border-gray-200 focus:border-purple-500">
                            <SelectValue placeholder="Selecciona una categoría" />
                          </SelectTrigger>
                        </FormControl>
                        <SelectContent className="rounded-xl">
                          <SelectItem value="basura">Basura y Limpieza</SelectItem>
                          <SelectItem value="iluminacion">Iluminación Pública</SelectItem>
                          <SelectItem value="baches">Baches y Pavimento</SelectItem>
                          <SelectItem value="seguridad">Seguridad Ciudadana</SelectItem>
                          <SelectItem value="otros">Otros</SelectItem>
                        </SelectContent>
                      </Select>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name="description"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="text-gray-800 font-semibold">Descripción</FormLabel>
                      <FormControl>
                        <Textarea 
                          placeholder="Describe el problema con el mayor detalle posible..." 
                          rows={5} 
                          className="rounded-xl border-2 border-gray-200 focus:border-purple-500 resize-none"
                          {...field}
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name="address"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="text-gray-800 font-semibold">Dirección (Opcional)</FormLabel>
                      <FormControl>
                        <Input 
                          placeholder="Ej: Calle 50 #45-30" 
                          className="rounded-xl border-2 border-gray-200 focus:border-purple-500"
                          {...field} 
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name="neighborhood"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="text-gray-800 font-semibold">Barrio (Opcional)</FormLabel>
                      <FormControl>
                        <Input 
                          placeholder="Ej: El Poblado" 
                          className="rounded-xl border-2 border-gray-200 focus:border-purple-500"
                          {...field} 
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <div className="space-y-2">
                  <Label className="text-gray-800 font-semibold">Adjuntar Foto</Label>
                  <Button 
                    type="button"
                    variant="outline" 
                    className="w-full flex items-center justify-center gap-2 rounded-xl border-2 border-gray-200 hover:border-purple-500 py-6"
                  >
                    <Paperclip className="h-5 w-5 text-purple-600" />
                    <span className="text-gray-700">Seleccionar archivo</span>
                  </Button>
                  <Input id="photo" type="file" className="hidden" />
                </div>

                {currentLocation && (
                  <div className="flex items-center gap-3 text-sm text-purple-600 p-4 bg-purple-50 rounded-xl border border-purple-200">
                    <MapPin className="h-5 w-5" />
                    <span className="font-medium">Ubicación detectada automáticamente.</span>
                  </div>
                )}

                <Button 
                  type="submit" 
                  disabled={isSubmitting}
                  className="w-full text-lg bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-700 hover:to-blue-700 rounded-xl py-6 font-bold shadow-lg transform hover:scale-105 transition-all disabled:opacity-50 disabled:transform-none"
                >
                  {isSubmitting ? "Enviando..." : "Enviar Reporte"}
                </Button>
              </form>
            </Form>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ReportIssue;
