import React, { useState, useEffect } from 'react';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { AlertTriangle, MapPin, Phone, CheckCircle } from 'lucide-react';
import { useToast } from '@/hooks/use-toast';
import { useAuth } from '@/hooks/useAuth';
import { usePanicAlerts } from '@/hooks/usePanicAlerts';
import { supabase } from '@/integrations/supabase/client';

const PanicButton = () => {
  const [isActivating, setIsActivating] = useState(false);
  const [isResolving, setIsResolving] = useState(false);
  const [userProfile, setUserProfile] = useState<{ first_name?: string; last_name?: string } | null>(null);
  const [location, setLocation] = useState<{ latitude: number; longitude: number } | null>(null);
  const { toast } = useToast();
  const { user } = useAuth();
  const { createPanicAlert, resolvePanicAlert, alerts } = usePanicAlerts();

  useEffect(() => {
    const fetchUserProfile = async () => {
      if (user) {
        try {
          const { data, error } = await supabase
            .from('profiles')
            .select('first_name, last_name')
            .eq('id', user.id)
            .single();

          if (error && error.code !== 'PGRST116') {
            console.error('Error fetching user profile:', error);
          } else if (data) {
            setUserProfile(data);
          }
        } catch (error) {
          console.error('Error fetching user profile:', error);
        }
      }
    };

    fetchUserProfile();
  }, [user]);

  const getCurrentLocation = (): Promise<{ latitude: number; longitude: number }> => {
    return new Promise((resolve, reject) => {
      if (!navigator.geolocation) {
        reject(new Error('Geolocalización no disponible'));
        return;
      }

      navigator.geolocation.getCurrentPosition(
        (position) => {
          resolve({
            latitude: position.coords.latitude,
            longitude: position.coords.longitude,
          });
        },
        (error) => {
          console.error('Error getting location:', error);
          reject(error);
        },
        {
          enableHighAccuracy: true,
          timeout: 10000,
          maximumAge: 300000,
        }
      );
    });
  };

  const handlePanicAlert = async () => {
    if (!user || !userProfile) {
      toast({
        title: "Error",
        description: "Necesitas completar tu perfil para usar el botón de pánico.",
        variant: "destructive",
      });
      return;
    }

    setIsActivating(true);

    try {
      let locationData = location;
      
      // Try to get current location
      try {
        locationData = await getCurrentLocation();
        setLocation(locationData);
      } catch (locationError) {
        console.warn('Could not get location:', locationError);
      }

      const fullName = `${userProfile.first_name || ''} ${userProfile.last_name || ''}`.trim() || user.email || 'Usuario';

      await createPanicAlert({
        user_full_name: fullName,
        latitude: locationData?.latitude,
        longitude: locationData?.longitude,
        location_description: locationData 
          ? `Lat: ${locationData.latitude.toFixed(6)}, Lng: ${locationData.longitude.toFixed(6)}`
          : 'Ubicación no disponible',
      });

      toast({
        title: "Alerta activada",
        description: "Se ha enviado una alerta de pánico a las autoridades. Mantente seguro.",
      });
    } catch (error) {
      console.error('Error creating panic alert:', error);
      toast({
        title: "Error",
        description: "No se pudo enviar la alerta. Inténtalo nuevamente.",
        variant: "destructive",
      });
    } finally {
      setIsActivating(false);
    }
  };

  const handleResolveAlert = async () => {
    if (!userActiveAlert) return;

    setIsResolving(true);
    try {
      await resolvePanicAlert(userActiveAlert.id);
      toast({
        title: "Alerta resuelta",
        description: "Tu alerta de pánico ha sido marcada como resuelta.",
      });
    } catch (error) {
      console.error('Error resolving alert:', error);
      toast({
        title: "Error",
        description: "No se pudo resolver la alerta. Inténtalo nuevamente.",
        variant: "destructive",
      });
    } finally {
      setIsResolving(false);
    }
  };

  // Check if user has an active alert
  const userActiveAlert = alerts.find(alert => alert.user_id === user?.id && alert.is_active);

  return (
    <div className="min-h-screen bg-gradient-to-br from-red-600 via-red-500 to-orange-600 p-4">
      <div className="max-w-md mx-auto space-y-6">
        <div className="text-center text-white mb-8">
          <AlertTriangle className="h-16 w-16 mx-auto mb-4" />
          <h1 className="text-3xl font-bold mb-2">Botón de Pánico</h1>
          <p className="text-red-100">Para emergencias únicamente</p>
        </div>

        {userActiveAlert ? (
          <Card className="bg-red-900/20 border-red-400 text-white">
            <CardHeader>
              <CardTitle className="text-red-100">Alerta Activa</CardTitle>
              <CardDescription className="text-red-200">
                Ya tienes una alerta de pánico activa. Las autoridades han sido notificadas.
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="space-y-2 text-sm">
                <p><strong>Activada:</strong> {new Date(userActiveAlert.created_at).toLocaleString()}</p>
                {userActiveAlert.location_description && (
                  <p><strong>Ubicación:</strong> {userActiveAlert.location_description}</p>
                )}
              </div>
              
              <Button
                onClick={handleResolveAlert}
                disabled={isResolving}
                size="lg"
                className="w-full bg-green-600 hover:bg-green-700 text-white font-bold"
              >
                {isResolving ? (
                  <div className="flex items-center space-x-2">
                    <div className="animate-spin rounded-full h-5 w-5 border-b-2 border-white"></div>
                    <span>Resolviendo...</span>
                  </div>
                ) : (
                  <div className="flex items-center space-x-2">
                    <CheckCircle className="h-5 w-5" />
                    <span>Marcar como Solucionada</span>
                  </div>
                )}
              </Button>
              
              <p className="text-xs text-red-200 text-center">
                Solo marca como solucionada si ya no necesitas ayuda de emergencia
              </p>
            </CardContent>
          </Card>
        ) : (
          <Card className="bg-white/10 backdrop-blur-sm border-white/20">
            <CardHeader>
              <CardTitle className="text-white">¿Estás en peligro?</CardTitle>
              <CardDescription className="text-red-100">
                Presiona el botón solo en caso de emergencia real. Se alertará inmediatamente a las autoridades.
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <Button
                onClick={handlePanicAlert}
                disabled={isActivating}
                size="lg"
                className="w-full h-20 bg-red-600 hover:bg-red-700 text-white text-xl font-bold rounded-2xl shadow-lg transform hover:scale-105 transition-all"
              >
                {isActivating ? (
                  <div className="flex items-center space-x-2">
                    <div className="animate-spin rounded-full h-6 w-6 border-b-2 border-white"></div>
                    <span>ENVIANDO ALERTA...</span>
                  </div>
                ) : (
                  <div className="flex items-center space-x-2">
                    <AlertTriangle className="h-8 w-8" />
                    <span>ACTIVAR PÁNICO</span>
                  </div>
                )}
              </Button>

              <div className="text-center text-white/80 text-sm space-y-2">
                <p className="flex items-center justify-center space-x-2">
                  <MapPin className="h-4 w-4" />
                  <span>Se compartirá tu ubicación actual</span>
                </p>
                <p className="flex items-center justify-center space-x-2">
                  <Phone className="h-4 w-4" />
                  <span>Emergencias: 123</span>
                </p>
              </div>
            </CardContent>
          </Card>
        )}

        <Card className="bg-white/10 backdrop-blur-sm border-white/20">
          <CardHeader>
            <CardTitle className="text-white text-lg">Instrucciones Importantes</CardTitle>
          </CardHeader>
          <CardContent className="text-white/90 text-sm space-y-2">
            <ul className="list-disc list-inside space-y-1">
              <li>Solo usar en emergencias reales</li>
              <li>Mantente en un lugar seguro si es posible</li>
              <li>Las autoridades serán notificadas inmediatamente</li>
              <li>Proporciona información adicional cuando llegue la ayuda</li>
            </ul>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default PanicButton;
