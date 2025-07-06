import { useState } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Calendar } from "@/components/ui/calendar";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import { Badge } from "@/components/ui/badge";
import { AlertTriangle, Upload, Calendar as CalendarIcon, MessageSquare, Image, Clock, Send, Trash2, Edit, MapPin } from "lucide-react";
import { useCommunityMessages } from '@/hooks/useCommunityMessages';
import { useToast } from '@/hooks/use-toast';
import { format } from 'date-fns';
import { es } from 'date-fns/locale';
import { cn } from "@/lib/utils";

const CommunityMessages = () => {
  const [showCreateForm, setShowCreateForm] = useState(false);
  const [editingMessage, setEditingMessage] = useState<string | null>(null);
  const [formData, setFormData] = useState({
    title: '',
    message: '',
    sector: '',
    municipality: '',
    province: '',
    scheduled_at: ''
  });
  const [imageFile, setImageFile] = useState<File | null>(null);
  const [imagePreview, setImagePreview] = useState<string | null>(null);
  const [selectedDate, setSelectedDate] = useState<Date>();
  const [selectedTime, setSelectedTime] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);

  const { 
    messages, 
    weeklyLimit, 
    loading, 
    createMessage, 
    updateMessage, 
    deleteMessage, 
    uploadImage, 
    canSendMessage, 
    getRemainingMessages 
  } = useCommunityMessages();
  const { toast } = useToast();

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const handleSelectChange = (name: string, value: string) => {
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      setImageFile(file);
      const reader = new FileReader();
      reader.onload = () => {
        setImagePreview(reader.result as string);
      };
      reader.readAsDataURL(file);
    }
  };

  const handleDateTimeChange = () => {
    if (selectedDate && selectedTime) {
      const [hours, minutes] = selectedTime.split(':');
      const scheduledDate = new Date(selectedDate);
      scheduledDate.setHours(parseInt(hours), parseInt(minutes));
      setFormData(prev => ({ ...prev, scheduled_at: scheduledDate.toISOString() }));
    } else {
      setFormData(prev => ({ ...prev, scheduled_at: '' }));
    }
  };

  const resetForm = () => {
    setFormData({
      title: '',
      message: '',
      sector: '',
      municipality: '',
      province: '',
      scheduled_at: ''
    });
    setImageFile(null);
    setImagePreview(null);
    setSelectedDate(undefined);
    setSelectedTime('');
    setShowCreateForm(false);
    setEditingMessage(null);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!formData.title.trim() || !formData.message.trim() || !formData.municipality.trim() || !formData.province.trim()) {
      toast({
        title: "Campos requeridos",
        description: "Por favor completa todos los campos obligatorios.",
        variant: "destructive",
      });
      return;
    }

    if (!canSendMessage()) {
      toast({
        title: "Límite semanal alcanzado",
        description: "Has alcanzado el límite de 3 mensajes por semana.",
        variant: "destructive",
      });
      return;
    }

    try {
      setIsSubmitting(true);
      
      let image_url = '';
      if (imageFile) {
        image_url = await uploadImage(imageFile);
      }

      const messageData = {
        ...formData,
        image_url: image_url || undefined
      };

      if (editingMessage) {
        await updateMessage(editingMessage, messageData);
        toast({
          title: "¡Mensaje actualizado!",
          description: "El mensaje comunitario ha sido actualizado exitosamente.",
        });
      } else {
        await createMessage(messageData);
        toast({
          title: "¡Mensaje creado!",
          description: "El mensaje comunitario ha sido enviado exitosamente.",
        });
      }

      resetForm();
    } catch (error: any) {
      toast({
        title: "Error",
        description: error.message || "No se pudo procesar el mensaje. Inténtalo nuevamente.",
        variant: "destructive",
      });
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleEdit = (message: any) => {
    setFormData({
      title: message.title,
      message: message.message,
      sector: message.sector || '',
      municipality: message.municipality,
      province: message.province,
      scheduled_at: message.scheduled_at || ''
    });
    
    if (message.scheduled_at) {
      const scheduledDate = new Date(message.scheduled_at);
      setSelectedDate(scheduledDate);
      setSelectedTime(format(scheduledDate, 'HH:mm'));
    }

    if (message.image_url) {
      setImagePreview(message.image_url);
    }

    setEditingMessage(message.id);
    setShowCreateForm(true);
  };

  const handleDelete = async (id: string) => {
    if (window.confirm('¿Estás seguro de que quieres eliminar este mensaje?')) {
      try {
        await deleteMessage(id);
        toast({
          title: "Mensaje eliminado",
          description: "El mensaje ha sido eliminado exitosamente.",
        });
      } catch (error) {
        toast({
          title: "Error",
          description: "No se pudo eliminar el mensaje.",
          variant: "destructive",
        });
      }
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 animate-fade-in">
      <div className="max-w-6xl mx-auto space-y-6">
        {/* Header */}
        <div className="text-center text-white mb-8">
          <h1 className="text-3xl font-bold mb-2">Mensajes Comunitarios</h1>
          <p className="text-white/80">Panel para líderes comunitarios</p>
        </div>

        {/* Weekly Limit Info */}
        <Card className="bg-white/95 backdrop-blur-sm shadow-xl">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <MessageSquare className="h-5 w-5 text-primary" />
              Estado Semanal
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-gray-600">Mensajes enviados esta semana:</p>
                <p className="text-2xl font-bold text-primary">{weeklyLimit?.message_count || 0} / 3</p>
              </div>
              <div className="text-right">
                <p className="text-sm text-gray-600">Mensajes restantes:</p>
                <p className="text-lg font-semibold text-green-600">{getRemainingMessages()}</p>
              </div>
            </div>
            <div className="mt-4">
              <div className="bg-gray-200 h-2 rounded-full">
                <div 
                  className="bg-primary h-2 rounded-full transition-all duration-300"
                  style={{ width: `${((weeklyLimit?.message_count || 0) / 3) * 100}%` }}
                />
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Create Message Button */}
        <div className="flex justify-center">
          <Button 
            onClick={() => setShowCreateForm(!showCreateForm)}
            disabled={!canSendMessage()}
            className="bg-white text-primary hover:bg-white/90 font-bold py-3 px-6 text-lg rounded-xl shadow-lg"
          >
            <MessageSquare className="h-5 w-5 mr-2" />
            {showCreateForm ? 'Cancelar' : 'Crear Nuevo Mensaje'}
          </Button>
        </div>

        {/* Create/Edit Form */}
        {showCreateForm && (
          <Card className="bg-white/95 backdrop-blur-sm shadow-xl">
            <CardHeader>
              <CardTitle className="text-primary">
                {editingMessage ? 'Editar Mensaje' : 'Crear Mensaje Comunitario'}
              </CardTitle>
              <CardDescription>
                Envía un mensaje a tu comunidad con información importante
              </CardDescription>
            </CardHeader>
            <CardContent>
              <form onSubmit={handleSubmit} className="space-y-6">
                {/* Basic Info */}
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label htmlFor="title">Título del mensaje *</Label>
                    <Input
                      id="title"
                      name="title"
                      placeholder="Ej: Corte de agua programado"
                      value={formData.title}
                      onChange={handleInputChange}
                      required
                    />
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="sector">Sector (opcional)</Label>
                    <Input
                      id="sector"
                      name="sector"
                      placeholder="Ej: Sector 7"
                      value={formData.sector}
                      onChange={handleInputChange}
                    />
                  </div>
                </div>

                {/* Location */}
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label htmlFor="municipality">Municipio *</Label>
                    <Select onValueChange={(value) => handleSelectChange('municipality', value)} value={formData.municipality}>
                      <SelectTrigger>
                        <SelectValue placeholder="Selecciona el municipio" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="medellin">Medellín</SelectItem>
                        <SelectItem value="envigado">Envigado</SelectItem>
                        <SelectItem value="itagui">Itagüí</SelectItem>
                        <SelectItem value="bello">Bello</SelectItem>
                        <SelectItem value="sabaneta">Sabaneta</SelectItem>
                        <SelectItem value="la-estrella">La Estrella</SelectItem>
                        <SelectItem value="caldas">Caldas</SelectItem>
                        <SelectItem value="copacabana">Copacabana</SelectItem>
                        <SelectItem value="girardota">Girardota</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="province">Provincia *</Label>
                    <Select onValueChange={(value) => handleSelectChange('province', value)} value={formData.province}>
                      <SelectTrigger>
                        <SelectValue placeholder="Selecciona la provincia" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="antioquia">Antioquia</SelectItem>
                        <SelectItem value="cundinamarca">Cundinamarca</SelectItem>
                        <SelectItem value="valle-del-cauca">Valle del Cauca</SelectItem>
                        <SelectItem value="atlantico">Atlántico</SelectItem>
                        <SelectItem value="santander">Santander</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                </div>

                {/* Message Content */}
                <div className="space-y-2">
                  <Label htmlFor="message">Contenido del mensaje *</Label>
                  <Textarea
                    id="message"
                    name="message"
                    placeholder="Escribe aquí el contenido completo del mensaje..."
                    value={formData.message}
                    onChange={handleInputChange}
                    rows={6}
                    required
                  />
                </div>

                {/* Image Upload */}
                <div className="space-y-2">
                  <Label htmlFor="image" className="flex items-center gap-2">
                    <Image className="h-4 w-4" />
                    Imagen (opcional)
                  </Label>
                  <Input
                    id="image"
                    type="file"
                    accept="image/*"
                    onChange={handleImageChange}
                  />
                  {imagePreview && (
                    <div className="mt-2">
                      <img 
                        src={imagePreview} 
                        alt="Vista previa" 
                        className="max-w-xs h-32 object-cover rounded-lg border-2 border-gray-200"
                      />
                    </div>
                  )}
                </div>

                {/* Scheduling */}
                <div className="space-y-4">
                  <Label className="flex items-center gap-2">
                    <Clock className="h-4 w-4" />
                    Programar envío (opcional)
                  </Label>
                  
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div className="space-y-2">
                      <Label>Fecha</Label>
                      <Popover>
                        <PopoverTrigger asChild>
                          <Button
                            variant="outline"
                            className={cn(
                              "w-full pl-3 text-left font-normal",
                              !selectedDate && "text-muted-foreground"
                            )}
                          >
                            {selectedDate ? (
                              format(selectedDate, "PPP", { locale: es })
                            ) : (
                              <span>Selecciona una fecha</span>
                            )}
                            <CalendarIcon className="ml-auto h-4 w-4 opacity-50" />
                          </Button>
                        </PopoverTrigger>
                        <PopoverContent className="w-auto p-0" align="start">
                          <Calendar
                            mode="single"
                            selected={selectedDate}
                            onSelect={(date) => {
                              setSelectedDate(date);
                              handleDateTimeChange();
                            }}
                            disabled={(date) => date < new Date() || date < new Date("1900-01-01")}
                            initialFocus
                          />
                        </PopoverContent>
                      </Popover>
                    </div>

                    <div className="space-y-2">
                      <Label htmlFor="time">Hora</Label>
                      <Input
                        id="time"
                        type="time"
                        value={selectedTime}
                        onChange={(e) => {
                          setSelectedTime(e.target.value);
                          handleDateTimeChange();
                        }}
                      />
                    </div>
                  </div>
                </div>

                <div className="flex gap-4">
                  <Button 
                    type="submit"
                    disabled={isSubmitting || !canSendMessage()}
                    className="flex-1 bg-primary hover:bg-primary/90 text-white font-bold py-3"
                  >
                    {isSubmitting ? (
                      "Procesando..."
                    ) : (
                      <>
                        <Send className="h-5 w-5 mr-2" />
                        {editingMessage ? 'Actualizar Mensaje' : 'Enviar Mensaje'}
                      </>
                    )}
                  </Button>
                  <Button 
                    type="button"
                    variant="outline" 
                    onClick={resetForm}
                    disabled={isSubmitting}
                  >
                    Cancelar
                  </Button>
                </div>
              </form>
            </CardContent>
          </Card>
        )}

        {/* Messages List */}
        <Card className="bg-white/95 backdrop-blur-sm shadow-xl">
          <CardHeader>
            <CardTitle>Mensajes Enviados</CardTitle>
            <CardDescription>
              Historial de todos tus mensajes comunitarios
            </CardDescription>
          </CardHeader>
          <CardContent>
            {loading ? (
              <div className="text-center py-8">
                <p>Cargando mensajes...</p>
              </div>
            ) : messages.length === 0 ? (
              <div className="text-center py-8">
                <MessageSquare className="h-12 w-12 text-gray-400 mx-auto mb-4" />
                <p className="text-gray-500">No has enviado mensajes aún</p>
              </div>
            ) : (
              <div className="space-y-4">
                {messages.map((message) => (
                  <div key={message.id} className="border rounded-lg p-4 space-y-3">
                    <div className="flex items-start justify-between">
                      <div className="flex-1">
                        <div className="flex items-center gap-2 mb-2">
                          <h3 className="font-semibold text-lg">{message.title}</h3>
                          <Badge variant={message.sent_at ? "default" : "secondary"}>
                            {message.sent_at ? 'Enviado' : message.scheduled_at ? 'Programado' : 'Borrador'}
                          </Badge>
                        </div>
                        
                        <div className="flex items-center gap-4 text-sm text-gray-600 mb-2">
                          <div className="flex items-center gap-1">
                            <MapPin className="h-4 w-4" />
                            {message.municipality}, {message.province}
                            {message.sector && ` - ${message.sector}`}
                          </div>
                          <div className="flex items-center gap-1">
                            <Clock className="h-4 w-4" />
                            {message.sent_at 
                              ? `Enviado: ${format(new Date(message.sent_at), 'PPp', { locale: es })}`
                              : message.scheduled_at 
                                ? `Programado: ${format(new Date(message.scheduled_at), 'PPp', { locale: es })}`
                                : `Creado: ${format(new Date(message.created_at), 'PPp', { locale: es })}`
                            }
                          </div>
                        </div>
                        
                        <p className="text-gray-700 mb-3 line-clamp-3">{message.message}</p>
                        
                        {message.image_url && (
                          <img 
                            src={message.image_url} 
                            alt="Imagen del mensaje" 
                            className="w-20 h-20 object-cover rounded-lg border"
                          />
                        )}
                      </div>
                      
                      <div className="flex gap-2 ml-4">
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => handleEdit(message)}
                          disabled={!!message.sent_at}
                        >
                          <Edit className="h-4 w-4" />
                        </Button>
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => handleDelete(message.id)}
                          className="text-red-600 hover:text-red-700"
                        >
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default CommunityMessages;