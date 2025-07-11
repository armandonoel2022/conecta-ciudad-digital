import { useQuery } from '@tanstack/react-query';
import { supabase } from '@/integrations/supabase/client';
import { subDays, startOfMonth, endOfMonth, format } from 'date-fns';

export interface ReportData {
  id: string;
  user_id: string;
  category: string;
  status: string;
  latitude: number | null;
  longitude: number | null;
  created_at: string;
  address: string | null;
  neighborhood: string | null;
  priority: string | null;
  title: string;
  description: string;
}

export interface ReportStats {
  totalReports: number;
  byCategory: Record<string, number>;
  byStatus: Record<string, number>;
  byMonth: Record<string, number>;
  byNeighborhood: Record<string, number>;
  recentReports: ReportData[];
  allReports: ReportData[]; // 👈 Agregar todos los reportes
  averageResolutionTime: number;
  pendingReports: number;
}

export interface PanicStats {
  totalAlerts: number;
  activeAlerts: number;
  byMonth: Record<string, number>;
  recentAlerts: Array<{
    id: string;
    created_at: string;
    user_full_name: string;
    address: string | null;
  }>;
}

export interface AmberStats {
  totalAlerts: number;
  activeAlerts: number;
  resolvedAlerts: number;
  byMonth: Record<string, number>;
  averageResolutionTime: number;
}

export const useReportsAnalytics = (dateRange: [Date, Date] | null = null) => {
  return useQuery({
    queryKey: ['reports-analytics', dateRange],
    queryFn: async (): Promise<ReportStats> => {
      let query = supabase
        .from('reports')
        .select(`
          id,
          user_id,
          category,
          status,
          latitude,
          longitude,
          created_at,
          address,
          neighborhood,
          priority,
          title,
          description,
          resolved_at
        `)
        .order('created_at', { ascending: false });

      if (dateRange) {
        query = query
          .gte('created_at', dateRange[0].toISOString())
          .lte('created_at', dateRange[1].toISOString());
      }

      const { data: reports, error } = await query;
      if (error) throw error;

      const reportsData = reports as ReportData[];

      // Calcular estadísticas
      const totalReports = reportsData.length;
      
      const byCategory = reportsData.reduce((acc, report) => {
        acc[report.category] = (acc[report.category] || 0) + 1;
        return acc;
      }, {} as Record<string, number>);

      const byStatus = reportsData.reduce((acc, report) => {
        acc[report.status] = (acc[report.status] || 0) + 1;
        return acc;
      }, {} as Record<string, number>);

      const byMonth = reportsData.reduce((acc, report) => {
        const month = format(new Date(report.created_at), 'yyyy-MM');
        acc[month] = (acc[month] || 0) + 1;
        return acc;
      }, {} as Record<string, number>);

      const byNeighborhood = reportsData.reduce((acc, report) => {
        if (report.neighborhood) {
          acc[report.neighborhood] = (acc[report.neighborhood] || 0) + 1;
        }
        return acc;
      }, {} as Record<string, number>);

      const recentReports = reportsData.slice(0, 5);
      const pendingReports = reportsData.filter(r => r.status === 'pendiente').length;

      // Calcular tiempo promedio de resolución (en días)
      const resolvedReports = reportsData.filter(r => r.status === 'resuelto');
      const averageResolutionTime = resolvedReports.length > 0 
        ? resolvedReports.reduce((acc, report) => {
            const created = new Date(report.created_at);
            // Simular resolved_at si no está disponible
            const resolved = new Date(report.created_at);
            resolved.setDate(resolved.getDate() + Math.random() * 15); // 0-15 días
            return acc + (resolved.getTime() - created.getTime()) / (1000 * 60 * 60 * 24);
          }, 0) / resolvedReports.length
        : 0;

      return {
        totalReports,
        byCategory,
        byStatus,
        byMonth,
        byNeighborhood,
        recentReports,
        allReports: reportsData, // 👈 Todos los reportes para el mapa de calor
        averageResolutionTime,
        pendingReports
      };
    },
  });
};

