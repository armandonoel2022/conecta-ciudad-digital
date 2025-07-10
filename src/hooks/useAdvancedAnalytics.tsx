import { useQuery } from '@tanstack/react-query';
import { supabase } from '@/integrations/supabase/client';
import { subDays, startOfMonth, endOfMonth, format, parseISO } from 'date-fns';

export interface ClusterData {
  id: string;
  center: {
    latitude: number;
    longitude: number;
  };
  reports: Array<{
    id: string;
    latitude: number;
    longitude: number;
    category: string;
    created_at: string;
    neighborhood: string;
  }>;
  density: number;
  radius: number;
  riskLevel: 'low' | 'medium' | 'high' | 'critical';
}

export interface PredictionData {
  area: string;
  predictedIssues: number;
  confidence: number;
  riskFactors: string[];
  timeline: 'next_week' | 'next_month' | 'next_quarter';
  recommendations: string[];
}

export interface CorrelationData {
  category1: string;
  category2: string;
  correlation: number;
  significance: number;
  patterns: string[];
}

export interface AnomalyData {
  reportId: string;
  anomalyType: 'location' | 'timing' | 'category' | 'frequency';
  score: number;
  description: string;
  created_at: string;
}

export interface TrendData {
  period: string;
  category: string;
  trend: 'increasing' | 'decreasing' | 'stable';
  changeRate: number;
  seasonality: number;
  forecast: number[];
}

// Helper function to safely sum numbers
const sumNumbers = (values: number[]): number => {
  return values.reduce((sum, value) => sum + value, 0);
};

// Clustering Algorithm - K-means for geographical clustering
const performKMeansClustering = (reports: any[], k: number = 5): ClusterData[] => {
  if (reports.length === 0) return [];
  
  const validReports = reports.filter(r => r.latitude && r.longitude);
  if (validReports.length < k) return [];

  // Initialize centroids randomly
  let centroids = Array.from({ length: k }, () => {
    const randomReport = validReports[Math.floor(Math.random() * validReports.length)];
    return {
      latitude: Number(randomReport.latitude),
      longitude: Number(randomReport.longitude)
    };
  });

  let clusters: ClusterData[] = [];
  let maxIterations = 100;
  let iteration = 0;

  while (iteration < maxIterations) {
    // Assign reports to nearest centroid
    const newClusters: any[] = Array.from({ length: k }, (_, i) => ({
      id: `cluster_${i}`,
      center: centroids[i],
      reports: [],
      density: 0,
      radius: 0,
      riskLevel: 'low' as const
    }));

    validReports.forEach(report => {
      let minDistance = Infinity;
      let closestCluster = 0;

      centroids.forEach((centroid, i) => {
        const distance = Math.sqrt(
          Math.pow(Number(report.latitude) - centroid.latitude, 2) +
          Math.pow(Number(report.longitude) - centroid.longitude, 2)
        );
        if (distance < minDistance) {
          minDistance = distance;
          closestCluster = i;
        }
      });

      newClusters[closestCluster].reports.push(report);
    });

    // Update centroids
    const newCentroids = newClusters.map(cluster => {
      if (cluster.reports.length === 0) return cluster.center;
      
      const latitudes = cluster.reports.map((r: any) => Number(r.latitude));
      const longitudes = cluster.reports.map((r: any) => Number(r.longitude));
      
      const avgLat = sumNumbers(latitudes) / cluster.reports.length;
      const avgLng = sumNumbers(longitudes) / cluster.reports.length;
      
      return { latitude: avgLat, longitude: avgLng };
    });

    // Check convergence
    const converged = centroids.every((centroid, i) => {
      const distance = Math.sqrt(
        Math.pow(centroid.latitude - newCentroids[i].latitude, 2) +
        Math.pow(centroid.longitude - newCentroids[i].longitude, 2)
      );
      return distance < 0.001; // Convergence threshold
    });

    centroids = newCentroids;
    clusters = newClusters.map(cluster => ({
      ...cluster,
      density: cluster.reports.length,
      radius: calculateClusterRadius(cluster.reports, cluster.center),
      riskLevel: calculateRiskLevel(cluster.reports)
    }));

    if (converged) break;
    iteration++;
  }

  return clusters.filter(c => c.reports.length > 0);
};

