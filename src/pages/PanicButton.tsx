import { useState } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { AlarmClockOff, ArrowLeft, MapPin, AlertTriangle, Clock, User, Locate, CheckCircle, Shield } from "lucide-react";
import { Link } from "react-router-dom";
import { usePanicAlerts } from "@/hooks/usePanicAlerts";
import { useAuth } from "@/hooks/useAuth";
import { useToast } from "@/hooks/use-toast";
import { format } from 'date-fns';
import { es } from 'date-fns/locale';

const PanicButton = () => {
  const [isActivating, setIsActivating] = useState(false);
  const [isDeactivating, setIsDeactivating] = useState<string | null>(null);
  const [isGettingLocation, setIsGettingLocation] = useState(false);
  const [manualAddress, setManualAddress] = useState("");
  const [location, setLocation] = useState<{ latitude: number; longitude: number; address?: string } | null>(null);
  const { alerts, createPanicAlert, deactivatePanicAlert, deactivateAllUserAlerts, loading } = usePanicAlerts();
  const { user } = useAuth();
  const { toast } = useToast();

  const getLocation = (): Promise<{ latitude: number; longitude: number; address?: string }> => {
    return new Promise((resolve, reject) => {
      if (!navigator.geolocation) {
        reject(new Error('Geolocalización no soportada'));
        return;
      }

      navigator.geolocation.getCurrentPosition(
        async (position) => {
          const { latitude, longitude } = position.coords;
          
          try {
            // Try to get address from coordinates
            const response = await fetch(
              `https://api.openstreetmap.org/reverse?lat=${latitude}&lon=${longitude}&format=json`
            );
            const data = await response.json();
            const address = data.display_name;
            
            resolve({ latitude, longitude, address });
          } catch (error) {
            // If reverse geocoding fails, just return coordinates
            resolve({ latitude, longitude });
          }
        },
        (error) => {
          reject(new Error('No se pudo obtener la ubicación: ' + error.message));
        },
        { enableHighAccuracy: true, timeout: 10000, maximumAge: 300000 }
      );
    });
  };

  const handleGetCurrentLocation = async () => {
    setIsGettingLocation(true);
    
    try {
      toast({
        title: "Obteniendo ubicación...",
        description: "Por favor permite el acceso a tu ubicación.",
      });

      const locationData = await getLocation();
      setLocation(locationData);
      setManualAddress(locationData.address || "");

      toast({
        title: "Ubicación obtenida",
        description: "Se ha actualizado tu ubicación actual.",
      });

    } catch (error) {
      console.error('Error getting location:', error);
      toast({
        title: "Error al obtener ubicación",
        description: error instanceof Error ? error.message : "Inténtalo nuevamente.",
        variant: "destructive",
      });
    } finally {
      setIsGettingLocation(false);
    }
  };

  const handlePanicActivation = async () => {
    if (isActivating) return;

    setIsActivating(true);
    
    try {
      let locationData = location;
      
      // If we have a manual address but no coordinates, use just the address
      if (manualAddress && !locationData) {
        locationData = { latitude: 0, longitude: 0, address: manualAddress };
      } else if (manualAddress && locationData) {
        // If we have both coordinates and manual address, use the manual address
        locationData = { ...locationData, address: manualAddress };
      } else if (!locationData && !manualAddress) {
        // If no location data at all, try to get it
        toast({
          title: "Obteniendo ubicación...",
          description: "Por favor permite el acceso a tu ubicación.",
        });

        locationData = await getLocation();
        setLocation(locationData);
      }

      // Create panic alert
      await createPanicAlert(locationData);

      toast({
        title: "¡ALERTA DE PÁNICO ACTIVADA!",
        description: "Se ha enviado la alerta a todos los usuarios de la aplicación.",
        variant: "destructive",
      });

    } catch (error) {
      console.error('Error activating panic alert:', error);
      toast({
        title: "Error al activar la alerta",
        description: error instanceof Error ? error.message : "Inténtalo nuevamente.",
        variant: "destructive",
      });
    } finally {
      setIsActivating(false);
    }
  };

  const handleDeactivateAlert = async (alertId: string) => {
    setIsDeactivating(alertId);
    
    try {
      await deactivatePanicAlert(alertId);
      
      toast({
        title: "✅ ALERTA DESACTIVADA",
        description: "Tu alerta de pánico ha sido desactivada exitosamente.",
        variant: "default",
      });
    } catch (error) {
      console.error('Error deactivating alert:', error);
      toast({
        title: "Error al desactivar alerta",
        description: error instanceof Error ? error.message : "Inténtalo nuevamente.",
        variant: "destructive",
      });
    } finally {
      setIsDeactivating(null);
    }
  };

  const handleDeactivateAllAlerts = async () => {
    setIsDeactivating('all');
    
    try {
      await deactivateAllUserAlerts();
      
      toast({
        title: "✅ TODAS LAS ALERTAS DESACTIVADAS",
        description: "Se han desactivado todas tus alertas de pánico activas.",
        variant: "default",
      });
    } catch (error) {
      console.error('Error deactivating all alerts:', error);
      toast({
        title: "Error al desactivar alertas",
        description: error instanceof Error ? error.message : "Inténtalo nuevamente.",
        variant: "destructive",
      });
    } finally {
      setIsDeactivating(null);
    }
  };

  // Filter user's active alerts
  const userActiveAlerts = alerts.filter(alert => 
    alert.user_id === user?.id && 
    alert.is_active && 
    new Date(alert.expires_at) > new Date()
  );

  // Filter all active alerts
  const allActiveAlerts = alerts.filter(alert => 
    alert.is_active && new Date(alert.expires_at) > new Date()
  );
  
  const recentAlerts = alerts.filter(alert => 
    new Date().getTime() - new Date(alert.created_at).getTime() < 24 * 60 * 60 * 1000 // Last 24 hours
  ).slice(0, 5);

  return (
    <div className="min-h-screen bg-gradient-to-br from-red-600 via-red-500 to-red-700 p-4 animate-fade-in">
      <div className="max-w-md mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-4">
          <Link to="/" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold">BOTÓN DE PÁNICO</h1>
            <p className="text-white/80">Alerta de emergencia</p>
          </div>
        </div>

        {/* User's Active Alerts - Show first if they exist */}
        {userActiveAlerts.length > 0 && (
          <div className="bg-white rounded-[2rem] p-6 shadow-xl border-4 border-red-500">
            {/* Big Alert Badge */}
            <div className="bg-red-600 text-white p-4 rounded-2xl mb-6 text-center">
              <div className="flex items-center justify-center gap-2 mb-2">
                <AlertTriangle className="h-8 w-8 animate-pulse" />
                <span className="text-2xl font-bold">¡ALERTA ACTIVA!</span>
              </div>
              <p className="text-red-100">Tu alerta de pánico está siendo enviada</p>
            </div>

            <h3 className="text-lg font-bold text-red-600 mb-4 flex items-center gap-2">
              <Shield className="h-5 w-5" />
              Tus Alertas ({userActiveAlerts.length})
            </h3>
            
            <div className="space-y-4 mb-6">
              {userActiveAlerts.map((alert) => (
                <div key={alert.id} className="p-4 bg-red-50 rounded-xl border-2 border-red-300">
                  <div className="flex items-center gap-2 mb-3">
                    <AlertTriangle className="h-5 w-5 text-red-600 animate-pulse" />
                    <span className="font-bold text-red-800 text-lg">ALERTA ENVIÁNDOSE</span>
                  </div>
                  <div className="flex items-center gap-2 text-sm text-red-600 mb-2">
                    <Clock className="h-4 w-4" />
                    <span>Activada: {format(new Date(alert.created_at), 'HH:mm:ss', { locale: es })}</span>
                  </div>
                  {alert.address && (
                    <div className="flex items-start gap-2 text-sm text-red-600 mb-4">
                      <MapPin className="h-4 w-4 mt-0.5 flex-shrink-0" />
                      <span className="line-clamp-2">{alert.address}</span>
                    </div>
                  )}
                  
                  {/* Large Deactivate Button */}
                  <Button
                    onClick={() => handleDeactivateAlert(alert.id)}
                    disabled={isDeactivating === alert.id}
                    className="w-full h-14 bg-green-600 hover:bg-green-700 text-white text-lg font-bold rounded-xl"
                  >
                    {isDeactivating === alert.id ? (
                      <>
                        <div className="animate-spin rounded-full h-5 w-5 border-b-2 border-white mr-3"></div>
                        Desactivando...
                      </>
                    ) : (
                      <>
                        <CheckCircle className="h-5 w-5 mr-3" />
                        DESACTIVAR ALERTA
                      </>
                    )}
                  </Button>
                </div>
              ))}
            </div>
            
            {userActiveAlerts.length > 1 && (
              <Button
                onClick={handleDeactivateAllAlerts}
                disabled={isDeactivating === 'all'}
                variant="outline"
                className="w-full h-12 border-2 border-green-600 text-green-600 hover:bg-green-50 font-bold"
              >
                {isDeactivating === 'all' ? (
                  <>
                    <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-green-600 mr-2"></div>
                    Desactivando todas...
                  </>
                ) : (
                  <>
                    <CheckCircle className="h-4 w-4 mr-2" />
                    DESACTIVAR TODAS MIS ALERTAS
                  </>
                )}
              </Button>
            )}
          </div>
        )}

        {/* Main Panic Button - Only show if no active alerts */}
        {userActiveAlerts.length === 0 && (
          <div className="bg-white rounded-[2rem] p-6 shadow-xl">
            <Card className="border-none shadow-none text-center">
              <CardHeader>
                <div className="mx-auto bg-red-100 p-6 rounded-full w-fit mb-4">
                  <AlarmClockOff className="h-16 w-16 text-red-600" />
                </div>
                <CardTitle className="text-2xl text-gray-800 mb-2">
                  Botón de Pánico
                </CardTitle>
                <CardDescription className="text-gray-600 mb-6">
                  Presiona el botón para enviar una alerta de emergencia a todos los usuarios
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-6">
                {/* Location Input Section */}
                <div className="space-y-4 text-left">
                  <div className="space-y-2">
                    <Label htmlFor="address" className="text-sm font-medium text-gray-700">
                      Dirección o ubicación
                    </Label>
                    <Input
                      id="address"
                      placeholder="Ingresa tu dirección actual..."
                      value={manualAddress}
                      onChange={(e) => setManualAddress(e.target.value)}
                      className="w-full"
                    />
                  </div>
                  
                  <Button
                    onClick={handleGetCurrentLocation}
                    disabled={isGettingLocation}
                    variant="outline"
                    className="w-full flex items-center gap-2"
                  >
                    {isGettingLocation ? (
                      <>
                        <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-blue-600"></div>
                        Obteniendo ubicación...
                      </>
                    ) : (
                      <>
                        <Locate className="h-4 w-4" />
                        Usar mi ubicación actual
                      </>
                    )}
                  </Button>

                  {location && (
                    <div className="text-xs text-gray-500 bg-green-50 p-3 rounded-lg border border-green-200">
                      <div className="flex items-start gap-2">
                        <MapPin className="h-4 w-4 text-green-600 mt-0.5 flex-shrink-0" />
                        <div>
                          <p className="font-medium text-green-800 mb-1">Ubicación detectada:</p>
                          <p>{location.address || `${location.latitude}, ${location.longitude}`}</p>
                        </div>
                      </div>
                    </div>
                  )}
                </div>

                <Button
                  onClick={handlePanicActivation}
                  disabled={isActivating}
                  className="w-full h-16 bg-red-600 hover:bg-red-700 text-white text-lg font-bold rounded-xl shadow-lg transform transition-all duration-200 hover:scale-105 active:scale-95"
                >
                  {isActivating ? (
                    <>
                      <div className="animate-spin rounded-full h-6 w-6 border-b-2 border-white mr-3"></div>
                      Activando alerta...
                    </>
                  ) : (
                    <>
                      <AlertTriangle className="h-6 w-6 mr-3" />
                      ACTIVAR ALERTA
                    </>
                  )}
                </Button>

                <div className="text-sm text-gray-500 bg-yellow-50 p-3 rounded-lg">
                  <p className="font-medium text-yellow-800 mb-1">⚠️ Importante:</p>
                  <p>Esta alerta se enviará a todos los usuarios y expirará automáticamente en 1 minuto.</p>
                </div>
              </CardContent>
            </Card>
          </div>
        )}

        {/* Other Active Alerts */}
        {allActiveAlerts.filter(alert => alert.user_id !== user?.id).length > 0 && (
          <div className="bg-white rounded-[2rem] p-6 shadow-xl">
            <h3 className="text-lg font-bold text-red-600 mb-4 flex items-center gap-2">
              <AlertTriangle className="h-5 w-5" />
              Otras Alertas Activas ({allActiveAlerts.filter(alert => alert.user_id !== user?.id).length})
            </h3>
            <div className="space-y-3">
              {allActiveAlerts.filter(alert => alert.user_id !== user?.id).map((alert) => (
                <div key={alert.id} className="p-3 bg-red-50 rounded-lg border border-red-200">
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <div className="flex items-center gap-2 mb-1">
                        <User className="h-4 w-4 text-red-600" />
                        <span className="font-medium text-red-800">{alert.user_full_name}</span>
                      </div>
                      <div className="flex items-center gap-2 text-sm text-red-600 mb-1">
                        <Clock className="h-4 w-4" />
                        <span>{format(new Date(alert.created_at), 'HH:mm:ss', { locale: es })}</span>
                      </div>
                      {alert.address && (
                        <div className="flex items-start gap-2 text-sm text-red-600">
                          <MapPin className="h-4 w-4 mt-0.5 flex-shrink-0" />
                          <span className="line-clamp-2">{alert.address}</span>
                        </div>
                      )}
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Recent Alerts History */}
        <div className="bg-white rounded-[2rem] p-6 shadow-xl">
          <h3 className="text-lg font-bold text-gray-800 mb-4 flex items-center gap-2">
            <Clock className="h-5 w-5" />
            Historial Reciente
          </h3>
          
          {loading ? (
            <div className="flex justify-center py-8">
              <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-red-600"></div>
            </div>
          ) : recentAlerts.length > 0 ? (
            <div className="space-y-3">
              {recentAlerts.map((alert) => (
                <div key={alert.id} className={`p-3 rounded-lg border ${
                  alert.is_active && new Date(alert.expires_at) > new Date()
                    ? 'bg-red-50 border-red-200'
                    : 'bg-gray-50 border-gray-200'
                }`}>
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <div className="flex items-center gap-2 mb-1">
                        <User className="h-4 w-4 text-gray-600" />
                        <span className="font-medium text-gray-800">{alert.user_full_name}</span>
                        {alert.user_id === user?.id && (
                          <span className="px-2 py-1 bg-blue-100 text-blue-700 text-xs rounded-full font-medium">
                            Tuya
                          </span>
                        )}
                        {alert.is_active && new Date(alert.expires_at) > new Date() && (
                          <span className="px-2 py-1 bg-red-100 text-red-700 text-xs rounded-full font-medium">
                            Activa
                          </span>
                        )}
                        {!alert.is_active && (
                          <span className="px-2 py-1 bg-green-100 text-green-700 text-xs rounded-full font-medium">
                            Desactivada
                          </span>
                        )}
                      </div>
                      <div className="flex items-center gap-2 text-sm text-gray-600 mb-1">
                        <Clock className="h-4 w-4" />
                        <span>{format(new Date(alert.created_at), 'dd/MM/yyyy HH:mm:ss', { locale: es })}</span>
                      </div>
                      {alert.address && (
                        <div className="flex items-start gap-2 text-sm text-gray-600">
                          <MapPin className="h-4 w-4 mt-0.5 flex-shrink-0" />
                          <span className="line-clamp-2">{alert.address}</span>
                        </div>
                      )}
                    </div>
                  </div>
                </div>
              ))}
            </div>
          ) : (
            <p className="text-gray-500 text-center py-8">No hay alertas recientes</p>
          )}
        </div>
      </div>
    </div>
  );
};

export default PanicButton;
