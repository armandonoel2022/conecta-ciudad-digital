
import React, { useState, useEffect } from 'react';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { AlertTriangle, Phone, MapPin, X } from 'lucide-react';
import { PanicAlert } from '@/hooks/usePanicAlerts';

interface PanicAlertOverlayProps {
  alert: PanicAlert;
  onResolve: (alertId: string) => void;
  onReport: () => void;
}

const PanicAlertOverlay = ({ alert, onResolve, onReport }: PanicAlertOverlayProps) => {
  const [isFlashing, setIsFlashing] = useState(true);

  useEffect(() => {
    const flashInterval = setInterval(() => {
      setIsFlashing(prev => !prev);
    }, 500);

    return () => clearInterval(flashInterval);
  }, []);

  const formatTime = (dateString: string) => {
    return new Date(dateString).toLocaleTimeString('es-CO', {
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 animate-fade-in">
      <div 
        className={`w-full max-w-md mx-4 transition-colors duration-500 ${
          isFlashing ? 'bg-red-600' : 'bg-red-500'
        } rounded-2xl shadow-2xl border-4 border-white relative`}
      >
        {/* Close button */}
        <button
          onClick={() => onResolve(alert.id)}
          className="absolute -top-2 -right-2 bg-white rounded-full p-2 shadow-lg hover:bg-gray-100 transition-colors z-10"
        >
          <X className="h-5 w-5 text-red-600" />
        </button>

        <Card className="bg-transparent border-none text-white">
          <CardHeader className="text-center pb-4">
            <div className="mx-auto bg-white/20 p-4 rounded-full w-fit mb-4">
              <AlertTriangle className="h-12 w-12 text-white animate-pulse" />
            </div>
            <CardTitle className="text-3xl font-bold text-white mb-2">
              ¡ALERTA DE PÁNICO!
            </CardTitle>
            <div className="bg-white/10 backdrop-blur-sm rounded-xl p-4 space-y-2">
              <p className="text-xl font-semibold">{alert.user_full_name}</p>
              <p className="text-sm opacity-90">Solicita ayuda urgente</p>
              <p className="text-xs">Alerta creada: {formatTime(alert.created_at)}</p>
            </div>
          </CardHeader>
          
          <CardContent className="space-y-4">
            {alert.location_description && (
              <div className="bg-white/10 backdrop-blur-sm rounded-xl p-3 flex items-center gap-2">
                <MapPin className="h-5 w-5 text-white" />
                <p className="text-sm text-white">{alert.location_description}</p>
              </div>
            )}

            <div className="bg-white/20 backdrop-blur-sm rounded-xl p-4 text-center">
              <Phone className="h-8 w-8 text-white mx-auto mb-2" />
              <p className="text-lg font-bold text-white mb-1">¡CONTACTA A LAS AUTORIDADES!</p>
              <p className="text-sm text-white/90">Policía: 123 | Bomberos: 119</p>
            </div>

            <div className="flex gap-3">
              <Button 
                onClick={onReport}
                className="flex-1 bg-white text-red-600 hover:bg-white/90 font-bold py-3"
              >
                <Phone className="h-5 w-5 mr-2" />
                REPORTAR
              </Button>
              <Button 
                onClick={() => onResolve(alert.id)}
                className="flex-1 bg-white text-red-600 hover:bg-white/90 font-bold py-3"
              >
                <X className="h-5 w-5 mr-2" />
                CANCELAR
              </Button>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default PanicAlertOverlay;
