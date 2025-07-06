
import React from 'react';
import { Button } from '@/components/ui/button';
import { Truck, TestTube, AlertTriangle, Volume2 } from 'lucide-react';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import { useAlertSound } from '@/hooks/useAlertSound';

interface TestMenuProps {
  onTriggerGarbageAlert: () => void;
  onTriggerAmberAlert: () => void;
}

const TestMenu: React.FC<TestMenuProps> = ({ onTriggerGarbageAlert, onTriggerAmberAlert }) => {
  const { playAlertSound, isAudioReady } = useAlertSound();

  const handleTestAmberSound = () => {
    console.log('Testing Amber alert sound...');
    playAlertSound('amber');
  };

  const handleTestPanicSound = () => {
    console.log('Testing Panic alert sound...');
    playAlertSound('panic');
  };

  return (
    <div className="fixed top-4 right-4 z-50">
      <DropdownMenu>
        <DropdownMenuTrigger asChild>
          <Button variant="outline" size="icon" className="h-10 w-10">
            <TestTube className="h-4 w-4" />
          </Button>
        </DropdownMenuTrigger>
        <DropdownMenuContent align="end" className="w-56">
          <DropdownMenuLabel>Menú de Pruebas</DropdownMenuLabel>
          <DropdownMenuSeparator />
          <DropdownMenuItem onClick={onTriggerGarbageAlert}>
            <Truck className="mr-2 h-4 w-4" />
            <span>Probar Alerta de Basura</span>
          </DropdownMenuItem>
          <DropdownMenuItem onClick={onTriggerAmberAlert}>
            <AlertTriangle className="mr-2 h-4 w-4" />
            <span>Probar Alerta Amber</span>
          </DropdownMenuItem>
          <DropdownMenuSeparator />
          <DropdownMenuItem onClick={handleTestAmberSound} disabled={!isAudioReady}>
            <Volume2 className="mr-2 h-4 w-4" />
            <span>Probar Sonido Amber</span>
          </DropdownMenuItem>
          <DropdownMenuItem onClick={handleTestPanicSound} disabled={!isAudioReady}>
            <Volume2 className="mr-2 h-4 w-4" />
            <span>Probar Sonido Pánico</span>
          </DropdownMenuItem>
        </DropdownMenuContent>
      </DropdownMenu>
    </div>
  );
};

export default TestMenu;
