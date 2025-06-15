
import React, { useState, useEffect } from 'react';
import { AlertTriangle, MapPin, Clock, X, Phone, User } from 'lucide-react';
import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { PanicAlert } from '@/hooks/usePanicAlerts';
import { format } from 'date-fns';
import { es } from 'date-fns/locale';

interface PanicAlertOverlayProps {
  alert: PanicAlert;
  onDismiss?: () => void;
}

const PanicAlertOverlay: React.FC<PanicAlertOverlayProps> = ({ alert, onDismiss }) => {
  const [isFlashing, setIsFlashing] = useState(true);
  const [audioPlayed, setAudioPlayed] = useState(false);
  
  const timeLeft = new Date(alert.expires_at).getTime() - new Date().getTime();
  const isExpired = timeLeft <= 0;

  useEffect(() => {
    const flashInterval = setInterval(() => {
      setIsFlashing(prev => !prev);
    }, 800);

    // Play alert sound
    if (!audioPlayed) {
      const audio = new Audio('data:audio/wav;base64,UklGRnoGAABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQoGAACBhYqFbF1fdJivrJBhNjVgodDbq2EcBj+a2/LDciUFLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+L1v2oTBje+9+zfhz8J');
      audio.play().catch(e => console.log('Audio play failed:', e));
      setAudioPlayed(true);
    }

    return () => clearInterval(flashInterval);
  }, [audioPlayed]);

  const formatTime = (dateString: string) => {
    return new Date(dateString).toLocaleString('es-CO', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/70 animate-fade-in p-4">
      <div 
        className={`w-full max-w-2xl mx-4 transition-colors duration-800 ${
          isFlashing ? 'bg-red-700' : 'bg-red-600'
        } rounded-2xl shadow-2xl border-4 border-white overflow-hidden`}
      >
        <Card className="bg-transparent border-none text-white max-h-[90vh] overflow-y-auto">
          <CardHeader className="text-center pb-4">
            <div className="flex items-center justify-between mb-4">
              <div className="flex-1"></div>
              {onDismiss && (
                <Button
                  variant="ghost"
                  size="icon"
                  onClick={onDismiss}
                  className="text-white/80 hover:text-white hover:bg-white/20"
                >
                  <X className="h-5 w-5" />
                </Button>
              )}
            </div>
            
            <div className="mx-auto bg-white/20 p-4 rounded-full w-fit mb-4">
              <AlertTriangle className="h-12 w-12 text-white animate-pulse" />
            </div>
            <CardTitle className="text-3xl font-bold text-white mb-2">
              ¡ALERTA DE PÁNICO!
            </CardTitle>
            <div className="bg-white/10 backdrop-blur-sm rounded-xl p-4 space-y-2">
              <p className="text-xl font-semibold">
                {isExpired ? 'ALERTA EXPIRADA' : 'ALERTA ACTIVA'}
              </p>
              <p className="text-sm opacity-90">Activada: {formatTime(alert.created_at)}</p>
            </div>
          </CardHeader>
          
          <CardContent className="space-y-4">
            {/* Person Information */}
            <div className="bg-white/15 backdrop-blur-sm rounded-xl p-4 space-y-3">
              <div className="flex items-center gap-2 mb-3">
                <User className="h-5 w-5 text-white" />
                <h3 className="text-lg font-bold text-white">PERSONA EN EMERGENCIA</h3>
              </div>
              
              <div>
                <p className="text-sm text-white/80">Nombre:</p>
                <p className="text-lg font-bold text-white">{alert.user_full_name}</p>
              </div>
            </div>

            {/* Location and Time */}
            <div className="bg-white/15 backdrop-blur-sm rounded-xl p-4 space-y-3">
              <div className="flex items-center gap-2 mb-3">
                <MapPin className="h-5 w-5 text-white" />
                <h3 className="text-lg font-bold text-white">UBICACIÓN Y TIEMPO</h3>
              </div>
              
              <div className="flex items-center gap-2">
                <Clock className="h-4 w-4 text-white" />
                <div>
                  <p className="text-sm text-white/80">Hora de activación:</p>
                  <p className="text-md text-white">{format(new Date(alert.created_at), 'HH:mm:ss - dd/MM/yyyy', { locale: es })}</p>
                </div>
              </div>
              
              {alert.address && (
                <div className="flex items-start gap-2">
                  <MapPin className="h-4 w-4 mt-0.5 flex-shrink-0 text-white" />
                  <div>
                    <p className="text-sm text-white/80">Ubicación reportada:</p>
                    <p className="text-md text-white">{alert.address}</p>
                  </div>
                </div>
              )}

              {alert.latitude && alert.longitude && (
                <div className="flex items-center gap-2">
                  <MapPin className="h-4 w-4 text-white" />
                  <div>
                    <p className="text-sm text-white/80">Coordenadas:</p>
                    <p className="text-sm font-mono text-white">
                      {alert.latitude.toFixed(6)}, {alert.longitude.toFixed(6)}
                    </p>
                  </div>
                </div>
              )}
            </div>

            {/* Emergency Contact Information */}
            <div className="bg-white/20 backdrop-blur-sm rounded-xl p-4 text-center">
              <Phone className="h-8 w-8 text-white mx-auto mb-2" />
              <p className="text-lg font-bold text-white mb-1">CONTACTO DE EMERGENCIA</p>
              <p className="text-xl font-bold text-white mb-2">911</p>
              <p className="text-sm text-white/90">¡Si conoces la ubicación de esta persona o tienes información relevante, contacta inmediatamente!</p>
            </div>

            {!isExpired && (
              <div className="bg-white/10 backdrop-blur-sm rounded-xl p-4">
                <Alert variant="destructive" className="bg-red-800/50 border-red-400 text-white">
                  <AlertTriangle className="h-4 w-4 text-white" />
                  <AlertTitle className="text-white">⚠️ IMPORTANTE</AlertTitle>
                  <AlertDescription className="text-white/90">
                    Si conoces la ubicación de esta persona o tienes información relevante, 
                    contacta inmediatamente a las autoridades locales o al número de emergencias.
                  </AlertDescription>
                </Alert>
              </div>
            )}

            <div className="flex gap-3">
              <Button
                onClick={() => {
                  if (alert.latitude && alert.longitude) {
                    window.open(`https://maps.google.com/?q=${alert.latitude},${alert.longitude}`, '_blank');
                  }
                }}
                disabled={!alert.latitude || !alert.longitude}
                className="flex-1 bg-white text-red-600 hover:bg-white/90 font-bold py-3"
              >
                <MapPin className="h-5 w-5 mr-2" />
                VER EN MAPA
              </Button>
              
              <Button
                onClick={() => {
                  window.open('tel:911', '_self');
                }}
                className="flex-1 bg-white text-red-600 hover:bg-white/90 font-bold py-3"
              >
                <Phone className="h-5 w-5 mr-2" />
                LLAMAR 911
              </Button>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default PanicAlertOverlay;