const calculateClusterRadius = (reports: any[], center: any): number => {
  if (reports.length === 0) return 0;
  
  const distances = reports.map(report => 
    Math.sqrt(
      Math.pow(Number(report.latitude) - center.latitude, 2) +
      Math.pow(Number(report.longitude) - center.longitude, 2)
    )
  );
  
  return Math.max(...distances);
};

const calculateRiskLevel = (reports: any[]): 'low' | 'medium' | 'high' | 'critical' => {
  const density = reports.length;
  const urgentCategories = ['seguridad', 'basura', 'iluminacion'];
  const urgentCount = reports.filter(r => urgentCategories.includes(r.category)).length;
  
  if (density >= 20 && urgentCount >= 10) return 'critical';
  if (density >= 15 && urgentCount >= 7) return 'high';
  if (density >= 10 && urgentCount >= 5) return 'medium';
  return 'low';
};

// Predictive Analysis
const generatePredictions = (reports: any[]): PredictionData[] => {
  const neighborhoods = [...new Set(reports.map(r => r.neighborhood).filter(Boolean))];
  
  return neighborhoods.map(neighborhood => {
    const neighborhoodReports = reports.filter(r => r.neighborhood === neighborhood);
    const recentReports = neighborhoodReports.filter(r => 
      new Date(r.created_at) > subDays(new Date(), 30)
    );
    
    const trend = recentReports.length / Math.max(1, neighborhoodReports.length - recentReports.length);
    const predictedIssues = Math.round(recentReports.length * trend * 1.2);
    
    const categories = neighborhoodReports.reduce((acc, r) => {
      acc[r.category] = (acc[r.category] || 0) + 1;
      return acc;
    }, {} as Record<string, number>);
    
    const topCategory = Object.entries(categories)
      .sort(([,a], [,b]) => Number(b) - Number(a))[0]?.[0];
    
    return {
      area: neighborhood,
      predictedIssues,
      confidence: Math.min(0.95, Math.max(0.3, recentReports.length / 50)),
      riskFactors: [
        topCategory && `Alta frecuencia de reportes de ${topCategory}`,
        trend > 1.5 && 'Tendencia creciente de reportes',
        recentReports.length > 20 && 'Alto volumen de reportes recientes'
      ].filter(Boolean) as string[],
      timeline: trend > 2 ? 'next_week' : trend > 1.2 ? 'next_month' : 'next_quarter',
      recommendations: generateRecommendations(topCategory, trend)
    };
  });
};

const generateRecommendations = (topCategory: string, trend: number): string[] => {
  const baseRecommendations = {
    'basura': ['Aumentar frecuencia de recolección', 'Instalar más contenedores'],
    'iluminacion': ['Revisar sistema eléctrico', 'Instalar más luminarias'],
    'baches': ['Programa de bacheo preventivo', 'Inspección de vías'],
    'seguridad': ['Aumentar patrullaje', 'Mejorar iluminación'],
    'otros': ['Evaluación específica necesaria', 'Monitoreo continuo']
  };
  
  const recommendations = baseRecommendations[topCategory as keyof typeof baseRecommendations] || baseRecommendations.otros;
  
  if (trend > 2) {
    recommendations.push('Intervención urgente requerida');
  }
  
  return recommendations;
};

