import { useState, useEffect } from "react";
import { useParams, Link, useNavigate } from "react-router-dom";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { ArrowLeft, FileText, MapPin, Calendar, User, MessageSquare, Upload, Image as ImageIcon } from "lucide-react";
import { format } from "date-fns";
import { es } from "date-fns/locale";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/hooks/useAuth";
import { useUserRoles } from "@/hooks/useUserRoles";
import { useToast } from "@/hooks/use-toast";

interface Report {
  id: string;
  title: string;
  description: string;
  category: string;
  status: string;
  created_at: string;
  updated_at: string;
  resolved_at: string | null;
  address: string | null;
  neighborhood: string | null;
  priority: string | null;
  resolution_notes: string | null;
  image_url: string | null;
  user_id: string;
}

interface Profile {
  full_name: string | null;
  first_name: string | null;
  last_name: string | null;
  phone: string | null;
}

const ReportDetails = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { user } = useAuth();
  const { isAdmin, isCommunityLeader } = useUserRoles();
  const { toast } = useToast();
  
  const [report, setReport] = useState<Report | null>(null);
  const [reporterProfile, setReporterProfile] = useState<Profile | null>(null);
  const [loading, setLoading] = useState(true);
  const [updating, setUpdating] = useState(false);
  
  // Admin fields
  const [newStatus, setNewStatus] = useState<string>("");
  const [newPriority, setNewPriority] = useState<string>("");
  const [resolutionNotes, setResolutionNotes] = useState<string>("");

  useEffect(() => {
    if (id) {
      fetchReport();
    }
  }, [id]);

  const fetchReport = async () => {
    try {
      setLoading(true);
      
      // Fetch report
      const { data: reportData, error: reportError } = await supabase
        .from('reports')
        .select('*')
        .eq('id', id)
        .single();

      if (reportError) throw reportError;

      setReport(reportData);
      setNewStatus(reportData.status);
      setNewPriority(reportData.priority || "media");
      setResolutionNotes(reportData.resolution_notes || "");

      // Fetch reporter profile
      const { data: profileData, error: profileError } = await supabase
        .from('profiles')
        .select('full_name, first_name, last_name, phone')
        .eq('id', reportData.user_id)
        .single();

      if (profileError) {
        console.error('Error fetching profile:', profileError);
      } else {
        setReporterProfile(profileData);
      }
    } catch (error) {
      console.error('Error fetching report:', error);
      toast({
        title: "Error",
        description: "No se pudo cargar el reporte",
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };

  const updateReport = async () => {
    if (!report || !user) return;

    try {
      setUpdating(true);
      
      const updateData: any = {
        status: newStatus,
        priority: newPriority,
        resolution_notes: resolutionNotes,
        updated_at: new Date().toISOString()
      };

      if (newStatus === 'resuelto' && report.status !== 'resuelto') {
        updateData.resolved_at = new Date().toISOString();
      }

      const { error } = await supabase
        .from('reports')
        .update(updateData)
        .eq('id', report.id);

      if (error) throw error;

      toast({
        title: "Éxito",
        description: "Reporte actualizado correctamente"
      });
      
      fetchReport(); // Refresh data
    } catch (error) {
      console.error('Error updating report:', error);
      toast({
        title: "Error",
        description: "No se pudo actualizar el reporte",
        variant: "destructive"
      });
    } finally {
      setUpdating(false);
    }
  };

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
      basura: 'Basura y Limpieza',
      iluminacion: 'Iluminación Pública',
      baches: 'Baches y Pavimento',
      seguridad: 'Seguridad Ciudadana',
      otros: 'Otros'
    };
    return categories[category as keyof typeof categories] || category;
  };

  const canEditReport = isAdmin || isCommunityLeader;
  const isOwner = user?.id === report?.user_id;

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 flex items-center justify-center">
        <div className="bg-white/10 backdrop-blur-sm p-8 rounded-2xl">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-white mx-auto"></div>
          <p className="text-white mt-4">Cargando reporte...</p>
        </div>
      </div>
    );
  }

  if (!report) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 flex items-center justify-center">
        <Card className="bg-white/95 backdrop-blur-sm max-w-md">
          <CardHeader>
            <CardTitle className="text-red-600">Reporte no encontrado</CardTitle>
          </CardHeader>
          <CardContent>
            <p>El reporte que buscas no existe o no tienes permisos para verlo.</p>
            <Button asChild className="mt-4">
              <Link to="/mis-reportes">Volver a Mis Reportes</Link>
            </Button>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 animate-fade-in">
      <div className="max-w-4xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-4">
          <Button 
            variant="ghost" 
            size="sm"
            asChild
            className="p-2 hover:bg-white/20 rounded-xl transition-colors text-white hover:text-white"
          >
            <Link to="/mis-reportes">
              <ArrowLeft className="h-6 w-6" />
            </Link>
          </Button>
          <div>
            <h1 className="text-2xl font-bold">DETALLES DEL REPORTE</h1>
            <p className="text-white/80">Información completa del reporte</p>
          </div>
        </div>

        {/* Report Details Card */}
        <Card className="bg-white/95 backdrop-blur-sm">
          <CardHeader>
            <div className="flex items-start justify-between">
              <div className="flex-1">
                <CardTitle className="flex items-center gap-3 mb-2">
                  <FileText className="h-6 w-6 text-primary" />
                  {report.title}
                </CardTitle>
                <div className="flex items-center gap-3 flex-wrap">
                  {getStatusBadge(report.status)}
                  <Badge variant="outline">{getCategoryLabel(report.category)}</Badge>
                  {report.priority && (
                    <Badge variant="secondary">
                      Prioridad: {report.priority.charAt(0).toUpperCase() + report.priority.slice(1)}
                    </Badge>
                  )}
                </div>
              </div>
            </div>
          </CardHeader>
          <CardContent className="space-y-6">
            {/* Description */}
            <div>
              <h3 className="font-semibold text-gray-800 mb-2">Descripción</h3>
              <p className="text-gray-600 bg-gray-50 p-4 rounded-lg">{report.description}</p>
            </div>

            {/* Image */}
            {report.image_url && (
              <div>
                <h3 className="font-semibold text-gray-800 mb-2 flex items-center gap-2">
                  <ImageIcon className="h-4 w-4" />
                  Imagen del Reporte
                </h3>
                <img 
                  src={report.image_url} 
                  alt="Imagen del reporte" 
                  className="max-w-full h-auto rounded-lg border"
                />
              </div>
            )}

            {/* Location & Date Info */}
            <div className="grid md:grid-cols-2 gap-6">
              <div>
                <h3 className="font-semibold text-gray-800 mb-3">Información de Ubicación</h3>
                <div className="space-y-2">
                  {report.address && (
                    <div className="flex items-center gap-2 text-sm text-gray-600">
                      <MapPin className="h-4 w-4" />
                      {report.address}
                    </div>
                  )}
                  {report.neighborhood && (
                    <div className="text-sm text-gray-600">
                      <strong>Barrio:</strong> {report.neighborhood}
                    </div>
                  )}
                </div>
              </div>

              <div>
                <h3 className="font-semibold text-gray-800 mb-3">Fechas Importantes</h3>
                <div className="space-y-2">
                  <div className="flex items-center gap-2 text-sm text-gray-600">
                    <Calendar className="h-4 w-4" />
                    <span><strong>Creado:</strong> {format(new Date(report.created_at), 'dd/MM/yyyy HH:mm', { locale: es })}</span>
                  </div>
                  {report.updated_at && report.updated_at !== report.created_at && (
                    <div className="text-sm text-gray-600">
                      <strong>Actualizado:</strong> {format(new Date(report.updated_at), 'dd/MM/yyyy HH:mm', { locale: es })}
                    </div>
                  )}
                  {report.resolved_at && (
                    <div className="text-sm text-green-600">
                      <strong>Resuelto:</strong> {format(new Date(report.resolved_at), 'dd/MM/yyyy HH:mm', { locale: es })}
                    </div>
                  )}
                </div>
              </div>
            </div>

            {/* Reporter Info */}
            {reporterProfile && (isAdmin || isCommunityLeader) && (
              <div>
                <h3 className="font-semibold text-gray-800 mb-3 flex items-center gap-2">
                  <User className="h-4 w-4" />
                  Información del Reportante
                </h3>
                <div className="bg-gray-50 p-4 rounded-lg">
                  <div className="grid md:grid-cols-2 gap-4 text-sm">
                    <div>
                      <strong>Nombre:</strong> {reporterProfile.full_name || `${reporterProfile.first_name} ${reporterProfile.last_name}`}
                    </div>
                    {reporterProfile.phone && (
                      <div>
                        <strong>Teléfono:</strong> {reporterProfile.phone}
                      </div>
                    )}
                  </div>
                </div>
              </div>
            )}

            {/* Resolution Notes */}
            {report.resolution_notes && (
              <div>
                <h3 className="font-semibold text-gray-800 mb-2 flex items-center gap-2">
                  <MessageSquare className="h-4 w-4" />
                  Notas de Resolución
                </h3>
                <p className="text-gray-600 bg-green-50 p-4 rounded-lg border-l-4 border-green-400">
                  {report.resolution_notes}
                </p>
              </div>
            )}

            {/* Admin Controls - Only show in management context, not in user's own reports */}
            {canEditReport && !isOwner && (
              <div className="border-t pt-6">
                <h3 className="font-semibold text-gray-800 mb-4">Gestión Administrativa</h3>
                <div className="space-y-4">
                  <div className="grid md:grid-cols-2 gap-4">
                    <div>
                      <label className="block text-sm font-medium mb-2">Estado del Reporte</label>
                      <Select value={newStatus} onValueChange={setNewStatus}>
                        <SelectTrigger>
                          <SelectValue />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="pendiente">Pendiente</SelectItem>
                          <SelectItem value="en_proceso">En Proceso</SelectItem>
                          <SelectItem value="resuelto">Resuelto</SelectItem>
                          <SelectItem value="rechazado">Rechazado</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                    
                    <div>
                      <label className="block text-sm font-medium mb-2">Prioridad</label>
                      <Select value={newPriority} onValueChange={setNewPriority}>
                        <SelectTrigger>
                          <SelectValue />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="baja">Baja</SelectItem>
                          <SelectItem value="media">Media</SelectItem>
                          <SelectItem value="alta">Alta</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                  </div>

                  <div>
                    <label className="block text-sm font-medium mb-2">Notas de Resolución</label>
                    <Textarea
                      value={resolutionNotes}
                      onChange={(e) => setResolutionNotes(e.target.value)}
                      placeholder="Agrega comentarios sobre la resolución del reporte..."
                      rows={4}
                    />
                  </div>

                  <Button 
                    onClick={updateReport}
                    disabled={updating}
                    className="w-full md:w-auto"
                  >
                    {updating ? 'Actualizando...' : 'Actualizar Reporte'}
                  </Button>
                </div>
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default ReportDetails;