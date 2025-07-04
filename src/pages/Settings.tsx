
import { useState, useEffect } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Switch } from "@/components/ui/switch";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Label } from "@/components/ui/label";
import { Settings as SettingsIcon, ArrowLeft, Palette, Fingerprint, Moon, Sun, Monitor, LocateFixed } from "lucide-react";
import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { useToast } from "@/hooks/use-toast";

type Theme = 'light' | 'dark' | 'system';

const Settings = () => {
  const [theme, setTheme] = useState<Theme>('system');
  const [biometricEnabled, setBiometricEnabled] = useState(false);
  const [locationServicesEnabled, setLocationServicesEnabled] = useState(false);
  const { toast } = useToast();

  // Load settings from localStorage on component mount
  useEffect(() => {
    const savedTheme = localStorage.getItem('theme') as Theme;
    const savedBiometric = localStorage.getItem('biometricEnabled') === 'true';
    const savedLocationServices = localStorage.getItem('locationServicesEnabled') === 'true';
    
    if (savedTheme) {
      setTheme(savedTheme);
      applyTheme(savedTheme);
    }
    
    setBiometricEnabled(savedBiometric);
    setLocationServicesEnabled(savedLocationServices);
  }, []);

  const applyTheme = (selectedTheme: Theme) => {
    const root = window.document.documentElement;
    
    if (selectedTheme === 'system') {
      const systemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
      root.classList.remove('light', 'dark');
      root.classList.add(systemTheme);
    } else {
      root.classList.remove('light', 'dark');
      root.classList.add(selectedTheme);
    }
  };

  const handleThemeChange = (newTheme: Theme) => {
    setTheme(newTheme);
    localStorage.setItem('theme', newTheme);
    applyTheme(newTheme);
    
    toast({
      title: "Tema actualizado",
      description: `Se ha cambiado al tema ${newTheme === 'light' ? 'claro' : newTheme === 'dark' ? 'oscuro' : 'del sistema'}`,
    });
  };

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

  const getThemeIcon = (themeType: Theme) => {
    switch (themeType) {
      case 'light':
        return <Sun className="h-4 w-4" />;
      case 'dark':
        return <Moon className="h-4 w-4" />;
      case 'system':
        return <Monitor className="h-4 w-4" />;
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
          {/* Theme Settings */}
          <Card className="border-none shadow-xl">
            <CardHeader className="pb-3">
              <div className="flex items-center gap-3">
                <div className="p-2 bg-blue-100 rounded-lg">
                  <Palette className="h-5 w-5 text-primary" />
                </div>
                <div>
                  <CardTitle className="text-lg">Tema de la aplicación</CardTitle>
                  <CardDescription>
                    Personaliza la apariencia de CiudadConecta
                  </CardDescription>
                </div>
              </div>
            </CardHeader>
            <CardContent className="pt-0">
              <RadioGroup value={theme} onValueChange={handleThemeChange} className="space-y-3">
                <div className="flex items-center space-x-3 p-3 rounded-lg hover:bg-gray-50 transition-colors">
                  <RadioGroupItem value="light" id="light" />
                  <Label htmlFor="light" className="flex items-center gap-2 cursor-pointer flex-1">
                    <Sun className="h-4 w-4 text-yellow-500" />
                    <span>Tema claro</span>
                  </Label>
                </div>
                <div className="flex items-center space-x-3 p-3 rounded-lg hover:bg-gray-50 transition-colors">
                  <RadioGroupItem value="dark" id="dark" />
                  <Label htmlFor="dark" className="flex items-center gap-2 cursor-pointer flex-1">
                    <Moon className="h-4 w-4 text-blue-500" />
                    <span>Tema oscuro</span>
                  </Label>
                </div>
                <div className="flex items-center space-x-3 p-3 rounded-lg hover:bg-gray-50 transition-colors">
                  <RadioGroupItem value="system" id="system" />
                  <Label htmlFor="system" className="flex items-center gap-2 cursor-pointer flex-1">
                    <Monitor className="h-4 w-4 text-gray-500" />
                    <span>Seguir sistema</span>
                  </Label>
                </div>
              </RadioGroup>
            </CardContent>
          </Card>

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
              <div className="flex items-center justify-between p-3 rounded-lg bg-gray-50">
                <div className="flex items-center gap-3">
                  <LocateFixed className="h-5 w-5 text-blue-600" />
                  <div>
                    <p className="font-medium text-sm">Ubicación automática</p>
                    <p className="text-xs text-gray-500">
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
              <div className="flex items-center justify-between p-3 rounded-lg bg-gray-50">
                <div className="flex items-center gap-3">
                  <Fingerprint className="h-5 w-5 text-green-600" />
                  <div>
                    <p className="font-medium text-sm">Acceso biométrico</p>
                    <p className="text-xs text-gray-500">
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

          {/* Additional Settings Placeholder */}
          <Card className="border-none shadow-xl">
            <CardHeader className="pb-3">
              <div className="flex items-center gap-3">
                <div className="p-2 bg-blue-100 rounded-lg">
                  <SettingsIcon className="h-5 w-5 text-blue-600" />
                </div>
                <div>
                  <CardTitle className="text-lg">Configuración adicional</CardTitle>
                  <CardDescription>
                    Más opciones próximamente
                  </CardDescription>
                </div>
              </div>
            </CardHeader>
            <CardContent className="pt-0">
              <div className="text-center py-8 text-gray-500">
                <SettingsIcon className="h-12 w-12 mx-auto mb-2 opacity-50" />
                <p className="text-sm">Más configuraciones se añadirán pronto</p>
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
