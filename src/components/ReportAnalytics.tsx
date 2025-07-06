import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, PieChart, Pie, Cell } from "recharts";
import { TrendingUp, AlertTriangle, Clock, CheckCircle } from "lucide-react";

interface ReportAnalyticsProps {
  reports: any[];
}

const COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042', '#8884D8'];

const ReportAnalytics = ({ reports }: ReportAnalyticsProps) => {
  // Análisis de patrones y frecuencia
  const categoryFrequency = reports.reduce((acc: Record<string, number>, report) => {
    acc[report.category] = (acc[report.category] || 0) + 1;
    return acc;
  }, {});

  const neighborhoodFrequency = reports.reduce((acc: Record<string, number>, report) => {
    if (report.neighborhood) {
      acc[report.neighborhood] = (acc[report.neighborhood] || 0) + 1;
    }
    return acc;
  }, {});

  const statusDistribution = reports.reduce((acc: Record<string, number>, report) => {
    acc[report.status] = (acc[report.status] || 0) + 1;
    return acc;
  }, {});

  // Datos para gráficos
  const categoryData = Object.entries(categoryFrequency)
    .map(([name, value]) => ({ name: getCategoryLabel(name), value: value as number }))
    .sort((a, b) => b.value - a.value);

  const neighborhoodData = Object.entries(neighborhoodFrequency)
    .map(([name, value]) => ({ name, value: value as number }))
    .sort((a, b) => b.value - a.value)
    .slice(0, 10); // Top 10 barrios

  const statusData = Object.entries(statusDistribution).map(([name, value]) => ({
    name: getStatusLabel(name),
    value: value as number,
    fill: getStatusColor(name)
  }));

  // Identificar patrones frecuentes
  const frequentIssues = categoryData.filter(item => item.value >= 3);
  const problematicNeighborhoods = neighborhoodData.filter(item => item.value >= 2);

  function getCategoryLabel(category: string) {
    const categories = {
      basura: 'Basura y Limpieza',
      iluminacion: 'Iluminación Pública',
      baches: 'Baches y Pavimento',
      seguridad: 'Seguridad Ciudadana',
      otros: 'Otros'
    };
    return categories[category as keyof typeof categories] || category;
  }

  function getStatusLabel(status: string) {
    const statuses = {
      pendiente: 'Pendiente',
      en_proceso: 'En Proceso',
      resuelto: 'Resuelto',
      rechazado: 'Rechazado'
    };
    return statuses[status as keyof typeof statuses] || status;
  }

  function getStatusColor(status: string) {
    const colors = {
      pendiente: '#FFBB28',
      en_proceso: '#0088FE',
      resuelto: '#00C49F',
      rechazado: '#FF8042'
    };
    return colors[status as keyof typeof colors] || '#8884D8';
  }

  return (
    <div className="space-y-6">
      {/* Patrones Identificados */}
      <Card className="bg-white/95 backdrop-blur-sm">
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <TrendingUp className="h-5 w-5" />
            Patrones y Tendencias Identificadas
          </CardTitle>
          <CardDescription>
            Análisis de problemas recurrentes para identificar áreas de mejora
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="grid md:grid-cols-2 gap-6">
            {/* Problemas Frecuentes */}
            <div>
              <h4 className="font-semibold text-gray-800 mb-3 flex items-center gap-2">
                <AlertTriangle className="h-4 w-4 text-orange-500" />
                Problemas Más Frecuentes
              </h4>
              {frequentIssues.length > 0 ? (
                <div className="space-y-2">
                  {frequentIssues.map((issue, index) => (
                    <div key={index} className="flex items-center justify-between p-3 bg-orange-50 rounded-lg">
                      <span className="font-medium">{issue.name}</span>
                      <Badge variant="secondary">{issue.value} reportes</Badge>
                    </div>
                  ))}
                </div>
              ) : (
                <p className="text-gray-500 text-sm">No se han identificado patrones frecuentes aún</p>
              )}
            </div>

            {/* Barrios Problemáticos */}
            <div>
              <h4 className="font-semibold text-gray-800 mb-3 flex items-center gap-2">
                <AlertTriangle className="h-4 w-4 text-red-500" />
                Barrios con Más Incidencias
              </h4>
              {problematicNeighborhoods.length > 0 ? (
                <div className="space-y-2">
                  {problematicNeighborhoods.map((neighborhood, index) => (
                    <div key={index} className="flex items-center justify-between p-3 bg-red-50 rounded-lg">
                      <span className="font-medium">{neighborhood.name}</span>
                      <Badge variant="destructive">{neighborhood.value} reportes</Badge>
                    </div>
                  ))}
                </div>
              ) : (
                <p className="text-gray-500 text-sm">No se han identificado barrios problemáticos</p>
              )}
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Gráficos de Análisis */}
      <div className="grid lg:grid-cols-2 gap-6">
        {/* Distribución por Categoría */}
        <Card className="bg-white/95 backdrop-blur-sm">
          <CardHeader>
            <CardTitle>Reportes por Categoría</CardTitle>
            <CardDescription>Frecuencia de tipos de problemas reportados</CardDescription>
          </CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={300}>
              <BarChart data={categoryData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis 
                  dataKey="name" 
                  angle={-45} 
                  textAnchor="end" 
                  height={80}
                  fontSize={12}
                />
                <YAxis />
                <Tooltip />
                <Bar dataKey="value" fill="#0088FE" />
              </BarChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>

        {/* Distribución por Estado */}
        <Card className="bg-white/95 backdrop-blur-sm">
          <CardHeader>
            <CardTitle>Estado de los Reportes</CardTitle>
            <CardDescription>Distribución del estado actual de los reportes</CardDescription>
          </CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={300}>
              <PieChart>
                <Pie
                  data={statusData}
                  cx="50%"
                  cy="50%"
                  labelLine={false}
                  label={({ name, percent }) => `${name} ${(percent * 100).toFixed(0)}%`}
                  outerRadius={80}
                  fill="#8884d8"
                  dataKey="value"
                >
                  {statusData.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={entry.fill} />
                  ))}
                </Pie>
                <Tooltip />
              </PieChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>
      </div>

      {/* Top Barrios con Problemas */}
      {neighborhoodData.length > 0 && (
        <Card className="bg-white/95 backdrop-blur-sm">
          <CardHeader>
            <CardTitle>Barrios con Más Reportes</CardTitle>
            <CardDescription>Identificación de áreas que requieren mayor atención</CardDescription>
          </CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={300}>
              <BarChart data={neighborhoodData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis 
                  dataKey="name" 
                  angle={-45} 
                  textAnchor="end" 
                  height={80}
                  fontSize={12}
                />
                <YAxis />
                <Tooltip />
                <Bar dataKey="value" fill="#FF8042" />
              </BarChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>
      )}

      {/* Recomendaciones */}
      <Card className="bg-gradient-to-r from-blue-50 to-green-50 border-blue-200">
        <CardHeader>
          <CardTitle className="flex items-center gap-2 text-blue-800">
            <CheckCircle className="h-5 w-5" />
            Recomendaciones Basadas en Patrones
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-3">
            {frequentIssues.length > 0 && (
              <div className="bg-white/70 p-4 rounded-lg">
                <h4 className="font-semibold text-blue-800 mb-2">Atención Prioritaria:</h4>
                <p className="text-blue-700 text-sm">
                  Se recomienda crear planes de acción específicos para {frequentIssues[0]?.name} 
                  ({frequentIssues[0]?.value} reportes), ya que representa el problema más frecuente.
                </p>
              </div>
            )}
            
            {problematicNeighborhoods.length > 0 && (
              <div className="bg-white/70 p-4 rounded-lg">
                <h4 className="font-semibold text-blue-800 mb-2">Enfoque Territorial:</h4>
                <p className="text-blue-700 text-sm">
                  El barrio {problematicNeighborhoods[0]?.name} requiere atención especial con 
                  {problematicNeighborhoods[0]?.value} reportes. Considerar inspecciones preventivas.
                </p>
              </div>
            )}

            <div className="bg-white/70 p-4 rounded-lg">
              <h4 className="font-semibold text-blue-800 mb-2">Mejora Continua:</h4>
              <p className="text-blue-700 text-sm">
                Establecer reuniones mensuales para revisar estos patrones y ajustar estrategias 
                de mantenimiento preventivo en las áreas más afectadas.
              </p>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
};

export default ReportAnalytics;