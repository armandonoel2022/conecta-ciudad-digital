import React, { useState } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { useUserRoles } from '@/hooks/useUserRoles';
import { useReportsAnalytics, usePanicAlertsAnalytics, useAmberAlertsAnalytics, useUserDemographics } from '@/hooks/useReportsAnalytics';
import { 
  FileText, 
  Download, 
  Calendar, 
  Filter, 
  Plus, 
  BarChart3, 
  Eye, 
  ExternalLink, 
  ArrowLeft,
  AlertTriangle,
  Shield,
  Users,
  TrendingUp,
  Clock,
  MapPin
} from 'lucide-react';
import { format, subDays } from 'date-fns';
import { es } from 'date-fns/locale';
import { 
  ResponsiveContainer, 
  BarChart, 
  Bar, 
  XAxis, 
  YAxis, 
  CartesianGrid, 
  Tooltip, 
  PieChart, 
  Pie, 
  Cell,
  LineChart,
  Line
} from 'recharts';
import ReportsHeatMap from '@/components/ReportsHeatMap';
import DataMiningDashboard from '@/components/DataMiningDashboard';
import { Link } from 'react-router-dom';

// Colores para gráficos
const COLORS = [
  'hsl(var(--primary))',
  'hsl(var(--secondary))', 
  'hsl(var(--accent))',
  '#10b981',
  '#f59e0b',
  '#ef4444',
  '#8b5cf6',
  '#06b6d4'
];

