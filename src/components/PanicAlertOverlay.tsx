
import React from 'react';
import { AlertTriangle, MapPin, Clock, User, Phone } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';

interface PanicAlert {
  id: string;
  user_id: string;
  user_full_name: string;
  latitude?: number;
  longitude?: number;
  location_description?: string;
  is_active: boolean;
  created_at: string;
  resolved_at?: string;
  resolved_by?: string;
}

interface PanicAlertOverlayProps {
  alert: PanicAlert;
  onResolve: (alertId: string) => void;
  onReport: () => void;
}

const PanicAlertOverlay: React.FC<PanicAlertOverlayProps> = ({
  alert,
  onResolve,
  onReport,
}) => {
  const formatTimeAgo = (dateString: string) => {
    const now = new Date();
    const alertTime = new Date(dateString);
    const diffInMinutes = Math.floor((now.getTime() - alertTime.getTime()) / (1000 * 60));
    
    if (diffInMinutes < 1) return 'Hace menos de 1 minuto';
    if (diffInMinutes < 60) return `Hace ${diffInMinutes} minutos`;
    
    const diffInHours = Math.floor(diffInMinutes / 60);
    if (diffInHours < 24) return `Hace ${diffInHours} horas`;
    
    const diffInDays = Math.floor(diffInHours / 24);
    return `Hace ${diffInDays} días`;
  };

  return (
    <div className="fixed inset-0 bg-red-900/90 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <Card className="w-full max-w-md bg-white border-red-500 border-2 shadow-2xl animate-pulse">
        <CardHeader className="bg-red-600 text-white">
          <CardTitle className="flex items-center space-x-2 text-xl">
            <AlertTriangle className="h-6 w-6 animate-bounce" />
            <span>¡ALERTA DE PÁNICO!</span>
          </CardTitle>
          <CardDescription className="text-red-100">
            Alguien necesita ayuda urgente en tu área
          </CardDescription>
        </CardHeader>
        
        <CardContent className="p-6 space-y-4">
          <div className="space-y-3">
            <div className="flex items-center space-x-3">
              <User className="h-5 w-5 text-gray-600" />
              <div>
                <p className="font-semibold">{alert.user_full_name}</p>
                <p className="text-sm text-gray-600">Persona en peligro</p>
              </div>
            </div>

            <div className="flex items-center space-x-3">
              <Clock className="h-5 w-5 text-gray-600" />
              <div>
                <p className="font-semibold">{formatTimeAgo(alert.created_at)}</p>
                <p className="text-sm text-gray-600">Hora de la alerta</p>
              </div>
            </div>

            {alert.location_description && (
              <div className="flex items-start space-x-3">
                <MapPin className="h-5 w-5 text-gray-600 mt-0.5" />
                <div>
                  <p className="font-semibold">Ubicación aproximada</p>
                  <p className="text-sm text-gray-600">{alert.location_description}</p>
                </div>
              </div>
            )}
          </div>

          <div className="bg-red-50 p-4 rounded-lg border border-red-200">
            <h4 className="font-semibold text-red-800 mb-2">¿Qué puedes hacer?</h4>
            <ul className="text-sm text-red-700 space-y-1">
              <li>• Si estás cerca, ofrece ayuda segura</li>
              <li>• Llama a emergencias: 123</li>
              <li>• Reporta información útil</li>
              <li>• No te pongas en peligro</li>
            </ul>
          </div>

          <div className="flex flex-col space-y-3">
            <Button
              onClick={onReport}
              className="bg-blue-600 hover:bg-blue-700 text-white"
              size="lg"
            >
              <Phone className="h-4 w-4 mr-2" />
              Llamar a Emergencias (123)
            </Button>
            
            <Button
              onClick={() => onResolve(alert.id)}
              variant="outline"
              className="border-red-300 text-red-700 hover:bg-red-50"
            >
              Marcar como Resuelta
            </Button>
          </div>

          <p className="text-xs text-gray-500 text-center">
            Esta alerta se muestra a todos los usuarios en el área para facilitar la ayuda mutua
          </p>
        </CardContent>
      </Card>
    </div>
  );
};

export default PanicAlertOverlay;