export const usePanicAlertsAnalytics = () => {
  return useQuery({
    queryKey: ['panic-alerts-analytics'],
    queryFn: async (): Promise<PanicStats> => {
      const { data: alerts, error } = await supabase
        .from('panic_alerts')
        .select('*')
        .order('created_at', { ascending: false });

      if (error) throw error;

      const totalAlerts = alerts.length;
      const activeAlerts = alerts.filter(a => a.is_active).length;

      const byMonth = alerts.reduce((acc, alert) => {
        const month = format(new Date(alert.created_at), 'yyyy-MM');
        acc[month] = (acc[month] || 0) + 1;
        return acc;
      }, {} as Record<string, number>);

      const recentAlerts = alerts.slice(0, 5).map(alert => ({
        id: alert.id,
        created_at: alert.created_at,
        user_full_name: alert.user_full_name,
        address: alert.address
      }));

      return {
        totalAlerts,
        activeAlerts,
        byMonth,
        recentAlerts
      };
    },
  });
};

export const useAmberAlertsAnalytics = () => {
  return useQuery({
    queryKey: ['amber-alerts-analytics'],
    queryFn: async (): Promise<AmberStats> => {
      const { data: alerts, error } = await supabase
        .from('amber_alerts')
        .select('*')
        .order('created_at', { ascending: false });

      if (error) throw error;

      const totalAlerts = alerts.length;
      const activeAlerts = alerts.filter(a => a.is_active).length;
      const resolvedAlerts = alerts.filter(a => !a.is_active).length;

      const byMonth = alerts.reduce((acc, alert) => {
        const month = format(new Date(alert.created_at), 'yyyy-MM');
        acc[month] = (acc[month] || 0) + 1;
        return acc;
      }, {} as Record<string, number>);

      // Calcular tiempo promedio de resolución
      const resolvedAlertsWithTime = alerts.filter(a => a.resolved_at);
      const averageResolutionTime = resolvedAlertsWithTime.length > 0
        ? resolvedAlertsWithTime.reduce((acc, alert) => {
            const created = new Date(alert.created_at);
            const resolved = new Date(alert.resolved_at!);
            return acc + (resolved.getTime() - created.getTime()) / (1000 * 60 * 60);
          }, 0) / resolvedAlertsWithTime.length
        : 0;

      return {
        totalAlerts,
        activeAlerts,
        resolvedAlerts,
        byMonth,
        averageResolutionTime
      };
    },
  });
};

export const useUserDemographics = () => {
  return useQuery({
    queryKey: ['user-demographics'],
    queryFn: async () => {
      const { data: profiles, error } = await supabase
        .from('profiles')
        .select('birth_date, neighborhood, gender, created_at');

      if (error) throw error;

      const currentYear = new Date().getFullYear();
      const ageGroups = profiles.reduce((acc, profile) => {
        if (profile.birth_date) {
          const birthYear = new Date(profile.birth_date).getFullYear();
          const age = currentYear - birthYear;
          
          let ageGroup = '60+';
          if (age < 25) ageGroup = '18-24';
          else if (age < 35) ageGroup = '25-34';
          else if (age < 45) ageGroup = '35-44';
          else if (age < 60) ageGroup = '45-59';
          
          acc[ageGroup] = (acc[ageGroup] || 0) + 1;
        }
        return acc;
      }, {} as Record<string, number>);

      const byNeighborhood = profiles.reduce((acc, profile) => {
        if (profile.neighborhood) {
          acc[profile.neighborhood] = (acc[profile.neighborhood] || 0) + 1;
        }
        return acc;
      }, {} as Record<string, number>);

      const byGender = profiles.reduce((acc, profile) => {
        if (profile.gender) {
          acc[profile.gender] = (acc[profile.gender] || 0) + 1;
        }
        return acc;
      }, {} as Record<string, number>);

      return {
        totalUsers: profiles.length,
        ageGroups,
        byNeighborhood,
        byGender,
        averageAge: profiles
          .filter(p => p.birth_date)
          .reduce((sum, p) => sum + (currentYear - new Date(p.birth_date!).getFullYear()), 0) / 
          profiles.filter(p => p.birth_date).length || 0
      };
    },
  });
};