
import React from 'react';
import { X, Truck } from 'lucide-react';
import { Button } from '@/components/ui/button';

interface GarbageAlertProps {
  isVisible: boolean;
  onDismiss: () => void;
}

const GarbageAlert: React.FC<GarbageAlertProps> = ({ isVisible, onDismiss }) => {
  if (!isVisible) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm animate-fade-in">
      <div className="bg-white rounded-2xl p-6 shadow-2xl max-w-sm w-full mx-auto relative overflow-hidden">
        {/* Close button */}
        <Button
          variant="ghost"
          size="icon"
          onClick={onDismiss}
          className="absolute top-2 right-2 h-8 w-8 rounded-full hover:bg-gray-100"
        >
          <X className="h-4 w-4" />
        </Button>

        {/* Header */}
        <div className="text-center mb-6">
          <div className="inline-flex items-center justify-center w-16 h-16 bg-green-100 rounded-full mb-4">
            <Truck className="h-8 w-8 text-green-600" />
          </div>
          <h2 className="text-xl font-bold text-gray-800 mb-2">
            ¡Recordatorio de Basura!
          </h2>
          <p className="text-gray-600 text-sm">
            Hoy pasa el camión recolector por tu calle
          </p>
        </div>

        {/* Street Animation */}
        <div className="relative bg-gradient-to-b from-blue-100 to-green-100 rounded-xl p-4 mb-6 overflow-hidden">
          {/* Sky background */}
          <div className="absolute inset-0 bg-gradient-to-b from-blue-200 via-blue-100 to-green-100"></div>
          
          {/* Buildings */}
          <div className="relative flex justify-between items-end mb-2 z-10">
            <div className="w-8 h-12 bg-gray-400 rounded-t-sm"></div>
            <div className="w-6 h-8 bg-gray-500 rounded-t-sm"></div>
            <div className="w-10 h-10 bg-gray-400 rounded-t-sm"></div>
            <div className="w-7 h-14 bg-gray-500 rounded-t-sm"></div>
          </div>

          {/* Street */}
          <div className="relative bg-gray-600 h-8 rounded-sm overflow-hidden">
            {/* Street lines */}
            <div className="absolute top-1/2 left-0 right-0 h-0.5 bg-yellow-400 transform -translate-y-0.5"></div>
            
            {/* Animated truck */}
            <div className="absolute top-1 left-0 animate-truck-drive">
              <div className="flex items-center">
                {/* Truck body */}
                <div className="bg-green-600 w-8 h-4 rounded-sm relative">
                  {/* Truck cab */}
                  <div className="absolute -left-2 top-0 w-3 h-4 bg-green-700 rounded-l-sm"></div>
                  {/* Wheels */}
                  <div className="absolute -bottom-1 left-1 w-2 h-2 bg-black rounded-full"></div>
                  <div className="absolute -bottom-1 right-1 w-2 h-2 bg-black rounded-full"></div>
                </div>
              </div>
            </div>
          </div>

          {/* Grass */}
          <div className="h-2 bg-green-300 rounded-b-xl"></div>
        </div>

        {/* Action buttons */}
        <div className="space-y-3">
          <Button
            onClick={onDismiss}
            className="w-full bg-green-600 hover:bg-green-700 text-white font-semibold py-3 rounded-xl"
          >
            ¡Entendido!
          </Button>
          <p className="text-xs text-gray-500 text-center">
            Te recordaremos nuevamente en 3 horas
          </p>
        </div>
      </div>
    </div>
  );
};

export default GarbageAlert;
