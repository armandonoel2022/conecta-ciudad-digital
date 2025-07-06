
import React, { useState, useEffect } from 'react';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { AlertTriangle, Phone, MapPin, X, Clock, User } from 'lucide-react';
import { AmberAlert } from '@/hooks/useAmberAlerts';
import { useAlertSound } from '@/hooks/useAlertSound';

interface AmberAlertOverlayProps {
  alert: AmberAlert;
  onResolve: (alertId: string) => void;
  onReport: () => void;
}

const AmberAlertOverlay = ({ alert, onResolve, onReport }: AmberAlertOverlayProps) => {
  const [isFlashing, setIsFlashing] = useState(true);
  const [alertTriggered, setAlertTriggered] = useState(false);
  const { triggerAlert, forceInitAudio } = useAlertSound();

  useEffect(() => {
    const flashInterval = setInterval(() => {
      setIsFlashing(prev => !prev);
    }, 800);

    // Trigger alert sound and notification
    if (!alertTriggered) {
      const triggerSound = async () => {
        console.log('Triggering amber alert sound...');
        await forceInitAudio();
        await triggerAlert({
          type: 'amber',
          title: '¡ALERTA AMBER!',
          message: `Menor desaparecido: ${alert.child_full_name}. Última vez visto en: ${alert.last_seen_location}`,
          autoPlay: true
        });
      };
      triggerSound();
      setAlertTriggered(true);
    }

    return () => clearInterval(flashInterval);
  }, [alertTriggered, triggerAlert, alert]);

  const formatTime = (dateString: string) => {
    return new Date(dateString).toLocaleString('es-CO', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  const formatDisappearanceTime = (dateString: string) => {
    return new Date(dateString).toLocaleString('es-CO', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/70 animate-fade-in p-4">
      <div 
        className={`w-full max-w-2xl mx-4 transition-colors duration-800 ${
          isFlashing ? 'bg-amber-600' : 'bg-amber-500'
        } rounded-2xl shadow-2xl border-4 border-white overflow-hidden`}
      >
        <Card className="bg-transparent border-none text-white max-h-[90vh] overflow-y-auto">
          <CardHeader className="text-center pb-4">
            <div className="flex items-center justify-between mb-4">
              <div className="flex-1"></div>
              <Button
                variant="ghost"
                size="icon"
                onClick={() => onResolve(alert.id)}
                className="text-white/80 hover:text-white hover:bg-white/20"
              >
                <X className="h-5 w-5" />
              </Button>
            </div>
            
            <div className="mx-auto bg-white/20 p-4 rounded-full w-fit mb-4">
              <AlertTriangle className="h-12 w-12 text-white animate-pulse" />
            </div>
            <CardTitle className="text-3xl font-bold text-white mb-2">
              ¡ALERTA AMBER!
            </CardTitle>
            <div className="bg-white/10 backdrop-blur-sm rounded-xl p-4 space-y-2">
              <p className="text-xl font-semibold">MENOR DESAPARECIDO</p>
              <p className="text-sm opacity-90">Reportado: {formatTime(alert.created_at)}</p>
            </div>
          </CardHeader>
          
          <CardContent className="space-y-4">
            {/* Child Information */}
            <div className="bg-white/15 backdrop-blur-sm rounded-xl p-4 space-y-3">
              <div className="flex items-center gap-2 mb-3">
                <User className="h-5 w-5 text-white" />
                <h3 className="text-lg font-bold text-white">INFORMACIÓN DEL MENOR</h3>
              </div>
              
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                {alert.child_photo_url && (
                  <div className="md:col-span-1">
                    <img 
                      src={alert.child_photo_url} 
                      alt={alert.child_full_name}
                      className="w-full h-48 object-contain bg-white/10 rounded-lg border-2 border-white/30"
                    />
                  </div>
                )}
                
                <div className="space-y-2">
                  <div>
                    <p className="text-sm text-white/80">Nombre completo:</p>
                    <p className="text-lg font-bold text-white">{alert.child_full_name}</p>
                  </div>
                  
                  {alert.child_nickname && (
                    <div>
                      <p className="text-sm text-white/80">Apodo:</p>
                      <p className="text-md text-white">{alert.child_nickname}</p>
                    </div>
                  )}
                  
                  {alert.medical_conditions && (
                    <div>
                      <p className="text-sm text-white/80">Condiciones médicas:</p>
                      <p className="text-md text-white">{alert.medical_conditions}</p>
                    </div>
                  )}
                </div>
              </div>
            </div>

            {/* Location and Time */}
            <div className="bg-white/15 backdrop-blur-sm rounded-xl p-4 space-y-3">
              <div className="flex items-center gap-2 mb-3">
                <MapPin className="h-5 w-5 text-white" />
                <h3 className="text-lg font-bold text-white">UBICACIÓN Y TIEMPO</h3>
              </div>
              
              <div>
                <p className="text-sm text-white/80">Última vez visto en:</p>
                <p className="text-lg font-semibold text-white">{alert.last_seen_location}</p>
              </div>
              
              <div className="flex items-center gap-2">
                <Clock className="h-4 w-4 text-white" />
                <div>
                  <p className="text-sm text-white/80">Hora de desaparición:</p>
                  <p className="text-md text-white">{formatDisappearanceTime(alert.disappearance_time)}</p>
                </div>
              </div>
            </div>

            {/* Contact Information */}
            <div className="bg-white/20 backdrop-blur-sm rounded-xl p-4 text-center">
              <Phone className="h-8 w-8 text-white mx-auto mb-2" />
              <p className="text-lg font-bold text-white mb-1">INFORMACIÓN DE CONTACTO</p>
              <p className="text-xl font-bold text-white mb-2">{alert.contact_number}</p>
              <p className="text-sm text-white/90">¡Si ves a este menor, contacta inmediatamente!</p>
            </div>

            {/* Additional Details */}
            {alert.additional_details && (
              <div className="bg-white/10 backdrop-blur-sm rounded-xl p-4">
                <h3 className="text-md font-bold text-white mb-2">Detalles adicionales:</h3>
                <p className="text-sm text-white/90">{alert.additional_details}</p>
              </div>
            )}

            <div className="flex gap-3">
              <Button 
                onClick={onReport}
                className="flex-1 bg-white text-amber-600 hover:bg-white/90 font-bold py-3"
              >
                <Phone className="h-5 w-5 mr-2" />
                REPORTAR AVISTAMIENTO
              </Button>
              <Button 
                onClick={() => onResolve(alert.id)}
                variant="outline"
                className="flex-1 border-white/80 text-white bg-white/10 hover:bg-white/30 hover:text-white font-bold py-3"
              >
                <X className="h-5 w-5 mr-2" />
                MARCAR RESUELTO
              </Button>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default AmberAlertOverlay;
