
import { useState, useEffect } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Switch } from "@/components/ui/switch";
import { Label } from "@/components/ui/label";
import { ArrowLeft, Fingerprint, LocateFixed, Moon, Sun, Activity, Shield } from "lucide-react";
import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { useToast } from "@/hooks/use-toast";
import { initializeAnalytics } from '@/lib/analytics';
import { TwoFactorSetup } from "@/components/TwoFactorSetup";
import { use2FA } from "@/hooks/use2FA";
import { useUserRoles } from "@/hooks/useUserRoles";

const Settings = () => {
  const [biometricEnabled, setBiometricEnabled] = useState(false);
  const [locationServicesEnabled, setLocationServicesEnabled] = useState(false);
  const [isDarkMode, setIsDarkMode] = useState(false);
  const [gaId, setGaId] = useState('');
  const [sentryDsn, setSentryDsn] = useState('');
  const [show2FASetup, setShow2FASetup] = useState(false);
  const { toast } = useToast();
  const { config: twoFactorConfig } = use2FA();
  const { isAdmin } = useUserRoles();

  // Load settings from localStorage on component mount
  useEffect(() => {
    const savedBiometric = localStorage.getItem('biometricEnabled') === 'true';
    const savedLocationServices = localStorage.getItem('locationServicesEnabled') === 'true';
    const savedTheme = localStorage.getItem('theme') || 'light';
    const systemDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
    const savedGaId = localStorage.getItem('ga_measurement_id') || '';
    const savedSentryDsn = localStorage.getItem('sentry_dsn') || '';
    
    setBiometricEnabled(savedBiometric);
    setLocationServicesEnabled(savedLocationServices);
    setGaId(savedGaId);
    setSentryDsn(savedSentryDsn);
    
    // Determine if dark mode is active
    if (savedTheme === 'system') {
      setIsDarkMode(systemDarkMode);
    } else {
      setIsDarkMode(savedTheme === 'dark');
    }
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

  const handleGoogleAnalyticsChange = (value: string) => {
    setGaId(value);
    localStorage.setItem('ga_measurement_id', value);
    
    // Reinicializar Google Analytics inmediatamente si el ID es válido
    if (value && value.startsWith('G-')) {
      initializeAnalytics();
      toast({
        title: "Google Analytics configurado",
        description: "ID configurado correctamente y listo para usar",
      });
    } else if (value) {
      toast({
        title: "ID de Google Analytics inválido",
        description: "El ID debe comenzar con 'G-' seguido de letras y números",
        variant: "destructive",
      });
    }
  };

  const handleSentryDsnChange = (value: string) => {
    setSentryDsn(value);
    localStorage.setItem('sentry_dsn', value);
    
    if (value) {
      toast({
        title: "Sentry DSN configurado",
        description: "Recarga la página para aplicar los cambios de Sentry",
      });
    }
  };

  const handleThemeToggle = (enabled: boolean) => {
    const newTheme = enabled ? 'dark' : 'light';
    const root = window.document.documentElement;
    
    // Remove existing theme classes
    root.classList.remove('light', 'dark');
    root.classList.add(newTheme);
    
    // Save to localStorage
    localStorage.setItem('theme', newTheme);
    setIsDarkMode(enabled);
    
    toast({
      title: enabled ? "Modo oscuro activado" : "Modo claro activado",
      description: enabled ? "La interfaz ahora usa colores oscuros" : "La interfaz ahora usa colores claros",
    });
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

          {/* Theme Toggle */}
          <Card className="border-none shadow-xl">
            <CardHeader className="pb-3">
              <div className="flex items-center gap-3">
                <div className="p-2 bg-purple-100 rounded-lg">
                  {isDarkMode ? (
                    <Moon className="h-5 w-5 text-purple-600" />
                  ) : (
                    <Sun className="h-5 w-5 text-purple-600" />
                  )}
                </div>
                <div>
                  <CardTitle className="text-lg">Tema de la aplicación</CardTitle>
                  <CardDescription>
                    Cambia entre modo claro y modo oscuro
                  </CardDescription>
                </div>
              </div>
            </CardHeader>
            <CardContent className="pt-0">
              <div className="flex items-center justify-between p-3 rounded-lg bg-secondary">
                <div className="flex items-center gap-3">
                  {isDarkMode ? (
                    <Moon className="h-5 w-5 text-purple-600" />
                  ) : (
                    <Sun className="h-5 w-5 text-purple-600" />
                  )}
                  <div>
                    <p className="font-medium text-sm">
                      {isDarkMode ? "Modo oscuro" : "Modo claro"}
                    </p>
                    <p className="text-xs text-muted-foreground">
                      {isDarkMode ? "Colores oscuros para la interfaz" : "Colores claros para la interfaz"}
                    </p>
                  </div>
                </div>
                <Switch
                  checked={isDarkMode}
                  onCheckedChange={handleThemeToggle}
                />
              </div>
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

          {/* Two-Factor Authentication */}
          <Card className="border-none shadow-xl">
            <CardHeader className="pb-3">
              <div className="flex items-center gap-3">
                <div className="p-2 bg-red-100 rounded-lg">
                  <Shield className="h-5 w-5 text-red-600" />
                </div>
                <div>
                  <CardTitle className="text-lg">Autenticación de Dos Factores</CardTitle>
                  <CardDescription>
                    Añade una capa extra de seguridad a tu cuenta
                  </CardDescription>
                </div>
              </div>
            </CardHeader>
            <CardContent className="pt-0">
              <div className="flex items-center justify-between p-3 rounded-lg bg-secondary">
                <div className="flex items-center gap-3">
                  <Shield className="h-5 w-5 text-red-600" />
                  <div>
                    <p className="font-medium text-sm">
                      {twoFactorConfig?.enabled ? "2FA Habilitado" : "2FA Deshabilitado"}
                    </p>
                    <p className="text-xs text-muted-foreground">
                      {twoFactorConfig?.enabled 
                        ? "Tu cuenta está protegida con 2FA" 
                        : "Habilita 2FA para mayor seguridad"
                      }
                    </p>
                  </div>
                </div>
                <Badge variant={twoFactorConfig?.enabled ? "default" : "destructive"}>
                  {twoFactorConfig?.enabled ? "Activo" : "Inactivo"}
                </Badge>
              </div>
              
              <div className="mt-3">
                <Button
                  onClick={() => setShow2FASetup(true)}
                  variant={twoFactorConfig?.enabled ? "outline" : "default"}
                  className="w-full"
                >
                  <Shield className="h-4 w-4 mr-2" />
                  {twoFactorConfig?.enabled ? "Administrar 2FA" : "Configurar 2FA"}
                </Button>
              </div>

              {twoFactorConfig?.enabled && (
                <div className="mt-3 p-3 bg-green-50 border border-green-200 rounded-lg">
                  <p className="text-sm text-green-800">
                    ✅ 2FA está habilitado. Tu cuenta está protegida con autenticación de dos factores.
                  </p>
                  <p className="text-xs text-green-700 mt-1">
                    Configurado el: {new Date(twoFactorConfig.created_at).toLocaleDateString()}
                  </p>
                </div>
              )}
            </CardContent>
          </Card>

          {/* APM Configuration - Solo para administradores */}
          {isAdmin && (
            <Card className="border-none shadow-xl">
              <CardHeader className="pb-3">
                <div className="flex items-center gap-3">
                  <div className="p-2 bg-orange-100 rounded-lg">
                    <Activity className="h-5 w-5 text-orange-600" />
                  </div>
                  <div>
                    <CardTitle className="text-lg">Monitoreo de Rendimiento</CardTitle>
                    <CardDescription>
                      Configurar Google Analytics y Sentry APM
                    </CardDescription>
                  </div>
                </div>
              </CardHeader>
              <CardContent className="pt-0 space-y-3">
                <div className="p-3 rounded-lg bg-secondary">
                  <div className="flex items-center justify-between mb-2">
                    <p className="font-medium text-sm">Google Analytics ID</p>
                    <Badge variant={gaId && gaId.startsWith('G-') ? "default" : "outline"}>
                      {gaId && gaId.startsWith('G-') ? "Configurado" : "No configurado"}
                    </Badge>
                  </div>
                  <p className="text-xs text-muted-foreground mb-2">
                    ID de medición de Google Analytics (G-XXXXXXXXXX)
                  </p>
                  <input 
                    type="text" 
                    placeholder="G-XXXXXXXXXX" 
                    value={gaId}
                    className="w-full p-2 text-sm border rounded-md bg-background"
                    onChange={(e) => handleGoogleAnalyticsChange(e.target.value)}
                  />
                </div>
                
                <div className="p-3 rounded-lg bg-secondary">
                  <div className="flex items-center justify-between mb-2">
                    <p className="font-medium text-sm">Sentry DSN</p>
                    <Badge variant={sentryDsn ? "default" : "outline"}>
                      {sentryDsn ? "Configurado" : "No configurado"}
                    </Badge>
                  </div>
                  <p className="text-xs text-muted-foreground mb-2">
                    DSN de tu proyecto Sentry para APM
                  </p>
                  <input 
                    type="text" 
                    placeholder="https://xxx@xxx.ingest.sentry.io/xxx" 
                    value={sentryDsn}
                    className="w-full p-2 text-sm border rounded-md bg-background"
                    onChange={(e) => handleSentryDsnChange(e.target.value)}
                  />
                </div>
                
                <Link 
                  to="/apm-dashboard" 
                  className="block w-full bg-orange-100 hover:bg-orange-200 text-orange-800 font-medium py-2 px-3 rounded-lg text-center text-sm transition-colors"
                >
                  Ver Dashboard de APM
                </Link>
              </CardContent>
            </Card>
          )}
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

      {/* Two Factor Authentication Setup Modal */}
      <TwoFactorSetup
        open={show2FASetup}
        onOpenChange={setShow2FASetup}
      />
    </div>
  );
};

export default Settings;
