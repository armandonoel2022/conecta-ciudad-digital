import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';

export interface GarbageAlertConfig {
  id: string;
  sector: string;
  municipality: string;
  province: string;
  days_of_week: number[];
  frequency_hours: number;
  start_hour: number;
  end_hour: number;
  is_active: boolean;
  created_at: string;
  updated_at: string;
  created_by: string | null;
}

export const useGarbageAlertConfigs = () => {
  const [configs, setConfigs] = useState<GarbageAlertConfig[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const { toast } = useToast();

  const fetchConfigs = async () => {
    try {
      const { data, error } = await supabase
        .from('garbage_alert_configs')
        .select('*')
        .order('created_at', { ascending: false });

      if (error) throw error;
      setConfigs(data || []);
    } catch (error) {
      console.error('Error fetching garbage alert configs:', error);
      toast({
        title: "Error",
        description: "No se pudieron cargar las configuraciones de alertas",
        variant: "destructive"
      });
    } finally {
      setIsLoading(false);
    }
  };

  const createConfig = async (config: Omit<GarbageAlertConfig, 'id' | 'created_at' | 'updated_at' | 'created_by'>) => {
    try {
      const { data, error } = await supabase
        .from('garbage_alert_configs')
        .insert({
          ...config,
          created_by: (await supabase.auth.getUser()).data.user?.id
        })
        .select()
        .single();

      if (error) throw error;
      
      setConfigs(prev => [data, ...prev]);
      toast({
        title: "Éxito",
        description: "Configuración de alerta creada correctamente"
      });
      
      return data;
    } catch (error) {
      console.error('Error creating garbage alert config:', error);
      toast({
        title: "Error",
        description: "No se pudo crear la configuración de alerta",
        variant: "destructive"
      });
      throw error;
    }
  };

  const updateConfig = async (id: string, updates: Partial<GarbageAlertConfig>) => {
    try {
      const { data, error } = await supabase
        .from('garbage_alert_configs')
        .update(updates)
        .eq('id', id)
        .select()
        .single();

      if (error) throw error;
      
      setConfigs(prev => prev.map(config => 
        config.id === id ? data : config
      ));
      
      toast({
        title: "Éxito",
        description: "Configuración actualizada correctamente"
      });
      
      return data;
    } catch (error) {
      console.error('Error updating garbage alert config:', error);
      toast({
        title: "Error",
        description: "No se pudo actualizar la configuración",
        variant: "destructive"
      });
      throw error;
    }
  };

  const deleteConfig = async (id: string) => {
    try {
      const { error } = await supabase
        .from('garbage_alert_configs')
        .delete()
        .eq('id', id);

      if (error) throw error;
      
      setConfigs(prev => prev.filter(config => config.id !== id));
      toast({
        title: "Éxito",
        description: "Configuración eliminada correctamente"
      });
    } catch (error) {
      console.error('Error deleting garbage alert config:', error);
      toast({
        title: "Error",
        description: "No se pudo eliminar la configuración",
        variant: "destructive"
      });
      throw error;
    }
  };

  const getActiveConfigsForUserLocation = async (userSector?: string) => {
    try {
      let query = supabase
        .from('garbage_alert_configs')
        .select('*')
        .eq('is_active', true);

      // Si se proporciona un sector específico, buscar por sector, sino usar General
      if (userSector) {
        query = query.or(`sector.eq.${userSector},sector.eq.General`);
      } else {
        query = query.eq('sector', 'General');
      }

      const { data, error } = await query;

      if (error) throw error;
      return data || [];
    } catch (error) {
      console.error('Error fetching active configs:', error);
      return [];
    }
  };

  useEffect(() => {
    fetchConfigs();
  }, []);

  return {
    configs,
    isLoading,
    createConfig,
    updateConfig,
    deleteConfig,
    refetch: fetchConfigs,
    getActiveConfigsForUserLocation
  };
};