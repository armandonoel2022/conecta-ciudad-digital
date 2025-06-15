
import { useState } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { AlertTriangle, MapPin } from "lucide-react";
import { usePanicAlerts } from '@/hooks/usePanicAlerts';
import { useToast } from '@/hooks/use-toast';
import { useNavigate } from 'react-router-dom';

const PanicButton = () => {
  const [locationDescription, setLocationDescription] = useState('');
  const [isCreatingAlert, setIsCreatingAlert] = useState(false);
  const { createPanicAlert, loading } = usePanicAlerts();
  const { toast } = useToast();
  const navigate = useNavigate();

  const handlePanicAlert = async () => {
    if (!locationDescription.trim()) {
      toast({
        title: "Ubicación requerida",
        description: "Por favor describe tu ubicación para crear la alerta.",
        variant: "destructive",
      });
      return;
    }

    try {
      setIsCreatingAlert(true);
      await createPanicAlert(locationDescription);
      
      toast({
        title: "¡Alerta de pánico activada!",
        description: "Tu alerta ha sido enviada a todos los usuarios. Las autoridades han sido notificadas.",
      });

      // Navigate back to home
      navigate('/');
    } catch (error) {
      toast({
        title: "Error",
        description: "No se pudo crear la alerta de pánico. Inténtalo nuevamente.",
        variant: "destructive",
      });
    } finally {
      setIsCreatingAlert(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-red-600 via-red-700 to-red-800 p-4 animate-fade-in">
      <div className="max-w-md mx-auto space-y-6">
        {/* Hero Section */}
        <div className="bg-white/10 backdrop-blur-sm p-8 rounded-[2rem] shadow-xl text-center text-white relative overflow-hidden">
          <div className="absolute inset-0 bg-gradient-to-br from-white/20 to-transparent rounded-[2rem]"></div>
          <div className="relative z-10">
            <div className="mx-auto bg-white/20 p-4 rounded-full w-fit mb-6">
              <AlertTriangle className="h-16 w-16 text-white" />
            </div>
            <h1 className="text-3xl font-bold tracking-tight mb-3">Botón de Pánico</h1>
            <p className="text-lg text-white/90 mb-6 leading-relaxed">
              En caso de emergencia, presiona el botón para alertar a todos los usuarios y autoridades.
            </p>
          </div>
        </div>

        {/* Panic Alert Form */}
        <Card className="bg-white/95 backdrop-blur-sm shadow-xl">
          <CardHeader className="text-center">
            <CardTitle className="text-2xl text-red-700">Crear Alerta de Emergencia</CardTitle>
            <CardDescription>
              Describe tu ubicación para que puedan encontrarte rápidamente
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-6">
            <div className="space-y-2">
              <Label htmlFor="location" className="flex items-center gap-2 text-gray-700">
                <MapPin className="h-4 w-4" />
                Ubicación Actual *
              </Label>
              <Input
                id="location"
                placeholder="Ej: Centro Comercial Oviedo, segundo piso, cerca de Falabella"
                value={locationDescription}
                onChange={(e) => setLocationDescription(e.target.value)}
                className="border-gray-300"
                disabled={loading || isCreatingAlert}
              />
              <p className="text-xs text-gray-500">
                Sé lo más específico posible para facilitar tu ubicación
              </p>
            </div>

            <div className="bg-red-50 border border-red-200 rounded-lg p-4">
              <div className="flex items-center gap-2 mb-2">
                <AlertTriangle className="h-5 w-5 text-red-600" />
                <h3 className="font-semibold text-red-800">¿Qué sucederá?</h3>
              </div>
              <ul className="text-sm text-red-700 space-y-1">
                <li>• Todos los usuarios verán tu alerta en pantalla</li>
                <li>• Se mostrará tu nombre y ubicación</li>
                <li>• Las autoridades serán notificadas automáticamente</li>
                <li>• La alerta permanecerá activa hasta ser resuelta</li>
              </ul>
            </div>

            <Button 
              onClick={handlePanicAlert}
              disabled={loading || isCreatingAlert}
              className="w-full bg-red-600 hover:bg-red-700 text-white font-bold py-4 text-lg rounded-xl shadow-lg"
            >
              {(loading || isCreatingAlert) ? (
                "Creando alerta..."
              ) : (
                <>
                  <AlertTriangle className="h-6 w-6 mr-2" />
                  ¡ACTIVAR ALERTA DE PÁNICO!
                </>
              )}
            </Button>

            <div className="text-center">
              <Button 
                variant="outline" 
                onClick={() => navigate('/')}
                disabled={loading || isCreatingAlert}
                className="text-gray-600"
              >
                Cancelar
              </Button>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default PanicButton;
