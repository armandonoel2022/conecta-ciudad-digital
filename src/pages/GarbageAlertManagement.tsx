import React from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Switch } from '@/components/ui/switch';
import { AlertCircle, Trash2, Edit, MapPin, Clock, Calendar } from 'lucide-react';
import { useGarbageAlertConfigs } from '@/hooks/useGarbageAlertConfigs';
import { GarbageAlertConfigDialog } from '@/components/GarbageAlertConfigDialog';
import { Alert, AlertDescription } from '@/components/ui/alert';

const DAYS_MAP = {
  0: 'Dom',
  1: 'Lun',
  2: 'Mar',
  3: 'Mié',
  4: 'Jue',
  5: 'Vie',
  6: 'Sáb'
};

export default function GarbageAlertManagement() {
  const { configs, isLoading, createConfig, updateConfig, deleteConfig } = useGarbageAlertConfigs();

  const handleToggleActive = async (configId: string, isActive: boolean) => {
    await updateConfig(configId, { is_active: isActive });
  };

  const handleDelete = async (configId: string) => {
    if (confirm('¿Estás seguro de que quieres eliminar esta configuración?')) {
      await deleteConfig(configId);
    }
  };

  if (isLoading) {
    return (
      <div className="container mx-auto p-6">
        <div className="animate-pulse space-y-4">
          <div className="h-8 bg-muted rounded w-1/3"></div>
          <div className="h-32 bg-muted rounded"></div>
          <div className="h-32 bg-muted rounded"></div>
        </div>
      </div>
    );
  }

  return (
    <div className="container mx-auto p-6 max-w-6xl">
      <div className="mb-6">
        <h1 className="text-3xl font-bold mb-2">Gestión de Alertas de Basura</h1>
        <p className="text-muted-foreground">
          Configura cuándo y dónde se envían las alertas de recolección de basura
        </p>
      </div>

      <Alert className="mb-6">
        <AlertCircle className="h-4 w-4" />
        <AlertDescription>
          Las alertas se envían automáticamente según la configuración de cada sector. 
          La configuración "General" se aplica cuando no existe una configuración específica para el sector del usuario.
        </AlertDescription>
      </Alert>

      <div className="flex justify-between items-center mb-6">
        <h2 className="text-xl font-semibold">Configuraciones Activas</h2>
        <GarbageAlertConfigDialog onSave={createConfig} />
      </div>

      {configs.length === 0 ? (
        <Card>
          <CardContent className="text-center py-12">
            <MapPin className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
            <h3 className="text-lg font-medium mb-2">No hay configuraciones</h3>
            <p className="text-muted-foreground mb-4">
              Crea tu primera configuración de alertas de basura
            </p>
            <GarbageAlertConfigDialog onSave={createConfig} />
          </CardContent>
        </Card>
      ) : (
        <div className="grid gap-4">
          {configs.map((config) => (
            <Card key={config.id} className={`transition-opacity ${!config.is_active ? 'opacity-60' : ''}`}>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <MapPin className="h-5 w-5 text-primary" />
                    <div>
                      <CardTitle className="text-lg">{config.sector}</CardTitle>
                      <CardDescription>
                        {config.municipality}, {config.province}
                      </CardDescription>
                    </div>
                  </div>
                  <div className="flex items-center gap-2">
                    <Switch
                      checked={config.is_active}
                      onCheckedChange={(checked) => handleToggleActive(config.id, checked)}
                    />
                    <Badge variant={config.is_active ? "default" : "secondary"}>
                      {config.is_active ? 'Activa' : 'Inactiva'}
                    </Badge>
                  </div>
                </div>
              </CardHeader>
              <CardContent>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                  <div className="flex items-center gap-2">
                    <Calendar className="h-4 w-4 text-muted-foreground" />
                    <div>
                      <p className="text-sm font-medium">Días de Recolección</p>
                      <div className="flex gap-1 mt-1">
                        {config.days_of_week.map(day => (
                          <Badge key={day} variant="outline" className="text-xs">
                            {DAYS_MAP[day as keyof typeof DAYS_MAP]}
                          </Badge>
                        ))}
                      </div>
                    </div>
                  </div>
                  
                  <div className="flex items-center gap-2">
                    <Clock className="h-4 w-4 text-muted-foreground" />
                    <div>
                      <p className="text-sm font-medium">Horario</p>
                      <p className="text-sm text-muted-foreground">
                        {config.start_hour}:00 - {config.end_hour}:00
                      </p>
                    </div>
                  </div>
                  
                  <div className="flex items-center gap-2">
                    <AlertCircle className="h-4 w-4 text-muted-foreground" />
                    <div>
                      <p className="text-sm font-medium">Frecuencia</p>
                      <p className="text-sm text-muted-foreground">
                        Cada {config.frequency_hours} hora{config.frequency_hours !== 1 ? 's' : ''}
                      </p>
                    </div>
                  </div>
                </div>
                
                <div className="flex gap-2 mt-4 pt-4 border-t">
                  <GarbageAlertConfigDialog
                    config={config}
                    onSave={(updates) => updateConfig(config.id, updates)}
                  >
                    <Button variant="outline" size="sm">
                      <Edit className="h-4 w-4 mr-2" />
                      Editar
                    </Button>
                  </GarbageAlertConfigDialog>
                  
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={() => handleDelete(config.id)}
                    className="text-destructive hover:text-destructive"
                  >
                    <Trash2 className="h-4 w-4 mr-2" />
                    Eliminar
                  </Button>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      )}
    </div>
  );
}