const Reports = () => {
  const { isAdmin, isCommunityLeader, loading: rolesLoading } = useUserRoles();
  const [dateRange, setDateRange] = useState<[Date, Date] | null>([
    subDays(new Date(), 30),
    new Date()
  ]);
  const [selectedCategory, setSelectedCategory] = useState<string>('all');

  // Cargar datos analíticos
  const { data: reportsStats, isLoading: reportsLoading } = useReportsAnalytics(dateRange);
  const { data: panicStats, isLoading: panicLoading } = usePanicAlertsAnalytics();
  const { data: amberStats, isLoading: amberLoading } = useAmberAlertsAnalytics();
  const { data: demographics, isLoading: demographicsLoading } = useUserDemographics();

  const isLoading = reportsLoading || panicLoading || amberLoading || demographicsLoading;

  // Función helper (definida antes de ser usada)
  const getCategoryLabel = (category: string) => {
    const categories = {
      basura: 'Basura y Limpieza',
      iluminacion: 'Iluminación Pública',
      baches: 'Baches y Pavimento',
      seguridad: 'Seguridad Ciudadana',
      otros: 'Otros'
    };
    return categories[category as keyof typeof categories] || category;
  };

  // Preparar datos para gráficos
  const categoryData = reportsStats ? Object.entries(reportsStats.byCategory).map(([key, value]) => ({
    name: getCategoryLabel(key),
    value,
    fill: COLORS[Math.abs(key.split('').reduce((a, b) => a + b.charCodeAt(0), 0)) % COLORS.length]
  })) : [];

  const monthlyData = reportsStats ? Object.entries(reportsStats.byMonth).map(([key, value]) => ({
    month: key,
    reportes: value,
    panico: panicStats?.byMonth[key] || 0,
    amber: amberStats?.byMonth[key] || 0
  })) : [];

  const neighborhoodData = reportsStats ? Object.entries(reportsStats.byNeighborhood)
    .sort(([,a], [,b]) => b - a)
    .slice(0, 10)
    .map(([name, value]) => ({ name, value })) : [];

  if (rolesLoading || isLoading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 flex items-center justify-center">
        <div className="bg-white/10 backdrop-blur-sm p-8 rounded-2xl">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-white mx-auto"></div>
          <p className="text-white mt-4">Cargando analytics...</p>
        </div>
      </div>
    );
  }

  if (!isAdmin && !isCommunityLeader) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 flex items-center justify-center">
        <Card className="bg-white/95 backdrop-blur-sm max-w-md">
          <CardHeader>
            <CardTitle className="text-red-600">Acceso Restringido</CardTitle>
          </CardHeader>
          <CardContent>
            <p>No tienes permisos para acceder a esta sección. Solo los administradores y líderes comunitarios pueden ver los reportes.</p>
          </CardContent>
        </Card>
      </div>
    );
  }


  return (
    <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 animate-fade-in">
      <div className="max-w-7xl mx-auto space-y-6">
        {/* Header */}
        <div className="bg-white/10 backdrop-blur-sm p-6 rounded-2xl shadow-xl text-white">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <Link to="/" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
                <ArrowLeft className="h-6 w-6" />
              </Link>
              <BarChart3 className="h-8 w-8" />
              <div>
                <h1 className="text-3xl font-bold">Dashboard de Reportes</h1>
                <p className="text-white/90">
                  Análisis completo de incidencias y alertas del sistema
                </p>
              </div>
            </div>
          </div>
        </div>

        {/* Métricas principales */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <Card className="bg-white/95 backdrop-blur-sm hover-scale">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Total Reportes</CardTitle>
              <FileText className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-primary">{reportsStats?.totalReports || 0}</div>
              <p className="text-xs text-muted-foreground">
                {reportsStats?.pendingReports || 0} pendientes
              </p>
            </CardContent>
          </Card>

          <Card className="bg-white/95 backdrop-blur-sm hover-scale">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Alertas Pánico</CardTitle>
              <AlertTriangle className="h-4 w-4 text-red-500" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-red-600">{panicStats?.totalAlerts || 0}</div>
              <p className="text-xs text-muted-foreground">
                {panicStats?.activeAlerts || 0} activas
              </p>
            </CardContent>
          </Card>

          <Card className="bg-white/95 backdrop-blur-sm hover-scale">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Alertas Amber</CardTitle>
              <Shield className="h-4 w-4 text-amber-500" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-amber-600">{amberStats?.totalAlerts || 0}</div>
              <p className="text-xs text-muted-foreground">
                {amberStats?.activeAlerts || 0} activas
              </p>
            </CardContent>
          </Card>

          <Card className="bg-white/95 backdrop-blur-sm hover-scale">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Usuarios Activos</CardTitle>
              <Users className="h-4 w-4 text-green-500" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-green-600">{demographics?.totalUsers || 0}</div>
              <p className="text-xs text-muted-foreground">
                Edad promedio: {Math.round(demographics?.averageAge || 0)} años
              </p>
            </CardContent>
          </Card>
        </div>

        {/* Tabs para diferentes vistas */}
        <Tabs defaultValue="overview" className="space-y-6">
          <TabsList className="grid w-full grid-cols-5 bg-white/95 backdrop-blur-sm">
            <TabsTrigger value="overview">Resumen</TabsTrigger>
            <TabsTrigger value="analytics">Análisis</TabsTrigger>
            <TabsTrigger value="heatmap">Mapa de Calor</TabsTrigger>
            <TabsTrigger value="demographics">Demografía</TabsTrigger>
            <TabsTrigger value="datamining">Data Mining</TabsTrigger>
          </TabsList>

          <TabsContent value="overview" className="space-y-6">
            {/* Gráfico de tendencias mensuales */}
            <Card className="bg-white/95 backdrop-blur-sm">
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <TrendingUp className="h-5 w-5" />
                  Tendencias Mensuales
                </CardTitle>
              </CardHeader>
              <CardContent>
                <ResponsiveContainer width="100%" height={300}>
                  <LineChart data={monthlyData}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="month" />
                    <YAxis />
                    <Tooltip />
                    <Line type="monotone" dataKey="reportes" stroke="hsl(var(--primary))" name="Reportes" />
                    <Line type="monotone" dataKey="panico" stroke="#ef4444" name="Pánico" />
                    <Line type="monotone" dataKey="amber" stroke="#f59e0b" name="Amber" />
                  </LineChart>
                </ResponsiveContainer>
              </CardContent>
            </Card>

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              {/* Distribución por categorías */}
              <Card className="bg-white/95 backdrop-blur-sm">
                <CardHeader>
                  <CardTitle>Reportes por Categoría</CardTitle>
                </CardHeader>
                <CardContent>
                  <ResponsiveContainer width="100%" height={250}>
                    <PieChart>
                      <Pie
                        data={categoryData}
                        cx="50%"
                        cy="50%"
                        labelLine={false}
                        label={({ name, percent }) => `${name} ${(percent * 100).toFixed(0)}%`}
                        outerRadius={80}
                        fill="#8884d8"
                        dataKey="value"
                      >
                        {categoryData.map((entry, index) => (
                          <Cell key={`cell-${index}`} fill={entry.fill} />
                        ))}
                      </Pie>
                      <Tooltip />
                    </PieChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>

              {/* Top barrios */}
              <Card className="bg-white/95 backdrop-blur-sm">
                <CardHeader>
                  <CardTitle>Barrios con Más Reportes</CardTitle>
                </CardHeader>
                <CardContent>
                  <ResponsiveContainer width="100%" height={250}>
                    <BarChart data={neighborhoodData}>
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis dataKey="name" angle={-45} textAnchor="end" height={60} />
                      <YAxis />
                      <Tooltip />
                      <Bar dataKey="value" fill="hsl(var(--primary))" />
                    </BarChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          <TabsContent value="analytics" className="space-y-6">
            {/* Métricas estadísticas */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              <Card className="bg-white/95 backdrop-blur-sm">
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <Clock className="h-5 w-5" />
                    Tiempo de Resolución
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-3xl font-bold text-primary">
                    {Math.round(reportsStats?.averageResolutionTime || 0)} días
                  </div>
                  <p className="text-sm text-muted-foreground">Promedio de resolución</p>
                </CardContent>
              </Card>

              <Card className="bg-white/95 backdrop-blur-sm">
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <Shield className="h-5 w-5" />
                    Resolución Amber
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-3xl font-bold text-amber-600">
                    {Math.round(amberStats?.averageResolutionTime || 0)}h
                  </div>
                  <p className="text-sm text-muted-foreground">Promedio en horas</p>
                </CardContent>
              </Card>

              <Card className="bg-white/95 backdrop-blur-sm">
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <TrendingUp className="h-5 w-5" />
                    Tasa de Resolución
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-3xl font-bold text-green-600">
                    {reportsStats ? Math.round(((reportsStats.totalReports - reportsStats.pendingReports) / reportsStats.totalReports) * 100) : 0}%
                  </div>
                  <p className="text-sm text-muted-foreground">Reportes resueltos</p>
                </CardContent>
              </Card>
            </div>

            {/* Reportes recientes */}
            <Card className="bg-white/95 backdrop-blur-sm">
              <CardHeader>
                <CardTitle>Reportes Recientes</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {reportsStats?.recentReports.slice(0, 5).map((report) => (
                    <div key={report.id} className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                      <div className="flex-1">
                        <h4 className="font-medium">{report.title}</h4>
                        <p className="text-sm text-gray-600">{getCategoryLabel(report.category)}</p>
                      </div>
                      <div className="text-right">
                        <Badge variant={report.status === 'resuelto' ? 'default' : 'secondary'}>
                          {report.status}
                        </Badge>
                        <p className="text-xs text-gray-500 mt-1">
                          {format(new Date(report.created_at), 'dd/MM/yyyy', { locale: es })}
                        </p>
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="heatmap" className="space-y-6">
            <ReportsHeatMap reports={reportsStats?.recentReports || []} />
          </TabsContent>

          <TabsContent value="demographics" className="space-y-6">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              {/* Distribución por edad */}
              <Card className="bg-white/95 backdrop-blur-sm">
                <CardHeader>
                  <CardTitle>Distribución por Edad</CardTitle>
                </CardHeader>
                <CardContent>
                  <ResponsiveContainer width="100%" height={250}>
                    <BarChart data={demographics ? Object.entries(demographics.ageGroups).map(([name, value]) => ({ name, value })) : []}>
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis dataKey="name" />
                      <YAxis />
                      <Tooltip />
                      <Bar dataKey="value" fill="hsl(var(--primary))" />
                    </BarChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>

              {/* Distribución por género */}
              <Card className="bg-white/95 backdrop-blur-sm">
                <CardHeader>
                  <CardTitle>Distribución por Género</CardTitle>
                </CardHeader>
                <CardContent>
                  <ResponsiveContainer width="100%" height={250}>
                    <PieChart>
                      <Pie
                        data={demographics ? Object.entries(demographics.byGender).map(([name, value]) => ({ name, value })) : []}
                        cx="50%"
                        cy="50%"
                        labelLine={false}
                        label={({ name, percent }) => `${name} ${(percent * 100).toFixed(0)}%`}
                        outerRadius={80}
                        fill="#8884d8"
                        dataKey="value"
                      >
                        {demographics && Object.entries(demographics.byGender).map(([name], index) => {
                          // Asignar colores específicos por género
                          const getGenderColor = (genderName: string) => {
                            if (genderName.toLowerCase() === 'femenino') return '#ec4899'; // Rosa
                            if (genderName.toLowerCase() === 'masculino') return 'hsl(var(--primary))'; // Azul del tema
                            return COLORS[index % COLORS.length]; // Otros géneros usan el esquema existente
                          };
                          
                          return (
                            <Cell key={`cell-${index}`} fill={getGenderColor(name)} />
                          );
                        })}
                      </Pie>
                      <Tooltip />
                    </PieChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          <TabsContent value="datamining" className="space-y-6">
            <DataMiningDashboard />
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
};

export default Reports;
