
import { useState } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Badge } from "@/components/ui/badge";
import { LifeBuoy, ArrowLeft, MessageCircle, Clock, CheckCircle, AlertCircle, Send } from "lucide-react";
import { Link } from "react-router-dom";
import { useHelpMessages } from "@/hooks/useHelpMessages";
import { useToast } from "@/hooks/use-toast";
import { format } from 'date-fns';
import { es } from 'date-fns/locale';

const HelpSupport = () => {
  const [subject, setSubject] = useState("");
  const [message, setMessage] = useState("");
  const [priority, setPriority] = useState("normal");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const { messages, loading, createHelpMessage, refetch } = useHelpMessages();
  const { toast } = useToast();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!subject.trim() || !message.trim()) {
      toast({
        title: "Campos requeridos",
        description: "Por favor completa el asunto y el mensaje.",
        variant: "destructive",
      });
      return;
    }

    setIsSubmitting(true);
    
    try {
      await createHelpMessage({
        subject: subject.trim(),
        message: message.trim(),
        priority,
      });

      toast({
        title: "✅ Mensaje enviado",
        description: "Tu consulta ha sido enviada exitosamente. Te responderemos pronto.",
      });

      // Clear form
      setSubject("");
      setMessage("");
      setPriority("normal");
      
      // Refresh messages
      refetch();

    } catch (error) {
      console.error('Error sending help message:', error);
      toast({
        title: "Error al enviar mensaje",
        description: error instanceof Error ? error.message : "Inténtalo nuevamente.",
        variant: "destructive",
      });
    } finally {
      setIsSubmitting(false);
    }
  };

  const getStatusBadge = (status: string) => {
    switch (status) {
      case 'pending':
        return <Badge variant="secondary" className="bg-yellow-100 text-yellow-800"><Clock className="h-3 w-3 mr-1" />Pendiente</Badge>;
      case 'in_progress':
        return <Badge variant="secondary" className="bg-blue-100 text-blue-800"><AlertCircle className="h-3 w-3 mr-1" />En progreso</Badge>;
      case 'resolved':
        return <Badge variant="secondary" className="bg-green-100 text-green-800"><CheckCircle className="h-3 w-3 mr-1" />Resuelto</Badge>;
      default:
        return <Badge variant="secondary">{status}</Badge>;
    }
  };

  const getPriorityBadge = (priority: string) => {
    switch (priority) {
      case 'high':
        return <Badge variant="destructive">Alta</Badge>;
      case 'normal':
        return <Badge variant="outline">Normal</Badge>;
      case 'low':
        return <Badge variant="secondary">Baja</Badge>;
      default:
        return <Badge variant="outline">{priority}</Badge>;
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-purple-50 p-4">
      <div className="max-w-4xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4 text-gray-800 mb-6">
          <Link to="/" className="p-2 hover:bg-white/50 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-3xl font-bold">Ayuda y Soporte</h1>
            <p className="text-gray-600">Envía tus consultas y reporta problemas</p>
          </div>
        </div>

        {/* Contact Form */}
        <Card className="shadow-lg">
          <CardHeader>
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center">
                <LifeBuoy className="h-6 w-6 text-blue-600" />
              </div>
              <div>
                <CardTitle className="text-xl">Contactar Soporte</CardTitle>
                <CardDescription>
                  Describe tu problema o consulta y te ayudaremos lo antes posible
                </CardDescription>
              </div>
            </div>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleSubmit} className="space-y-6">
              <div className="grid gap-4 md:grid-cols-2">
                <div className="space-y-2">
                  <Label htmlFor="subject">Asunto *</Label>
                  <Input
                    id="subject"
                    placeholder="Describe brevemente tu consulta..."
                    value={subject}
                    onChange={(e) => setSubject(e.target.value)}
                    required
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="priority">Prioridad</Label>
                  <Select value={priority} onValueChange={setPriority}>
                    <SelectTrigger>
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="low">Baja</SelectItem>
                      <SelectItem value="normal">Normal</SelectItem>
                      <SelectItem value="high">Alta</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>

              <div className="space-y-2">
                <Label htmlFor="message">Mensaje *</Label>
                <Textarea
                  id="message"
                  placeholder="Describe tu problema o consulta en detalle..."
                  className="min-h-[120px]"
                  value={message}
                  onChange={(e) => setMessage(e.target.value)}
                  required
                />
              </div>

              <Button
                type="submit"
                disabled={isSubmitting}
                className="w-full h-12 bg-blue-600 hover:bg-blue-700 text-white font-semibold"
              >
                {isSubmitting ? (
                  <>
                    <div className="animate-spin rounded-full h-5 w-5 border-b-2 border-white mr-3"></div>
                    Enviando...
                  </>
                ) : (
                  <>
                    <Send className="h-5 w-5 mr-3" />
                    Enviar Mensaje
                  </>
                )}
              </Button>
            </form>
          </CardContent>
        </Card>

        {/* Message History */}
        <Card className="shadow-lg">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <MessageCircle className="h-5 w-5" />
              Historial de Consultas
            </CardTitle>
            <CardDescription>
              Revisa el estado de tus consultas anteriores
            </CardDescription>
          </CardHeader>
          <CardContent>
            {loading ? (
              <div className="flex justify-center py-8">
                <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
              </div>
            ) : messages.length > 0 ? (
              <div className="space-y-4">
                {messages.map((msg) => (
                  <div key={msg.id} className="p-4 border rounded-lg hover:bg-gray-50 transition-colors">
                    <div className="flex items-start justify-between mb-3">
                      <div className="flex-1">
                        <h3 className="font-semibold text-gray-900 mb-1">{msg.subject}</h3>
                        <div className="flex items-center gap-2 text-sm text-gray-500">
                          <span>{format(new Date(msg.created_at), 'dd/MM/yyyy HH:mm', { locale: es })}</span>
                        </div>
                      </div>
                      <div className="flex items-center gap-2">
                        {getPriorityBadge(msg.priority)}
                        {getStatusBadge(msg.status)}
                      </div>
                    </div>
                    
                    <p className="text-gray-700 mb-3 line-clamp-3">{msg.message}</p>
                    
                    {msg.admin_response && (
                      <div className="mt-3 p-3 bg-blue-50 rounded-lg border-l-4 border-blue-400">
                        <div className="flex items-center gap-2 mb-2">
                          <MessageCircle className="h-4 w-4 text-blue-600" />
                          <span className="text-sm font-medium text-blue-800">Respuesta del equipo:</span>
                        </div>
                        <p className="text-blue-700 text-sm">{msg.admin_response}</p>
                        {msg.resolved_at && (
                          <p className="text-xs text-blue-600 mt-2">
                            Resuelto el {format(new Date(msg.resolved_at), 'dd/MM/yyyy HH:mm', { locale: es })}
                          </p>
                        )}
                      </div>
                    )}
                  </div>
                ))}
              </div>
            ) : (
              <div className="text-center py-8">
                <MessageCircle className="h-12 w-12 text-gray-400 mx-auto mb-4" />
                <p className="text-gray-500">No tienes consultas anteriores</p>
                <p className="text-sm text-gray-400">Cuando envíes una consulta, aparecerá aquí</p>
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default HelpSupport;
