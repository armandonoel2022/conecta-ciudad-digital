
import React, { useState } from 'react';
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Calendar } from '@/components/ui/calendar';
import { Popover, PopoverContent, PopoverTrigger } from '@/components/ui/popover';
import { CalendarIcon, Loader2 } from 'lucide-react';
import { format } from 'date-fns';
import { es } from 'date-fns/locale';
import { cn } from '@/lib/utils';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from '@/hooks/useAuth';
import { toast } from 'sonner';

interface CreateReportDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  onReportCreated: () => void;
}

const CreateReportDialog = ({ open, onOpenChange, onReportCreated }: CreateReportDialogProps) => {
  const { user } = useAuth();
  const [isLoading, setIsLoading] = useState(false);
  const [formData, setFormData] = useState({
    title: '',
    description: '',
    reportType: '',
    dateRangeStart: undefined as Date | undefined,
    dateRangeEnd: undefined as Date | undefined,
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!user) {
      toast.error('Debes estar autenticado para crear reportes');
      return;
    }

    if (!formData.title || !formData.reportType) {
      toast.error('Por favor completa todos los campos requeridos');
      return;
    }

    setIsLoading(true);

    try {
      const { error } = await supabase
        .from('generated_reports')
        .insert({
          title: formData.title,
          description: formData.description,
          report_type: formData.reportType,
          generated_by: user.id,
          date_range_start: formData.dateRangeStart?.toISOString().split('T')[0],
          date_range_end: formData.dateRangeEnd?.toISOString().split('T')[0],
          status: 'generating'
        });

      if (error) throw error;

      toast.success('Reporte creado exitosamente');
      
      // Reset form
      setFormData({
        title: '',
        description: '',
        reportType: '',
        dateRangeStart: undefined,
        dateRangeEnd: undefined,
      });
      
      onReportCreated();
      onOpenChange(false);
    } catch (error) {
      console.error('Error creating report:', error);
      toast.error('Error al crear el reporte');
    } finally {
      setIsLoading(false);
    }
  };

  const reportTypes = [
    { value: 'monthly', label: 'Reporte Mensual' },
    { value: 'weekly', label: 'Reporte Semanal' },
    { value: 'custom', label: 'Reporte Personalizado' },
    { value: 'incident_summary', label: 'Resumen de Incidencias' }
  ];

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[525px]">
        <DialogHeader>
          <DialogTitle>Crear Nuevo Reporte</DialogTitle>
          <DialogDescription>
            Completa la información para generar un nuevo reporte del sistema.
          </DialogDescription>
        </DialogHeader>
        
        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="title">Título del Reporte *</Label>
            <Input
              id="title"
              value={formData.title}
              onChange={(e) => setFormData(prev => ({ ...prev, title: e.target.value }))}
              placeholder="Ej: Reporte Mensual de Incidencias - Febrero 2025"
              required
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="description">Descripción</Label>
            <Textarea
              id="description"
              value={formData.description}
              onChange={(e) => setFormData(prev => ({ ...prev, description: e.target.value }))}
              placeholder="Describe brevemente el contenido del reporte..."
              rows={3}
            />
          </div>

          <div className="space-y-2">
            <Label>Tipo de Reporte *</Label>
            <Select 
              value={formData.reportType} 
              onValueChange={(value) => setFormData(prev => ({ ...prev, reportType: value }))}
              required
            >
              <SelectTrigger>
                <SelectValue placeholder="Selecciona el tipo de reporte" />
              </SelectTrigger>
              <SelectContent>
                {reportTypes.map((type) => (
                  <SelectItem key={type.value} value={type.value}>
                    {type.label}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label>Fecha de Inicio</Label>
              <Popover>
                <PopoverTrigger asChild>
                  <Button
                    variant="outline"
                    className={cn(
                      "w-full justify-start text-left font-normal",
                      !formData.dateRangeStart && "text-muted-foreground"
                    )}
                  >
                    <CalendarIcon className="mr-2 h-4 w-4" />
                    {formData.dateRangeStart ? (
                      format(formData.dateRangeStart, "dd/MM/yyyy", { locale: es })
                    ) : (
                      <span>Seleccionar fecha</span>
                    )}
                  </Button>
                </PopoverTrigger>
                <PopoverContent className="w-auto p-0">
                  <Calendar
                    mode="single"
                    selected={formData.dateRangeStart}
                    onSelect={(date) => setFormData(prev => ({ ...prev, dateRangeStart: date }))}
                    initialFocus
                  />
                </PopoverContent>
              </Popover>
            </div>

            <div className="space-y-2">
              <Label>Fecha de Fin</Label>
              <Popover>
                <PopoverTrigger asChild>
                  <Button
                    variant="outline"
                    className={cn(
                      "w-full justify-start text-left font-normal",
                      !formData.dateRangeEnd && "text-muted-foreground"
                    )}
                  >
                    <CalendarIcon className="mr-2 h-4 w-4" />
                    {formData.dateRangeEnd ? (
                      format(formData.dateRangeEnd, "dd/MM/yyyy", { locale: es })
                    ) : (
                      <span>Seleccionar fecha</span>
                    )}
                  </Button>
                </PopoverTrigger>
                <PopoverContent className="w-auto p-0">
                  <Calendar
                    mode="single"
                    selected={formData.dateRangeEnd}
                    onSelect={(date) => setFormData(prev => ({ ...prev, dateRangeEnd: date }))}
                    initialFocus
                  />
                </PopoverContent>
              </Popover>
            </div>
          </div>

          <DialogFooter>
            <Button type="button" variant="outline" onClick={() => onOpenChange(false)}>
              Cancelar
            </Button>
            <Button type="submit" disabled={isLoading}>
              {isLoading && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
              Crear Reporte
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
};

export default CreateReportDialog;
