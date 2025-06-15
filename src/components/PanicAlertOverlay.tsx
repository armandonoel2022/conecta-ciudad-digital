
import React from 'react';
import { AlertTriangle, MapPin, Clock, X } from 'lucide-react';
import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert';
import { Button } from '@/components/ui/button';
import { PanicAlert } from '@/hooks/usePanicAlerts';
import { format } from 'date-fns';
import { es } from 'date-fns/locale';

interface PanicAlertOverlayProps {
  alert: PanicAlert;
  onDismiss?: () => void;
}

const PanicAlertOverlay: React.FC<PanicAlertOverlayProps> = ({ alert, onDismiss }) => {
  const timeLeft = new Date(alert.expires_at).getTime() - new Date().getTime();
  const isExpired = timeLeft <= 0;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-sm p-4">
      <div className="bg-white rounded-2xl shadow-2xl max-w-md w-full animate-in zoom-in-95 duration-300">
        <div className="p-6">
          {/* Header */}
          <div className="flex items-center justify-between mb-4">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-red-100 rounded-full">
                <AlertTriangle className="h-6 w-6 text-red-600 animate-pulse" />
              </div>
              <div>
                <h2 className="text-xl font-bold text-red-600">ALERTA DE PÁNICO</h2>
                <p className="text-sm text-gray-600">
                  {isExpired ? 'Alerta expirada' : 'Alerta activa'}
                </p>
              </div>
            </div>
            {onDismiss && (
              <Button
                variant="ghost"
                size="icon"
                onClick={onDismiss}
                className="text-gray-400 hover:text-gray-600"
              >
                <X className="h-5 w-5" />
              </Button>
            )}
          </div>

          {/* Alert Content */}
          <Alert variant="destructive" className="mb-4">
            <AlertTriangle className="h-4 w-4" />
            <AlertTitle className="text-lg">
              {alert.user_full_name} necesita ayuda
            </AlertTitle>
            <AlertDescription className="mt-2 space-y-2">
              <div className="flex items-center gap-2 text-sm">
                <Clock className="h-4 w-4" />
                <span>
                  Activada: {format(new Date(alert.created_at), 'HH:mm:ss - dd/MM/yyyy', { locale: es })}
                </span>
              </div>
              
              {alert.address && (
                <div className="flex items-start gap-2 text-sm">
                  <MapPin className="h-4 w-4 mt-0.5 flex-shrink-0" />
                  <span>{alert.address}</span>
                </div>
              )}

              {alert.latitude && alert.longitude && (
                <div className="flex items-center gap-2 text-sm">
                  <MapPin className="h-4 w-4" />
                  <span className="font-mono">
                    {alert.latitude.toFixed(6)}, {alert.longitude.toFixed(6)}
                  </span>
                </div>
              )}

              {!isExpired && (
                <div className="mt-3 p-3 bg-red-50 rounded-lg">
                  <p className="text-sm font-medium text-red-800">
                    ⚠️ Si conoces la ubicación de esta persona o tienes información relevante, 
                    contacta inmediatamente a las autoridades locales o al número de emergencias.
                  </p>
                </div>
              )}
            </AlertDescription>
          </Alert>

          {/* Action Buttons */}
          <div className="flex gap-3">
            <Button
              onClick={() => {
                if (alert.latitude && alert.longitude) {
                  window.open(`https://maps.google.com/?q=${alert.latitude},${alert.longitude}`, '_blank');
                }
              }}
              className="flex-1"
              disabled={!alert.latitude || !alert.longitude}
            >
              <MapPin className="h-4 w-4 mr-2" />
              Ver en Mapa
            </Button>
            
            <Button
              variant="outline"
              onClick={() => {
                window.open('tel:123', '_self'); // Emergency number
              }}
              className="flex-1"
            >
              Llamar 123
            </Button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default PanicAlertOverlay;