// Correlation Analysis
const analyzeCorrelations = (reports: any[]): CorrelationData[] => {
  const categories = ['basura', 'iluminacion', 'baches', 'seguridad', 'otros'];
  const correlations: CorrelationData[] = [];
  
  for (let i = 0; i < categories.length; i++) {
    for (let j = i + 1; j < categories.length; j++) {
      const cat1Reports = reports.filter(r => r.category === categories[i]);
      const cat2Reports = reports.filter(r => r.category === categories[j]);
      
      // Simple correlation based on co-occurrence in same neighborhoods
      const neighborhoods1 = new Set(cat1Reports.map(r => r.neighborhood));
      const neighborhoods2 = new Set(cat2Reports.map(r => r.neighborhood));
      const intersection = new Set([...neighborhoods1].filter(x => neighborhoods2.has(x)));
      
      const correlation = intersection.size / Math.max(neighborhoods1.size, neighborhoods2.size, 1);
      
      if (correlation > 0.3) {
        correlations.push({
          category1: categories[i],
          category2: categories[j],
          correlation,
          significance: correlation > 0.7 ? 0.95 : correlation > 0.5 ? 0.8 : 0.6,
          patterns: [
            `Ambos problemas co-ocurren en ${intersection.size} barrios`,
            correlation > 0.7 ? 'Correlación muy fuerte' : correlation > 0.5 ? 'Correlación moderada' : 'Correlación débil'
          ]
        });
      }
    }
  }
  
  return correlations;
};

// Anomaly Detection
const detectAnomalies = (reports: any[]): AnomalyData[] => {
  const anomalies: AnomalyData[] = [];
  
  // Time-based anomalies
  const hourlyDistribution = reports.reduce((acc, report) => {
    const hour = new Date(report.created_at).getHours();
    acc[hour] = (acc[hour] || 0) + 1;
    return acc;
  }, {} as Record<number, number>);
  
  const hourlyValues = Object.values(hourlyDistribution) as number[];
  const totalHourlyReports = sumNumbers(hourlyValues);
  const avgHourlyReports = totalHourlyReports / 24;
  
  reports.forEach(report => {
    const hour = new Date(report.created_at).getHours();
    const hourlyCount = hourlyDistribution[hour] || 0;
    
    if (hourlyCount > avgHourlyReports * 3) {
      anomalies.push({
        reportId: report.id,
        anomalyType: 'timing',
        score: hourlyCount / avgHourlyReports,
        description: `Reporte creado en hora inusual (${hour}:00)`,
        created_at: report.created_at
      });
    }
  });
  
  // Location-based anomalies
  const neighborhoodCounts = reports.reduce((acc, report) => {
    if (report.neighborhood) {
      acc[report.neighborhood] = (acc[report.neighborhood] || 0) + 1;
    }
    return acc;
  }, {} as Record<string, number>);
  
  const neighborhoodValues = Object.values(neighborhoodCounts) as number[];
  const totalNeighborhoodReports = sumNumbers(neighborhoodValues);
  const avgNeighborhoodReports = totalNeighborhoodReports / Object.keys(neighborhoodCounts).length;
  
  reports.forEach(report => {
    if (report.neighborhood) {
      const neighborhoodCount = neighborhoodCounts[report.neighborhood];
      if (neighborhoodCount < avgNeighborhoodReports * 0.1) {
        anomalies.push({
          reportId: report.id,
          anomalyType: 'location',
          score: avgNeighborhoodReports / neighborhoodCount,
          description: `Reporte en área con muy poca actividad`,
          created_at: report.created_at
        });
      }
    }
  });
  
  return anomalies.slice(0, 20); // Limit to top 20 anomalies
};

