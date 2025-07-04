import React, { useState } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { useUserRoles } from '@/hooks/useUserRoles';
import { useQuery } from '@tanstack/react-query';
import { supabase } from '@/integrations/supabase/client';
import { FileText, Download, Calendar, Filter, Plus, BarChart3, Eye, ExternalLink, ArrowLeft } from 'lucide-react';
import { format } from 'date-fns';
import { es } from 'date-fns/locale';
import CreateReportDialog from '@/components/CreateReportDialog';
import { toast } from 'sonner';
import { Link } from 'react-router-dom';

interface GeneratedReport {
  id: string;
  title: string;
  description: string;
  report_type: string;
  generated_by: string;
  date_range_start: string;
  date_range_end: string;
  status: string;
  created_at: string;
  google_sheets_url?: string;
  google_chart_url?: string;
  pdf_url?: string;
}

const Reports = () => {
  const { isAdmin, isCommunityLeader, loading: rolesLoading } = useUserRoles();
  const [selectedType, setSelectedType] = useState<string>('all');
  const [selectedStatus, setSelectedStatus] = useState<string>('all');
  const [createDialogOpen, setCreateDialogOpen] = useState(false);

  const { data: reports, isLoading, refetch } = useQuery({
    queryKey: ['generated-reports', selectedType, selectedStatus],
    queryFn: async () => {
      let query = supabase
        .from('generated_reports')
        .select('*')
        .order('created_at', { ascending: false });

      if (selectedType !== 'all') {
        query = query.eq('report_type', selectedType);
      }

      if (selectedStatus !== 'all') {
        query = query.eq('status', selectedStatus);
      }

      const { data, error } = await query;
      if (error) throw error;
      return data as GeneratedReport[];
    },
    enabled: isAdmin || isCommunityLeader,
  });

  if (rolesLoading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 flex items-center justify-center">
        <div className="bg-white/10 backdrop-blur-sm p-8 rounded-2xl">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-white mx-auto"></div>
          <p className="text-white mt-4">Cargando...</p>
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

  const getStatusBadge = (status: string) => {
    const statusConfig = {
      generating: { label: 'Generando', color: 'bg-yellow-100 text-yellow-800' },
      completed: { label: 'Completado', color: 'bg-green-100 text-green-800' },
      failed: { label: 'Error', color: 'bg-red-100 text-red-800' }
    };
    
    const config = statusConfig[status as keyof typeof statusConfig] || 
      { label: status, color: 'bg-gray-100 text-gray-800' };
    
    return (
      <Badge className={config.color}>
        {config.label}
      </Badge>
    );
  };

  const getReportTypeLabel = (type: string) => {
    const types = {
      monthly: 'Mensual',
      weekly: 'Semanal',
      custom: 'Personalizado',
      incident_summary: 'Resumen de Incidencias'
    };
    return types[type as keyof typeof types] || type;
  };

  const handleCreateReport = () => {
    setCreateDialogOpen(true);
  };

  const handleReportCreated = () => {
    refetch();
  };

  const isValidUrl = (url: string | null | undefined): url is string => {
    if (!url) return false;
    // Verificar que no sea una URL de ejemplo
    if (url.includes('example')) return false;
    try {
      new URL(url);
      return true;
    } catch {
      return false;
    }
  };

  const handleLinkClick = (url: string | null | undefined, type: string) => {
    if (!isValidUrl(url)) {
      toast.error(`El enlace para ${type} no está disponible aún. El reporte puede estar siendo procesado.`);
      return;
    }
    window.open(url, '_blank', 'noopener,noreferrer');
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4">
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
                <h1 className="text-3xl font-bold">Reportes Generados</h1>
                <p className="text-white/90">
                  Visualiza y gestiona todos los reportes del sistema
                </p>
              </div>
            </div>
            <Button 
              onClick={handleCreateReport}
              className="bg-white/20 hover:bg-white/30 text-white border border-white/30"
            >
              <Plus className="w-4 h-4 mr-2" />
              Crear Reporte
            </Button>
          </div>
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
                <label className="text-sm font-medium mb-2 block">Tipo de Reporte</label>
                <Select value={selectedType} onValueChange={setSelectedType}>
                  <SelectTrigger>
                    <SelectValue placeholder="Todos los tipos" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">Todos los tipos</SelectItem>
                    <SelectItem value="monthly">Mensual</SelectItem>
                    <SelectItem value="weekly">Semanal</SelectItem>
                    <SelectItem value="custom">Personalizado</SelectItem>
                    <SelectItem value="incident_summary">Resumen de Incidencias</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              
              <div className="min-w-[200px]">
                <label className="text-sm font-medium mb-2 block">Estado</label>
                <Select value={selectedStatus} onValueChange={setSelectedStatus}>
                  <SelectTrigger>
                    <SelectValue placeholder="Todos los estados" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">Todos los estados</SelectItem>
                    <SelectItem value="generating">Generando</SelectItem>
                    <SelectItem value="completed">Completado</SelectItem>
                    <SelectItem value="failed">Error</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="flex items-end">
                <Button onClick={() => refetch()} variant="outline">
                  Actualizar
                </Button>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Reports List */}
        <Card className="bg-white/95 backdrop-blur-sm">
          <CardHeader>
            <CardTitle>Lista de Reportes</CardTitle>
            <CardDescription>
              {reports?.length || 0} reporte(s) encontrado(s)
            </CardDescription>
          </CardHeader>
          <CardContent>
            {isLoading ? (
              <div className="flex items-center justify-center py-8">
                <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
                <span className="ml-2">Cargando reportes...</span>
              </div>
            ) : reports && reports.length > 0 ? (
              <div className="space-y-4">
                {reports.map((report) => (
                  <div key={report.id} className="border rounded-lg p-4 hover:bg-gray-50 transition-colors">
                    <div className="flex items-start justify-between">
                      <div className="flex-1">
                        <div className="flex items-center gap-3 mb-2">
                          <FileText className="h-5 w-5 text-primary" />
                          <h3 className="text-lg font-semibold">{report.title}</h3>
                          {getStatusBadge(report.status)}
                        </div>
                        
                        <p className="text-gray-600 mb-2">{report.description}</p>
                        
                        <div className="flex items-center gap-4 text-sm text-gray-500">
                          <div className="flex items-center gap-1">
                            <Calendar className="h-4 w-4" />
                            {format(new Date(report.created_at), 'dd/MM/yyyy HH:mm', { locale: es })}
                          </div>
                          <div>
                            <strong>Tipo:</strong> {getReportTypeLabel(report.report_type)}
                          </div>
                          {report.date_range_start && report.date_range_end && (
                            <div>
                              <strong>Período:</strong> {format(new Date(report.date_range_start), 'dd/MM/yyyy', { locale: es })} - {format(new Date(report.date_range_end), 'dd/MM/yyyy', { locale: es })}
                            </div>
                          )}
                        </div>
                      </div>
                      
                      {report.status === 'completed' && (
                        <div className="flex gap-2">
                          <Button 
                            size="sm" 
                            variant="outline" 
                            onClick={() => handleLinkClick(report.google_sheets_url, 'datos')}
                            disabled={!isValidUrl(report.google_sheets_url)}
                            className={!isValidUrl(report.google_sheets_url) ? 'opacity-50 cursor-not-allowed' : ''}
                          >
                            <Eye className="w-4 h-4 mr-1" />
                            Ver Datos
                            {isValidUrl(report.google_sheets_url) && <ExternalLink className="w-3 h-3 ml-1" />}
                          </Button>
                          <Button 
                            size="sm" 
                            variant="outline" 
                            onClick={() => handleLinkClick(report.google_chart_url, 'gráficos')}
                            disabled={!isValidUrl(report.google_chart_url)}
                            className={!isValidUrl(report.google_chart_url) ? 'opacity-50 cursor-not-allowed' : ''}
                          >
                            <BarChart3 className="w-4 h-4 mr-1" />
                            Ver Gráficos
                            {isValidUrl(report.google_chart_url) && <ExternalLink className="w-3 h-3 ml-1" />}
                          </Button>
                          <Button 
                            size="sm" 
                            variant="outline" 
                            onClick={() => handleLinkClick(report.pdf_url, 'PDF')}
                            disabled={!isValidUrl(report.pdf_url)}
                            className={!isValidUrl(report.pdf_url) ? 'opacity-50 cursor-not-allowed' : ''}
                          >
                            <Download className="w-4 h-4 mr-1" />
                            Descargar PDF
                            {isValidUrl(report.pdf_url) && <ExternalLink className="w-3 h-3 ml-1" />}
                          </Button>
                        </div>
                      )}
                      
                      {report.status === 'generating' && (
                        <div className="flex items-center gap-2 text-sm text-gray-500">
                          <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-primary"></div>
                          <span>Procesando reporte...</span>
                        </div>
                      )}

                      {report.status === 'failed' && (
                        <div className="flex items-center gap-2 text-sm text-red-500">
                          <span>Error al generar el reporte</span>
                        </div>
                      )}
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <div className="text-center py-8">
                <FileText className="h-12 w-12 text-gray-400 mx-auto mb-4" />
                <p className="text-gray-500">No se encontraron reportes</p>
                <p className="text-sm text-gray-400 mt-1">
                  Los reportes aparecerán aquí una vez que sean generados
                </p>
              </div>
            )}
          </CardContent>
        </Card>

        <CreateReportDialog
          open={createDialogOpen}
          onOpenChange={setCreateDialogOpen}
          onReportCreated={handleReportCreated}
        />
      </div>
    </div>
  );
};

export default Reports;
