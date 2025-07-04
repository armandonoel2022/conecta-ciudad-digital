
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
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-background/80 backdrop-blur-sm animate-fade-in">
      <div className="bg-card rounded-2xl p-6 shadow-2xl max-w-sm w-full mx-auto relative overflow-hidden border border-border">
        {/* Close button */}
        <Button
          variant="ghost"
          size="icon"
          onClick={onDismiss}
          className="absolute top-2 right-2 h-8 w-8 rounded-full hover:bg-accent"
        >
          <X className="h-4 w-4" />
        </Button>

        {/* Header */}
        <div className="text-center mb-6">
          <div className="inline-flex items-center justify-center w-16 h-16 bg-accent rounded-full mb-4">
            <Truck className="h-8 w-8 text-accent-foreground" />
          </div>
          <h2 className="text-xl font-bold text-foreground mb-2">
            ¡Recordatorio de Basura!
          </h2>
          <p className="text-muted-foreground text-sm">
            Hoy pasa el camión recolector por tu calle
          </p>
        </div>

        {/* Street Animation */}
        <div className="relative bg-secondary/20 rounded-xl p-4 mb-6 overflow-hidden border border-border">
          {/* Sky background */}
          <div className="absolute inset-0 bg-secondary/10"></div>
          
          {/* Buildings */}
          <div className="relative flex justify-between items-end mb-2 z-10">
            <div className="w-8 h-12 bg-muted rounded-t-sm"></div>
            <div className="w-6 h-8 bg-muted-foreground/60 rounded-t-sm"></div>
            <div className="w-10 h-10 bg-muted rounded-t-sm"></div>
            <div className="w-7 h-14 bg-muted-foreground/60 rounded-t-sm"></div>
          </div>

          {/* Street */}
          <div className="relative bg-muted-foreground/80 h-8 rounded-sm overflow-hidden">
            {/* Street lines */}
            <div className="absolute top-1/2 left-0 right-0 h-0.5 bg-amber/80 transform -translate-y-0.5"></div>
            
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
          <div className="h-2 bg-accent rounded-b-xl"></div>
        </div>

        {/* Action buttons */}
        <div className="space-y-3">
          <Button
            onClick={onDismiss}
            className="w-full bg-primary hover:bg-primary/90 text-primary-foreground font-semibold py-3 rounded-xl"
          >
            ¡Entendido!
          </Button>
          <p className="text-xs text-muted-foreground text-center">
            Te recordaremos nuevamente en 3 horas
          </p>
        </div>
      </div>
    </div>
  );
};

export default GarbageAlert;
