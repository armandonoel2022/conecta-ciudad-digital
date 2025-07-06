
import React from 'react';
import { Button } from '@/components/ui/button';
import { Truck, TestTube, AlertTriangle, Zap } from 'lucide-react';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';

interface TestMenuProps {
  onTriggerGarbageAlert: () => void;
  onTriggerAmberAlert: () => void;
  onTriggerPanicAlert: () => void;
}

const TestMenu: React.FC<TestMenuProps> = ({ onTriggerGarbageAlert, onTriggerAmberAlert, onTriggerPanicAlert }) => {
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
          <DropdownMenuItem onClick={onTriggerPanicAlert}>
            <Zap className="mr-2 h-4 w-4" />
            <span>Probar Alerta de Pánico</span>
          </DropdownMenuItem>
        </DropdownMenuContent>
      </DropdownMenu>
    </div>
  );
};

export default TestMenu;
