
import { useState } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { AlertTriangle, Upload, Phone, MapPin, Clock, User } from "lucide-react";
import { useAmberAlerts } from '@/hooks/useAmberAlerts';
import { useToast } from '@/hooks/use-toast';
import { useNavigate } from 'react-router-dom';

const AmberAlert = () => {
  const [formData, setFormData] = useState({
    child_full_name: '',
    child_nickname: '',
    last_seen_location: '',
    disappearance_time: '',
    medical_conditions: '',
    contact_number: '',
    additional_details: ''
  });
  const [photoFile, setPhotoFile] = useState<File | null>(null);
  const [photoPreview, setPhotoPreview] = useState<string | null>(null);
  const [isCreating, setIsCreating] = useState(false);

  const { createAmberAlert, uploadPhoto, loading } = useAmberAlerts();
  const { toast } = useToast();
  const navigate = useNavigate();

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const handlePhotoChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      setPhotoFile(file);
      const reader = new FileReader();
      reader.onload = () => {
        setPhotoPreview(reader.result as string);
      };
      reader.readAsDataURL(file);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!formData.child_full_name.trim() || !formData.last_seen_location.trim() || 
        !formData.contact_number.trim() || !formData.disappearance_time) {
      toast({
        title: "Campos requeridos",
        description: "Por favor completa todos los campos obligatorios.",
        variant: "destructive",
      });
      return;
    }

    try {
      setIsCreating(true);
      
      let child_photo_url = '';
      if (photoFile) {
        child_photo_url = await uploadPhoto(photoFile);
      }

      await createAmberAlert({
        ...formData,
        child_photo_url: child_photo_url || undefined
      });
      
      toast({
        title: "¡Alerta Amber creada!",
        description: "La alerta se ha enviado a todos los usuarios. Las autoridades han sido notificadas.",
      });

      // Navigate back to home
      navigate('/');
    } catch (error) {
      toast({
        title: "Error",
        description: "No se pudo crear la Alerta Amber. Inténtalo nuevamente.",
        variant: "destructive",
      });
    } finally {
      setIsCreating(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-amber via-orange-600 to-red-700 p-4 animate-fade-in">
      <div className="max-w-2xl mx-auto space-y-6">
        {/* Hero Section */}
        <div className="bg-white/10 backdrop-blur-sm p-8 rounded-[2rem] shadow-xl text-center text-white relative overflow-hidden">
          <div className="absolute inset-0 bg-gradient-to-br from-white/20 to-transparent rounded-[2rem]"></div>
          <div className="relative z-10">
            <div className="mx-auto bg-white/20 p-4 rounded-full w-fit mb-6">
              <AlertTriangle className="h-16 w-16 text-white" />
            </div>
            <h1 className="text-3xl font-bold tracking-tight mb-3">Alerta Amber</h1>
            <p className="text-lg text-white/90 mb-6 leading-relaxed">
              Sistema de alerta para menores desaparecidos. Tu reporte puede salvar una vida.
            </p>
          </div>
        </div>

        {/* Amber Alert Form */}
        <Card className="bg-white/95 backdrop-blur-sm shadow-xl">
          <CardHeader className="text-center">
            <CardTitle className="text-2xl text-amber-foreground">Crear Alerta Amber</CardTitle>
            <CardDescription>
              Completa toda la información disponible del menor desaparecido
            </CardDescription>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleSubmit} className="space-y-6">
              {/* Child Information */}
              <div className="space-y-4">
                <div className="flex items-center gap-2 mb-3">
                  <User className="h-5 w-5 text-amber" />
                  <h3 className="text-lg font-semibold text-gray-800">Información del Menor</h3>
                </div>
                
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label htmlFor="child_full_name" className="text-gray-700">
                      Nombre completo *
                    </Label>
                    <Input
                      id="child_full_name"
                      name="child_full_name"
                      placeholder="Nombre y apellidos del menor"
                      value={formData.child_full_name}
                      onChange={handleInputChange}
                      className="border-gray-300"
                      disabled={loading || isCreating}
                      required
                    />
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="child_nickname" className="text-gray-700">
                      Apodo o como le dicen
                    </Label>
                    <Input
                      id="child_nickname"
                      name="child_nickname"
                      placeholder="Apodo del menor"
                      value={formData.child_nickname}
                      onChange={handleInputChange}
                      className="border-gray-300"
                      disabled={loading || isCreating}
                    />
                  </div>
                </div>

                {/* Photo Upload */}
                <div className="space-y-2">
                  <Label htmlFor="photo" className="flex items-center gap-2 text-gray-700">
                    <Upload className="h-4 w-4" />
                    Foto del menor
                  </Label>
                  <Input
                    id="photo"
                    type="file"
                    accept="image/*"
                    onChange={handlePhotoChange}
                    className="border-gray-300"
                    disabled={loading || isCreating}
                  />
                  {photoPreview && (
                    <div className="mt-2">
                      <img 
                        src={photoPreview} 
                        alt="Vista previa" 
                        className="w-32 h-32 object-cover rounded-lg border-2 border-gray-200"
                      />
                    </div>
                  )}
                </div>

                <div className="space-y-2">
                  <Label htmlFor="medical_conditions" className="text-gray-700">
                    Condiciones médicas especiales
                  </Label>
                  <Textarea
                    id="medical_conditions"
                    name="medical_conditions"
                    placeholder="Medicamentos, alergias, condiciones especiales..."
                    value={formData.medical_conditions}
                    onChange={handleInputChange}
                    className="border-gray-300"
                    disabled={loading || isCreating}
                    rows={3}
                  />
                </div>
              </div>

              {/* Location and Time */}
              <div className="space-y-4">
                <div className="flex items-center gap-2 mb-3">
                  <MapPin className="h-5 w-5 text-amber" />
                  <h3 className="text-lg font-semibold text-gray-800">Ubicación y Tiempo</h3>
                </div>
                
                <div className="space-y-2">
                  <Label htmlFor="last_seen_location" className="text-gray-700">
                    Última ubicación conocida *
                  </Label>
                  <Input
                    id="last_seen_location"
                    name="last_seen_location"
                    placeholder="Dirección, barrio, lugar específico donde fue visto por última vez"
                    value={formData.last_seen_location}
                    onChange={handleInputChange}
                    className="border-gray-300"
                    disabled={loading || isCreating}
                    required
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="disappearance_time" className="flex items-center gap-2 text-gray-700">
                    <Clock className="h-4 w-4" />
                    Fecha y hora de desaparición *
                  </Label>
                  <Input
                    id="disappearance_time"
                    name="disappearance_time"
                    type="datetime-local"
                    value={formData.disappearance_time}
                    onChange={handleInputChange}
                    className="border-gray-300"
                    disabled={loading || isCreating}
                    required
                  />
                </div>
              </div>

              {/* Contact Information */}
              <div className="space-y-4">
                <div className="flex items-center gap-2 mb-3">
                  <Phone className="h-5 w-5 text-amber" />
                  <h3 className="text-lg font-semibold text-gray-800">Información de Contacto</h3>
                </div>
                
                <div className="space-y-2">
                  <Label htmlFor="contact_number" className="text-gray-700">
                    Número de contacto *
                  </Label>
                  <Input
                    id="contact_number"
                    name="contact_number"
                    type="tel"
                    placeholder="Número de teléfono para reportar avistamientos"
                    value={formData.contact_number}
                    onChange={handleInputChange}
                    className="border-gray-300"
                    disabled={loading || isCreating}
                    required
                  />
                </div>
              </div>

              {/* Additional Details */}
              <div className="space-y-2">
                <Label htmlFor="additional_details" className="text-gray-700">
                  Detalles adicionales
                </Label>
                <Textarea
                  id="additional_details"
                  name="additional_details"
                  placeholder="Ropa que vestía, características físicas, comportamiento, cualquier detalle que pueda ayudar..."
                  value={formData.additional_details}
                  onChange={handleInputChange}
                  className="border-gray-300"
                  disabled={loading || isCreating}
                  rows={4}
                />
              </div>

              <div className="bg-orange-50 border border-orange-200 rounded-lg p-4">
                <div className="flex items-center gap-2 mb-2">
                  <AlertTriangle className="h-5 w-5 text-amber" />
                  <h3 className="font-semibold text-orange-800">¿Qué sucederá?</h3>
                </div>
                <ul className="text-sm text-orange-700 space-y-1">
                  <li>• Todos los usuarios verán la alerta en pantalla</li>
                  <li>• Se mostrará la información y foto del menor</li>
                  <li>• Las autoridades serán notificadas automáticamente</li>
                  <li>• La alerta permanecerá activa hasta encontrar al menor</li>
                </ul>
              </div>

              <Button 
                type="submit"
                disabled={loading || isCreating}
                className="w-full bg-amber hover:bg-orange-600 text-amber-foreground font-bold py-4 text-lg rounded-xl shadow-lg"
              >
                {(loading || isCreating) ? (
                  "Creando alerta..."
                ) : (
                  <>
                    <AlertTriangle className="h-6 w-6 mr-2" />
                    ¡ACTIVAR ALERTA AMBER!
                  </>
                )}
              </Button>

              <div className="text-center">
                <Button 
                  type="button"
                  variant="outline" 
                  onClick={() => navigate('/')}
                  disabled={loading || isCreating}
                  className="text-gray-600"
                >
                  Cancelar
                </Button>
              </div>
            </form>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default AmberAlert;
