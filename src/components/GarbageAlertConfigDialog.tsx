import React, { useState } from 'react';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Switch } from '@/components/ui/switch';
import { Checkbox } from '@/components/ui/checkbox';
import { Plus, Edit } from 'lucide-react';
import { GarbageAlertConfig } from '@/hooks/useGarbageAlertConfigs';

interface GarbageAlertConfigDialogProps {
  config?: GarbageAlertConfig;
  onSave: (config: Omit<GarbageAlertConfig, 'id' | 'created_at' | 'updated_at' | 'created_by'>) => Promise<any>;
  children?: React.ReactNode;
}

const DAYS_OF_WEEK = [
  { value: 1, label: 'Lunes' },
  { value: 2, label: 'Martes' },
  { value: 3, label: 'Miércoles' },
  { value: 4, label: 'Jueves' },
  { value: 5, label: 'Viernes' },
  { value: 6, label: 'Sábado' },
  { value: 0, label: 'Domingo' }
];

export const GarbageAlertConfigDialog: React.FC<GarbageAlertConfigDialogProps> = ({
  config,
  onSave,
  children
}) => {
  const [open, setOpen] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [formData, setFormData] = useState({
    sector: config?.sector || '',
    municipality: config?.municipality || 'Medellín',
    province: config?.province || 'Antioquia',
    days_of_week: config?.days_of_week || [1, 3, 5],
    frequency_hours: config?.frequency_hours || 3,
    start_hour: config?.start_hour || 6,
    end_hour: config?.end_hour || 18,
    is_active: config?.is_active ?? true
  });

  const handleSave = async () => {
    if (!formData.sector.trim()) return;
    
    setIsLoading(true);
    try {
      await onSave(formData);
      setOpen(false);
      if (!config) {
        // Reset form for new configs
        setFormData({
          sector: '',
          municipality: 'Medellín',
          province: 'Antioquia',
          days_of_week: [1, 3, 5],
          frequency_hours: 3,
          start_hour: 6,
          end_hour: 18,
          is_active: true
        });
      }
    } catch (error) {
      console.error('Error saving config:', error);
    } finally {
      setIsLoading(false);
    }
  };

  const handleDayToggle = (day: number) => {
    setFormData(prev => ({
      ...prev,
      days_of_week: prev.days_of_week.includes(day)
        ? prev.days_of_week.filter(d => d !== day)
        : [...prev.days_of_week, day].sort()
    }));
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        {children || (
          <Button>
            {config ? <Edit className="h-4 w-4 mr-2" /> : <Plus className="h-4 w-4 mr-2" />}
            {config ? 'Editar' : 'Nueva Configuración'}
          </Button>
        )}
      </DialogTrigger>
      <DialogContent className="max-w-md">
        <DialogHeader>
          <DialogTitle>
            {config ? 'Editar Configuración' : 'Nueva Configuración de Alerta'}
          </DialogTitle>
        </DialogHeader>
        
        <div className="space-y-4">
          <div>
            <Label htmlFor="sector">Sector</Label>
            <Input
              id="sector"
              value={formData.sector}
              onChange={(e) => setFormData(prev => ({ ...prev, sector: e.target.value }))}
              placeholder="Ej: Centro, La Candelaria, General"
            />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <Label htmlFor="municipality">Municipio</Label>
              <Input
                id="municipality"
                value={formData.municipality}
                onChange={(e) => setFormData(prev => ({ ...prev, municipality: e.target.value }))}
              />
            </div>
            <div>
              <Label htmlFor="province">Provincia</Label>
              <Input
                id="province"
                value={formData.province}
                onChange={(e) => setFormData(prev => ({ ...prev, province: e.target.value }))}
              />
            </div>
          </div>

          <div>
            <Label>Días de Recolección</Label>
            <div className="grid grid-cols-2 gap-2 mt-2">
              {DAYS_OF_WEEK.map(day => (
                <div key={day.value} className="flex items-center space-x-2">
                  <Checkbox
                    id={`day-${day.value}`}
                    checked={formData.days_of_week.includes(day.value)}
                    onCheckedChange={() => handleDayToggle(day.value)}
                  />
                  <Label htmlFor={`day-${day.value}`} className="text-sm">
                    {day.label}
                  </Label>
                </div>
              ))}
            </div>
          </div>

          <div className="grid grid-cols-3 gap-4">
            <div>
              <Label htmlFor="frequency">Frecuencia (horas)</Label>
              <Input
                id="frequency"
                type="number"
                min="1"
                max="24"
                value={formData.frequency_hours}
                onChange={(e) => setFormData(prev => ({ ...prev, frequency_hours: parseInt(e.target.value) || 3 }))}
              />
            </div>
            <div>
              <Label htmlFor="start">Hora Inicio</Label>
              <Input
                id="start"
                type="number"
                min="0"
                max="23"
                value={formData.start_hour}
                onChange={(e) => setFormData(prev => ({ ...prev, start_hour: parseInt(e.target.value) || 6 }))}
              />
            </div>
            <div>
              <Label htmlFor="end">Hora Fin</Label>
              <Input
                id="end"
                type="number"
                min="0"
                max="23"
                value={formData.end_hour}
                onChange={(e) => setFormData(prev => ({ ...prev, end_hour: parseInt(e.target.value) || 18 }))}
              />
            </div>
          </div>

          <div className="flex items-center space-x-2">
            <Switch
              id="active"
              checked={formData.is_active}
              onCheckedChange={(checked) => setFormData(prev => ({ ...prev, is_active: checked }))}
            />
            <Label htmlFor="active">Configuración Activa</Label>
          </div>

          <div className="flex gap-2 pt-4">
            <Button
              onClick={handleSave}
              disabled={isLoading || !formData.sector.trim()}
              className="flex-1"
            >
              {isLoading ? 'Guardando...' : 'Guardar'}
            </Button>
            <Button
              variant="outline"
              onClick={() => setOpen(false)}
              className="flex-1"
            >
              Cancelar
            </Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
};