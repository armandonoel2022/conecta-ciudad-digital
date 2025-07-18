import { useState } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Download, Eye, MessageSquare, User, Calendar, FileText, Phone, Mail } from "lucide-react";
import { useJobApplications } from "@/hooks/useJobApplications";
import { supabase } from "@/integrations/supabase/client";
import { useToast } from "@/hooks/use-toast";
import { useAuth } from "@/hooks/useAuth";

type ApplicationStatus = 'pending' | 'in_process' | 'accepted' | 'declined';

const statusConfig = {
  pending: { label: 'Pendiente', color: 'bg-yellow-100 text-yellow-800' },
  in_process: { label: 'En proceso', color: 'bg-blue-100 text-blue-800' },
  accepted: { label: 'Solicitud aceptada', color: 'bg-green-100 text-green-800' },
  declined: { label: 'Solicitud declinada', color: 'bg-red-100 text-red-800' }
};

export const JobApplicationsManagement = () => {
  const { applications, isLoading, createApplication } = useJobApplications();
  const [selectedApp, setSelectedApp] = useState<any>(null);
  const [responseText, setResponseText] = useState('');
  const [newStatus, setNewStatus] = useState<ApplicationStatus>('pending');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const { toast } = useToast();
  const { user } = useAuth();

  const handleStatusUpdate = async (applicationId: string) => {
    if (!user || !responseText.trim()) {
      toast({
        title: "Error",
        description: "La respuesta es obligatoria",
        variant: "destructive"
      });
      return;
    }

    setIsSubmitting(true);
    try {
      const { error } = await supabase
        .from('job_applications')
        .update({
          status: newStatus,
          admin_response: responseText.trim(),
          responded_at: new Date().toISOString(),
          responded_by: user.id
        })
        .eq('id', applicationId);

      if (error) throw error;

      toast({
        title: "Respuesta enviada",
        description: "La respuesta ha sido enviada al solicitante",
      });

      setSelectedApp(null);
      setResponseText('');
      setNewStatus('pending');
      
      // Refrescar datos
      window.location.reload();
    } catch (error) {
      console.error('Error updating application:', error);
      toast({
        title: "Error",
        description: "No se pudo enviar la respuesta",
        variant: "destructive"
      });
    } finally {
      setIsSubmitting(false);
    }
  };

  const downloadCV = async (cvUrl: string, fileName: string) => {
    try {
      const response = await fetch(cvUrl);
      const blob = await response.blob();
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.style.display = 'none';
      a.href = url;
      a.download = fileName;
      document.body.appendChild(a);
      a.click();
      window.URL.revokeObjectURL(url);
      document.body.removeChild(a);
    } catch (error) {
      toast({
        title: "Error",
        description: "No se pudo descargar el archivo",
        variant: "destructive"
      });
    }
  };

  if (isLoading) {
    return <div>Cargando solicitudes...</div>;
  }

  if (!applications || applications.length === 0) {
    return (
      <div className="text-center py-8">
        <FileText className="h-12 w-12 text-gray-400 mx-auto mb-4" />
        <h3 className="text-lg font-medium text-gray-900 mb-2">No hay solicitudes</h3>
        <p className="text-gray-500">No se han recibido solicitudes de empleo aún.</p>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="grid gap-4">
        {applications.map((application) => (
          <Card key={application.id} className="border-l-4 border-l-primary">
            <CardHeader>
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <User className="h-5 w-5 text-gray-600" />
                  <div>
                    <CardTitle className="text-lg">{application.full_name}</CardTitle>
                    <CardDescription className="flex items-center gap-4 mt-1">
                      <span className="flex items-center gap-1">
                        <Mail className="h-4 w-4" />
                        {application.email}
                      </span>
                      <span className="flex items-center gap-1">
                        <Phone className="h-4 w-4" />
                        {application.phone}
                      </span>
                    </CardDescription>
                  </div>
                </div>
                <Badge className={statusConfig[application.status as ApplicationStatus]?.color}>
                  {statusConfig[application.status as ApplicationStatus]?.label}
                </Badge>
              </div>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid md:grid-cols-2 gap-4 text-sm">
                <div>
                  <p><strong>Área:</strong> {application.career_field || 'No especificada'}</p>
                  <p><strong>Educación:</strong> {application.education_level}</p>
                  <p><strong>Institución:</strong> {application.institution_name || 'No especificada'}</p>
                </div>
                <div>
                  <p><strong>Experiencia:</strong> {application.work_experience ? 'Sí' : 'Sin experiencia'}</p>
                  <p><strong>Disponibilidad:</strong> {application.availability || 'No especificada'}</p>
                  <p className="flex items-center gap-1">
                    <Calendar className="h-4 w-4" />
                    <strong>Enviada:</strong> {new Date(application.created_at!).toLocaleDateString('es-DO')}
                  </p>
                </div>
              </div>

              {application.skills && (
                <div>
                  <p className="text-sm"><strong>Habilidades:</strong></p>
                  <p className="text-sm text-gray-600">{application.skills}</p>
                </div>
              )}

              {application.admin_response && (
                <div className="bg-blue-50 p-3 rounded-lg">
                  <p className="text-sm"><strong>Respuesta enviada:</strong></p>
                  <p className="text-sm text-gray-700">{application.admin_response}</p>
                  <p className="text-xs text-gray-500 mt-1">
                    Respondido el: {new Date(application.responded_at!).toLocaleDateString('es-DO')}
                  </p>
                </div>
              )}

              <div className="flex gap-2 flex-wrap">
                {application.cv_file_url && (
                  <>
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={() => downloadCV(application.cv_file_url!, application.cv_file_name!)}
                    >
                      <Download className="h-4 w-4 mr-2" />
                      Descargar CV
                    </Button>
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={() => window.open(application.cv_file_url!, '_blank')}
                    >
                      <Eye className="h-4 w-4 mr-2" />
                      Ver CV
                    </Button>
                  </>
                )}
                
                <Dialog>
                  <DialogTrigger asChild>
                    <Button
                      variant="default"
                      size="sm"
                      onClick={() => {
                        setSelectedApp(application);
                        setNewStatus(application.status as ApplicationStatus);
                        setResponseText(application.admin_response || '');
                      }}
                    >
                      <MessageSquare className="h-4 w-4 mr-2" />
                      Responder
                    </Button>
                  </DialogTrigger>
                  <DialogContent className="max-w-2xl">
                    <DialogHeader>
                      <DialogTitle>Responder a {application.full_name}</DialogTitle>
                      <DialogDescription>
                        Envía una respuesta y actualiza el estado de la solicitud
                      </DialogDescription>
                    </DialogHeader>
                    <div className="space-y-4 py-4">
                      <div>
                        <label className="text-sm font-medium">Estado de la solicitud</label>
                        <Select value={newStatus} onValueChange={(value: ApplicationStatus) => setNewStatus(value)}>
                          <SelectTrigger>
                            <SelectValue />
                          </SelectTrigger>
                          <SelectContent>
                            <SelectItem value="pending">Pendiente</SelectItem>
                            <SelectItem value="in_process">En proceso</SelectItem>
                            <SelectItem value="accepted">Solicitud aceptada</SelectItem>
                            <SelectItem value="declined">Solicitud declinada</SelectItem>
                          </SelectContent>
                        </Select>
                      </div>
                      
                      <div>
                        <label className="text-sm font-medium">Respuesta al solicitante</label>
                        <Textarea
                          placeholder="Escribe tu respuesta aquí..."
                          value={responseText}
                          onChange={(e) => setResponseText(e.target.value)}
                          rows={4}
                          className="mt-1"
                        />
                      </div>
                      
                      <div className="flex justify-end gap-2">
                        <Button variant="outline" onClick={() => setSelectedApp(null)}>
                          Cancelar
                        </Button>
                        <Button 
                          onClick={() => handleStatusUpdate(application.id)}
                          disabled={isSubmitting || !responseText.trim()}
                        >
                          {isSubmitting ? 'Enviando...' : 'Enviar respuesta'}
                        </Button>
                      </div>
                    </div>
                  </DialogContent>
                </Dialog>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  );
};