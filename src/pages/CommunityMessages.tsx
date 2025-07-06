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
                        <SelectItem value="altamira">Altamira</SelectItem>
                        <SelectItem value="arenoso">Arenoso</SelectItem>
                        <SelectItem value="azua">Azua</SelectItem>
                        <SelectItem value="baitoa">Baitoa</SelectItem>
                        <SelectItem value="bani">Baní</SelectItem>
                        <SelectItem value="banica">Bánica</SelectItem>
                        <SelectItem value="barahona">Barahona</SelectItem>
                        <SelectItem value="bayaguana">Bayaguana</SelectItem>
                        <SelectItem value="boca-chica">Boca Chica</SelectItem>
                        <SelectItem value="bohechio">Bohechío</SelectItem>
                        <SelectItem value="bonao">Bonao</SelectItem>
                        <SelectItem value="cabral">Cabral</SelectItem>
                        <SelectItem value="cabrera">Cabrera</SelectItem>
                        <SelectItem value="cambita-garabitos">Cambita Garabitos</SelectItem>
                        <SelectItem value="castanuelas">Castañuelas</SelectItem>
                        <SelectItem value="castillo">Castillo</SelectItem>
                        <SelectItem value="cayetano-germosen">Cayetano Germosén</SelectItem>
                        <SelectItem value="cevicos">Cevicos</SelectItem>
                        <SelectItem value="comendador">Comendador</SelectItem>
                        <SelectItem value="constanza">Constanza</SelectItem>
                        <SelectItem value="consuelo">Consuelo</SelectItem>
                        <SelectItem value="cotui">Cotuí</SelectItem>
                        <SelectItem value="cristobal">Cristóbal</SelectItem>
                        <SelectItem value="dajabon">Dajabón</SelectItem>
                        <SelectItem value="duverge">Duvergé</SelectItem>
                        <SelectItem value="el-cercado">El Cercado</SelectItem>
                        <SelectItem value="el-factor">El Factor</SelectItem>
                        <SelectItem value="el-llano">El Llano</SelectItem>
                        <SelectItem value="el-penon">El Peñón</SelectItem>
                        <SelectItem value="el-pino">El Pino</SelectItem>
                        <SelectItem value="el-seibo">El Seibo</SelectItem>
                        <SelectItem value="el-valle">El Valle</SelectItem>
                        <SelectItem value="enriquillo">Enriquillo</SelectItem>
                        <SelectItem value="esperanza">Esperanza</SelectItem>
                        <SelectItem value="estebania">Estebanía</SelectItem>
                        <SelectItem value="fantino">Fantino</SelectItem>
                        <SelectItem value="fundacion">Fundación</SelectItem>
                        <SelectItem value="galvan">Galván</SelectItem>
                        <SelectItem value="gaspar-hernandez">Gaspar Hernández</SelectItem>
                        <SelectItem value="guananico">Guananico</SelectItem>
                        <SelectItem value="guayabal">Guayabal</SelectItem>
                        <SelectItem value="guayacanes">Guayacanes</SelectItem>
                        <SelectItem value="guaymate">Guaymate</SelectItem>
                        <SelectItem value="guayubin">Guayubín</SelectItem>
                        <SelectItem value="haina">Haina</SelectItem>
                        <SelectItem value="hato-mayor">Hato Mayor</SelectItem>
                        <SelectItem value="higuey">Higüey</SelectItem>
                        <SelectItem value="hondo-valle">Hondo Valle</SelectItem>
                        <SelectItem value="hostos">Hostos</SelectItem>
                        <SelectItem value="imbert">Imbert</SelectItem>
                        <SelectItem value="jamao-al-norte">Jamao Al Norte</SelectItem>
                        <SelectItem value="janico">Jánico</SelectItem>
                        <SelectItem value="jaquimeyes">Jaquimeyes</SelectItem>
                        <SelectItem value="jarabacoa">Jarabacoa</SelectItem>
                        <SelectItem value="jima-abajo">Jima Abajo</SelectItem>
                        <SelectItem value="jimani">Jimaní</SelectItem>
                        <SelectItem value="juan-de-herrera">Juan de Herrera</SelectItem>
                        <SelectItem value="juan-santiago">Juan Santiago</SelectItem>
                        <SelectItem value="la-cienaga">La Ciénaga</SelectItem>
                        <SelectItem value="la-descubierta">La Descubierta</SelectItem>
                        <SelectItem value="la-mata">La Mata</SelectItem>
                        <SelectItem value="la-romana">La Romana</SelectItem>
                        <SelectItem value="la-vega">La Vega</SelectItem>
                        <SelectItem value="laguna-salada">Laguna Salada</SelectItem>
                        <SelectItem value="las-charcas">Las Charcas</SelectItem>
                        <SelectItem value="las-guaranas">Las Guáranas</SelectItem>
                        <SelectItem value="las-matas-de-farfan">Las Matas de Farfán</SelectItem>
                        <SelectItem value="las-matas-de-santa-cruz">Las Matas de Santa Cruz</SelectItem>
                        <SelectItem value="las-salinas">Las Salinas</SelectItem>
                        <SelectItem value="las-terrenas">Las Terrenas</SelectItem>
                        <SelectItem value="las-yayas-de-viajama">Las Yayas de Viajama</SelectItem>
                        <SelectItem value="licey-al-medio">Licey al Medio</SelectItem>
                        <SelectItem value="loma-de-cabrera">Loma de Cabrera</SelectItem>
                        <SelectItem value="los-alcarrizos">Los Alcarrizos</SelectItem>
                        <SelectItem value="los-cacaos">Los Cacaos</SelectItem>
                        <SelectItem value="los-hidalgos">Los Hidalgos</SelectItem>
                        <SelectItem value="los-llanos">Los Llanos</SelectItem>
                        <SelectItem value="los-rios">Los Ríos</SelectItem>
                        <SelectItem value="luperon">Luperón</SelectItem>
                        <SelectItem value="maimon">Maimón</SelectItem>
                        <SelectItem value="mao">Mao</SelectItem>
                        <SelectItem value="matanzas">Matanzas</SelectItem>
                        <SelectItem value="mella">Mella</SelectItem>
                        <SelectItem value="miches">Miches</SelectItem>
                        <SelectItem value="moca">Moca</SelectItem>
                        <SelectItem value="moncion">Monción</SelectItem>
                        <SelectItem value="monte-cristi">Monte Cristi</SelectItem>
                        <SelectItem value="monte-plata">Monte Plata</SelectItem>
                        <SelectItem value="nagua">Nagua</SelectItem>
                        <SelectItem value="neiba">Neiba</SelectItem>
                        <SelectItem value="nigua">Nigua</SelectItem>
                        <SelectItem value="nizao">Nizao</SelectItem>
                        <SelectItem value="oviedo">Oviedo</SelectItem>
                        <SelectItem value="padre-las-casas">Padre Las Casas</SelectItem>
                        <SelectItem value="paraiso">Paraíso</SelectItem>
                        <SelectItem value="partido">Partido</SelectItem>
                        <SelectItem value="pedernales">Pedernales</SelectItem>
                        <SelectItem value="pedro-brand">Pedro Brand</SelectItem>
                        <SelectItem value="pedro-santana">Pedro Santana</SelectItem>
                        <SelectItem value="pepillo-salcedo">Pepillo Salcedo</SelectItem>
                        <SelectItem value="peralta">Peralta</SelectItem>
                        <SelectItem value="peralvillo">Peralvillo</SelectItem>
                        <SelectItem value="piedra-blanca">Piedra Blanca</SelectItem>
                        <SelectItem value="pimentel">Pimentel</SelectItem>
                        <SelectItem value="polo">Polo</SelectItem>
                        <SelectItem value="postrer-rio">Postrer Río</SelectItem>
                        <SelectItem value="pueblo-viejo">Pueblo Viejo</SelectItem>
                        <SelectItem value="puerto-plata">Puerto Plata</SelectItem>
                        <SelectItem value="punal">Puñal</SelectItem>
                        <SelectItem value="quisqueya">Quisqueya</SelectItem>
                        <SelectItem value="ramon-santana">Ramón Santana</SelectItem>
                        <SelectItem value="rancho-arriba">Rancho Arriba</SelectItem>
                        <SelectItem value="restauracion">Restauración</SelectItem>
                        <SelectItem value="rio-san-juan">Río San Juan</SelectItem>
                        <SelectItem value="sabana-de-la-mar">Sabana de la Mar</SelectItem>
                        <SelectItem value="sabana-grande-de-boya">Sabana Grande de Boyá</SelectItem>
                        <SelectItem value="sabana-grande-de-palenque">Sabana Grande de Palenque</SelectItem>
                        <SelectItem value="sabana-iglesia">Sabana Iglesia</SelectItem>
                        <SelectItem value="sabana-larga">Sabana Larga</SelectItem>
                        <SelectItem value="sabana-yegua">Sabana Yegua</SelectItem>
                        <SelectItem value="sabaneta">Sabaneta</SelectItem>
                        <SelectItem value="salcedo">Salcedo</SelectItem>
                        <SelectItem value="samana">Samaná</SelectItem>
                        <SelectItem value="san-antonio-de-guerra">San Antonio de Guerra</SelectItem>
                        <SelectItem value="san-cristobal">San Cristóbal</SelectItem>
                        <SelectItem value="san-francisco-de-macoris">San Francisco de Macorís</SelectItem>
                        <SelectItem value="san-jose-de-las-matas">San José de las Matas</SelectItem>
                        <SelectItem value="san-jose-de-ocoa">San José de Ocoa</SelectItem>
                        <SelectItem value="san-juan">San Juan</SelectItem>
                        <SelectItem value="san-pedro-de-macoris">San Pedro de Macorís</SelectItem>
                        <SelectItem value="san-rafael-del-yuma">San Rafael del Yuma</SelectItem>
                        <SelectItem value="san-victor">San Víctor</SelectItem>
                        <SelectItem value="sanchez">Sánchez</SelectItem>
                        <SelectItem value="santiago-de-los-caballeros">Santiago de los Caballeros</SelectItem>
                        <SelectItem value="santo-domingo">Santo Domingo</SelectItem>
                        <SelectItem value="santo-domingo-este">Santo Domingo Este</SelectItem>
                        <SelectItem value="santo-domingo-norte">Santo Domingo Norte</SelectItem>
                        <SelectItem value="santo-domingo-oeste">Santo Domingo Oeste</SelectItem>
                        <SelectItem value="sosua">Sosúa</SelectItem>
                        <SelectItem value="tabara-arriba">Tábara Arriba</SelectItem>
                        <SelectItem value="tamayo">Tamayo</SelectItem>
                        <SelectItem value="tamboril">Tamboril</SelectItem>
                        <SelectItem value="tenares">Tenares</SelectItem>
                        <SelectItem value="vallejuelo">Vallejuelo</SelectItem>
                        <SelectItem value="vicente-noble">Vicente Noble</SelectItem>
                        <SelectItem value="villa-altagracia">Villa Altagracia</SelectItem>
                        <SelectItem value="villa-bisono">Villa Bisonó (Navarrete)</SelectItem>
                        <SelectItem value="villa-gonzalez">Villa González</SelectItem>
                        <SelectItem value="villa-hermosa">Villa Hermosa</SelectItem>
                        <SelectItem value="villa-isabela">Villa Isabela</SelectItem>
                        <SelectItem value="villa-jaragua">Villa Jaragua</SelectItem>
                        <SelectItem value="villa-los-almacigos">Villa Los Almácigos</SelectItem>
                        <SelectItem value="villa-montellano">Villa Montellano</SelectItem>
                        <SelectItem value="villa-riva">Villa Riva</SelectItem>
                        <SelectItem value="villa-tapia">Villa Tapia</SelectItem>
                        <SelectItem value="villa-vasquez">Villa Vásquez</SelectItem>
                        <SelectItem value="yaguate">Yaguate</SelectItem>
                        <SelectItem value="yamasa">Yamasá</SelectItem>
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
                        <SelectItem value="azua">Azua</SelectItem>
                        <SelectItem value="bahoruco">Bahoruco</SelectItem>
                        <SelectItem value="barahona">Barahona</SelectItem>
                        <SelectItem value="dajabon">Dajabón</SelectItem>
                        <SelectItem value="distrito-nacional">Distrito Nacional</SelectItem>
                        <SelectItem value="duarte">Duarte</SelectItem>
                        <SelectItem value="el-seibo">El Seibo</SelectItem>
                        <SelectItem value="elias-pina">Elías Piña</SelectItem>
                        <SelectItem value="espaillat">Espaillat</SelectItem>
                        <SelectItem value="hato-mayor">Hato Mayor</SelectItem>
                        <SelectItem value="hermanas-mirabal">Hermanas Mirabal</SelectItem>
                        <SelectItem value="independencia">Independencia</SelectItem>
                        <SelectItem value="la-altagracia">La Altagracia</SelectItem>
                        <SelectItem value="la-romana">La Romana</SelectItem>
                        <SelectItem value="la-vega">La Vega</SelectItem>
                        <SelectItem value="maria-trinidad-sanchez">María Trinidad Sánchez</SelectItem>
                        <SelectItem value="monsenor-nouel">Monseñor Nouel</SelectItem>
                        <SelectItem value="monte-cristi">Monte Cristi</SelectItem>
                        <SelectItem value="monte-plata">Monte Plata</SelectItem>
                        <SelectItem value="pedernales">Pedernales</SelectItem>
                        <SelectItem value="peravia">Peravia</SelectItem>
                        <SelectItem value="puerto-plata">Puerto Plata</SelectItem>
                        <SelectItem value="samana">Samaná</SelectItem>
                        <SelectItem value="san-cristobal">San Cristóbal</SelectItem>
                        <SelectItem value="san-jose-de-ocoa">San José de Ocoa</SelectItem>
                        <SelectItem value="san-juan">San Juan</SelectItem>
                        <SelectItem value="san-pedro-de-macoris">San Pedro de Macorís</SelectItem>
                        <SelectItem value="sanchez-ramirez">Sánchez Ramírez</SelectItem>
                        <SelectItem value="santiago">Santiago</SelectItem>
                        <SelectItem value="santiago-rodriguez">Santiago Rodríguez</SelectItem>
                        <SelectItem value="santo-domingo">Santo Domingo</SelectItem>
                        <SelectItem value="valverde">Valverde</SelectItem>
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