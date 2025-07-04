import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { ArrowLeft, FileText, MapPin, Calendar, Plus, Filter, Eye } from "lucide-react";
import { Link } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/hooks/useAuth";
import { format } from "date-fns";
import { es } from "date-fns/locale";
import { useState } from "react";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

interface Report {
  id: string;
  title: string;
  description: string;
  category: string;
  status: string;
  created_at: string;
  address: string | null;
  neighborhood: string | null;
  priority: string | null;
  resolved_at: string | null;
}

const MisReportes = () => {
  const { user } = useAuth();
  const [statusFilter, setStatusFilter] = useState<string>('all');
  const [categoryFilter, setCategoryFilter] = useState<string>('all');

  const { data: reports, isLoading, refetch } = useQuery({
    queryKey: ['user-reports', user?.id, statusFilter, categoryFilter],
    queryFn: async () => {
      if (!user) return [];
      
      let query = supabase
        .from('reports')
        .select('*')
        .eq('user_id', user.id)
        .order('created_at', { ascending: false });

      if (statusFilter !== 'all') {
        query = query.eq('status', statusFilter as 'pendiente' | 'en_proceso' | 'resuelto' | 'rechazado');
      }

      if (categoryFilter !== 'all') {
        query = query.eq('category', categoryFilter as 'basura' | 'iluminacion' | 'baches' | 'seguridad' | 'otros');
      }

      const { data, error } = await query;
      if (error) throw error;
      return data as Report[];
    },
    enabled: !!user,
  });

  const getStatusBadge = (status: string) => {
    const statusConfig = {
      pendiente: { label: 'Pendiente', color: 'bg-yellow-100 text-yellow-800' },
      en_proceso: { label: 'En Proceso', color: 'bg-blue-100 text-blue-800' },
      resuelto: { label: 'Resuelto', color: 'bg-green-100 text-green-800' },
      rechazado: { label: 'Rechazado', color: 'bg-red-100 text-red-800' }
    };
    
    const config = statusConfig[status as keyof typeof statusConfig] || 
      { label: status, color: 'bg-gray-100 text-gray-800' };
    
    return (
      <Badge className={config.color}>
        {config.label}
      </Badge>
    );
  };

  const getCategoryLabel = (category: string) => {
    const categories = {
      basura: 'Basura',
      iluminacion: 'Iluminación',
      baches: 'Baches',
      seguridad: 'Seguridad',
      otros: 'Otros'
    };
    return categories[category as keyof typeof categories] || category;
  };

  const getPriorityColor = (priority: string | null) => {
    if (!priority) return 'text-gray-500';
    const colors = {
      baja: 'text-green-600',
      media: 'text-yellow-600', 
      alta: 'text-red-600'
    };
    return colors[priority as keyof typeof colors] || 'text-gray-500';
  };

  const reportsByStatus = reports?.reduce((acc, report) => {
    acc[report.status] = (acc[report.status] || 0) + 1;
    return acc;
  }, {} as Record<string, number>) || {};

  if (isLoading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 flex items-center justify-center">
        <div className="bg-white/10 backdrop-blur-sm p-8 rounded-2xl">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-white mx-auto"></div>
          <p className="text-white mt-4">Cargando tus reportes...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 animate-fade-in">
      <div className="max-w-6xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-4">
          <Link to="/" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold">MIS REPORTES</h1>
            <p className="text-white/80">Revisa el estado de tus reportes</p>
          </div>
        </div>

        {/* Statistics */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          <Card className="bg-white/95 backdrop-blur-sm">
            <CardContent className="p-4 text-center">
              <div className="text-2xl font-bold text-gray-800">{reports?.length || 0}</div>
              <div className="text-sm text-gray-600">Total</div>
            </CardContent>
          </Card>
          <Card className="bg-white/95 backdrop-blur-sm">
            <CardContent className="p-4 text-center">
              <div className="text-2xl font-bold text-yellow-600">{reportsByStatus.pendiente || 0}</div>
              <div className="text-sm text-gray-600">Pendientes</div>
            </CardContent>
          </Card>
          <Card className="bg-white/95 backdrop-blur-sm">
            <CardContent className="p-4 text-center">
              <div className="text-2xl font-bold text-blue-600">{reportsByStatus.en_proceso || 0}</div>
              <div className="text-sm text-gray-600">En Proceso</div>
            </CardContent>
          </Card>
          <Card className="bg-white/95 backdrop-blur-sm">
            <CardContent className="p-4 text-center">
              <div className="text-2xl font-bold text-green-600">{reportsByStatus.resuelto || 0}</div>
              <div className="text-sm text-gray-600">Resueltos</div>
            </CardContent>
          </Card>
        </div>

        {/* Filters */}
        <Card className="bg-white/95 backdrop-blur-sm">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Filter className="h-5 w-5" />
              Filtros
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="flex gap-4 flex-wrap">
              <div className="min-w-[200px]">
                <label className="text-sm font-medium mb-2 block">Estado</label>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger>
                    <SelectValue placeholder="Todos los estados" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">Todos los estados</SelectItem>
                    <SelectItem value="pendiente">Pendiente</SelectItem>
                    <SelectItem value="en_proceso">En Proceso</SelectItem>
                    <SelectItem value="resuelto">Resuelto</SelectItem>
                    <SelectItem value="rechazado">Rechazado</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              
              <div className="min-w-[200px]">
                <label className="text-sm font-medium mb-2 block">Categoría</label>
                <Select value={categoryFilter} onValueChange={setCategoryFilter}>
                  <SelectTrigger>
                    <SelectValue placeholder="Todas las categorías" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">Todas las categorías</SelectItem>
                    <SelectItem value="basura">Basura</SelectItem>
                    <SelectItem value="iluminacion">Iluminación</SelectItem>
                    <SelectItem value="baches">Baches</SelectItem>
                    <SelectItem value="seguridad">Seguridad</SelectItem>
                    <SelectItem value="otros">Otros</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="flex items-end">
                <Button asChild>
                  <Link to="/reportar" className="flex items-center gap-2">
                    <Plus className="h-4 w-4" />
                    Nuevo Reporte
                  </Link>
                </Button>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Reports List */}
        <Card className="bg-white/95 backdrop-blur-sm">
          <CardHeader>
            <CardTitle>Tus Reportes</CardTitle>
            <CardDescription>
              {reports?.length || 0} reporte(s) encontrado(s)
            </CardDescription>
          </CardHeader>
          <CardContent>
            {reports && reports.length > 0 ? (
              <div className="space-y-4">
                {reports.map((report) => (
                  <div key={report.id} className="border rounded-lg p-4 hover:bg-gray-50 transition-colors">
                    <div className="flex items-start justify-between">
                      <div className="flex-1">
                        <div className="flex items-center gap-3 mb-2">
                          <FileText className="h-5 w-5 text-primary" />
                          <h3 className="text-lg font-semibold">{report.title}</h3>
                          {getStatusBadge(report.status)}
                          <Badge variant="outline">{getCategoryLabel(report.category)}</Badge>
                        </div>
                        
                        <p className="text-gray-600 mb-2">{report.description}</p>
                        
                        <div className="flex items-center gap-4 text-sm text-gray-500">
                          <div className="flex items-center gap-1">
                            <Calendar className="h-4 w-4" />
                            {format(new Date(report.created_at), 'dd/MM/yyyy HH:mm', { locale: es })}
                          </div>
                          {report.address && (
                            <div className="flex items-center gap-1">
                              <MapPin className="h-4 w-4" />
                              {report.address}
                            </div>
                          )}
                          {report.priority && (
                            <div className={`font-medium ${getPriorityColor(report.priority)}`}>
                              Prioridad: {report.priority.charAt(0).toUpperCase() + report.priority.slice(1)}
                            </div>
                          )}
                        </div>

                        {report.resolved_at && (
                          <div className="mt-2 text-sm text-green-600">
                            Resuelto el {format(new Date(report.resolved_at), 'dd/MM/yyyy HH:mm', { locale: es })}
                          </div>
                        )}
                      </div>
                      
                      <Button size="sm" variant="outline">
                        <Eye className="w-4 h-4 mr-1" />
                        Ver Detalles
                      </Button>
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <div className="text-center py-8">
                <FileText className="h-12 w-12 text-gray-400 mx-auto mb-4" />
                <p className="text-gray-500">No tienes reportes aún</p>
                <p className="text-sm text-gray-400 mt-1">
                  Crea tu primer reporte para comenzar a mejorar tu comunidad
                </p>
                <Button asChild className="mt-4">
                  <Link to="/reportar">
                    <Plus className="h-4 w-4 mr-2" />
                    Crear Primer Reporte
                  </Link>
                </Button>
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default MisReportes;