// Trend Analysis
const analyzeTrends = (reports: any[]): TrendData[] => {
  const categories = ['basura', 'iluminacion', 'baches', 'seguridad', 'otros'];
  const trends: TrendData[] = [];
  
  categories.forEach(category => {
    const categoryReports = reports.filter(r => r.category === category);
    const monthlyData = categoryReports.reduce((acc, report) => {
      const month = format(new Date(report.created_at), 'yyyy-MM');
      acc[month] = (acc[month] || 0) + 1;
      return acc;
    }, {} as Record<string, number>);
    
    const months = Object.keys(monthlyData).sort();
    const values = months.map(month => monthlyData[month]);
    
    if (values.length >= 3) {
      const recentValues = values.slice(-3);
      const earlierValues = values.slice(0, -3);
      const recentAvg = sumNumbers(recentValues) / recentValues.length;
      const earlierAvg = earlierValues.length > 0 
        ? sumNumbers(earlierValues) / earlierValues.length 
        : recentAvg;
      
      const changeRate = (recentAvg - earlierAvg) / Math.max(earlierAvg, 1);
      const trend = changeRate > 0.1 ? 'increasing' : changeRate < -0.1 ? 'decreasing' : 'stable';
      
      // Simple forecast (linear projection)
      const forecast = Array.from({ length: 3 }, (_, i) => 
        Math.max(0, Math.round(recentAvg + (changeRate * recentAvg * (i + 1))))
      );
      
      trends.push({
        period: months[months.length - 1],
        category,
        trend,
        changeRate,
        seasonality: calculateSeasonality(values),
        forecast
      });
    }
  });
  
  return trends;
};

const calculateSeasonality = (values: number[]): number => {
  if (values.length < 12) return 0;
  
  // Simple seasonality detection
  const quarters = [0, 1, 2, 3].map(q => {
    const quarterValues = values.filter((_, i) => Math.floor(i / 3) % 4 === q);
    return sumNumbers(quarterValues) / quarterValues.length;
  });
  
  const maxQuarter = Math.max(...quarters);
  const minQuarter = Math.min(...quarters);
  const avgQuarter = sumNumbers(quarters) / 4;
  
  return (maxQuarter - minQuarter) / avgQuarter;
};

export const useAdvancedAnalytics = (dateRange: [Date, Date] | null = null) => {
  return useQuery({
    queryKey: ['advanced-analytics', dateRange],
    queryFn: async () => {
      let query = supabase
        .from('reports')
        .select(`
          id,
          category,
          status,
          latitude,
          longitude,
          created_at,
          neighborhood,
          address,
          title,
          description
        `)
        .order('created_at', { ascending: false });

      if (dateRange) {
        query = query
          .gte('created_at', dateRange[0].toISOString())
          .lte('created_at', dateRange[1].toISOString());
      }

      const { data: reports, error } = await query;
      if (error) throw error;

      const clusters = performKMeansClustering(reports || [], 5);
      const predictions = generatePredictions(reports || []);
      const correlations = analyzeCorrelations(reports || []);
      const anomalies = detectAnomalies(reports || []);
      const trends = analyzeTrends(reports || []);

      return {
        clusters,
        predictions,
        correlations,
        anomalies,
        trends,
        totalReports: reports?.length || 0,
        analysisDate: new Date().toISOString()
      };
    },
    staleTime: 1000 * 60 * 15, // Cache for 15 minutes
    gcTime: 1000 * 60 * 30, // Keep in memory for 30 minutes
  });
};

export const useClusterAnalysis = () => {
  return useQuery({
    queryKey: ['cluster-analysis'],
    queryFn: async () => {
      const { data: reports, error } = await supabase
        .from('reports')
        .select('id, latitude, longitude, category, created_at, neighborhood')
        .not('latitude', 'is', null)
        .not('longitude', 'is', null)
        .gte('created_at', subDays(new Date(), 90).toISOString());

      if (error) throw error;
      return performKMeansClustering(reports || [], 8);
    },
    staleTime: 1000 * 60 * 30, // Cache for 30 minutes
  });
};

export const usePredictiveAnalysis = () => {
  return useQuery({
    queryKey: ['predictive-analysis'],
    queryFn: async () => {
      const { data: reports, error } = await supabase
        .from('reports')
        .select('id, category, created_at, neighborhood')
        .gte('created_at', subDays(new Date(), 180).toISOString());

      if (error) throw error;
      return generatePredictions(reports || []);
    },
    staleTime: 1000 * 60 * 60, // Cache for 1 hour
  });
};