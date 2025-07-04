
import { useState, useEffect } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Switch } from "@/components/ui/switch";
import { Label } from "@/components/ui/label";
import { ArrowLeft, Fingerprint, LocateFixed } from "lucide-react";
import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { useToast } from "@/hooks/use-toast";

const Settings = () => {
  const [biometricEnabled, setBiometricEnabled] = useState(false);
  const [locationServicesEnabled, setLocationServicesEnabled] = useState(false);
  const { toast } = useToast();

  // Load settings from localStorage on component mount
  useEffect(() => {
    const savedBiometric = localStorage.getItem('biometricEnabled') === 'true';
    const savedLocationServices = localStorage.getItem('locationServicesEnabled') === 'true';
    
    setBiometricEnabled(savedBiometric);
    setLocationServicesEnabled(savedLocationServices);
  }, []);

  const handleBiometricToggle = async (enabled: boolean) => {
    if (enabled) {
      // Simulate biometric authentication check
      try {
        // In a real app, you would check if the device supports biometric authentication
        // and prompt the user to authenticate
        toast({
          title: "Autenticación biométrica activada",
          description: "Ahora puedes usar tu huella dactilar o Face ID para acceder",
        });
        setBiometricEnabled(true);
        localStorage.setItem('biometricEnabled', 'true');
      } catch (error) {
        toast({
          title: "Error",
          description: "No se pudo activar la autenticación biométrica",
          variant: "destructive",
        });
      }
    } else {
      setBiometricEnabled(false);
      localStorage.setItem('biometricEnabled', 'false');
      toast({
        title: "Autenticación biométrica desactivada",
        description: "Se ha desactivado el acceso biométrico",
      });
    }
  };

  const handleLocationServicesToggle = async (enabled: boolean) => {
    if (enabled) {
      try {
        // Check if geolocation is supported
        if (!navigator.geolocation) {
          throw new Error('Geolocalización no soportada en este dispositivo');
        }

        // Request location permission
        const position = await new Promise<GeolocationPosition>((resolve, reject) => {
          navigator.geolocation.getCurrentPosition(
            resolve,
            reject,
            { enableHighAccuracy: true, timeout: 5000, maximumAge: 0 }
          );
        });

        setLocationServicesEnabled(true);
        localStorage.setItem('locationServicesEnabled', 'true');
        
        toast({
          title: "Servicios de ubicación activados",
          description: "El botón de pánico podrá acceder a tu ubicación automáticamente",
        });
      } catch (error) {
        toast({
          title: "Error",
          description: "No se pudo activar los servicios de ubicación. Verifica los permisos del navegador.",
          variant: "destructive",
        });
      }
    } else {
      setLocationServicesEnabled(false);
      localStorage.setItem('locationServicesEnabled', 'false');
      toast({
        title: "Servicios de ubicación desactivados",
        description: "El botón de pánico te pedirá permisos cuando sea necesario",
      });
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 animate-fade-in">
      <div className="max-w-md mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-4">
          <Link to="/" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold">CONFIGURACIÓN</h1>
            <p className="text-white/80">Personaliza tu experiencia</p>
          </div>
        </div>

        {/* Settings Cards */}
        <div className="space-y-4">
          {/* Location Services */}
          <Card className="border-none shadow-xl">
            <CardHeader className="pb-3">
              <div className="flex items-center gap-3">
                <div className="p-2 bg-blue-100 rounded-lg">
                  <LocateFixed className="h-5 w-5 text-blue-600" />
                </div>
                <div>
                  <CardTitle className="text-lg">Servicios de ubicación</CardTitle>
                  <CardDescription>
                    Permite el acceso automático a tu ubicación para emergencias
                  </CardDescription>
                </div>
              </div>
            </CardHeader>
            <CardContent className="pt-0">
              <div className="flex items-center justify-between p-3 rounded-lg bg-secondary">
                <div className="flex items-center gap-3">
                  <LocateFixed className="h-5 w-5 text-blue-600" />
                  <div>
                    <p className="font-medium text-sm">Ubicación automática</p>
                    <p className="text-xs text-muted-foreground">
                      Para el botón de pánico y emergencias
                    </p>
                  </div>
                </div>
                <Switch
                  checked={locationServicesEnabled}
                  onCheckedChange={handleLocationServicesToggle}
                />
              </div>
              {locationServicesEnabled && (
                <div className="mt-3 p-3 bg-green-50 border border-green-200 rounded-lg">
                  <p className="text-sm text-green-800">
                    ✅ Los servicios de ubicación están activados. El botón de pánico funcionará sin demoras.
                  </p>
                </div>
              )}
            </CardContent>
          </Card>

          {/* Biometric Authentication */}
          <Card className="border-none shadow-xl">
            <CardHeader className="pb-3">
              <div className="flex items-center gap-3">
                <div className="p-2 bg-green-100 rounded-lg">
                  <Fingerprint className="h-5 w-5 text-green-600" />
                </div>
                <div>
                  <CardTitle className="text-lg">Autenticación biométrica</CardTitle>
                  <CardDescription>
                    Usa tu huella dactilar o Face ID para acceder
                  </CardDescription>
                </div>
              </div>
            </CardHeader>
            <CardContent className="pt-0">
              <div className="flex items-center justify-between p-3 rounded-lg bg-secondary">
                <div className="flex items-center gap-3">
                  <Fingerprint className="h-5 w-5 text-green-600" />
                  <div>
                    <p className="font-medium text-sm">Acceso biométrico</p>
                    <p className="text-xs text-muted-foreground">
                      Desbloquea con huella o Face ID
                    </p>
                  </div>
                </div>
                <Switch
                  checked={biometricEnabled}
                  onCheckedChange={handleBiometricToggle}
                />
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Save Button */}
        <div className="pt-4">
          <Button 
            className="w-full bg-gradient-to-r from-primary to-blue-500 hover:from-primary/90 hover:to-blue-600 text-white font-semibold py-3 rounded-xl shadow-lg"
            onClick={() => {
              toast({
                title: "Configuración guardada",
                description: "Todos los cambios han sido aplicados correctamente",
              });
            }}
          >
            Guardar cambios
          </Button>
        </div>
      </div>
    </div>
  );
};

export default Settings;
