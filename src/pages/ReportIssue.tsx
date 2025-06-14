
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { MapPin, Paperclip, ArrowLeft } from "lucide-react";
import { Link } from "react-router-dom";

const ReportIssue = () => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-600 via-blue-600 to-indigo-700 p-4 animate-fade-in">
      <div className="max-w-md mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-4">
          <Link to="/" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold">REPORTAR</h1>
            <p className="text-white/80">Nueva incidencia</p>
          </div>
        </div>

        {/* Form Card */}
        <div className="bg-white rounded-[2rem] p-6 shadow-xl">
          <div className="space-y-6">
            <div className="text-center">
              <h2 className="text-xl font-bold text-gray-800 mb-2">Reportar una Incidencia</h2>
              <p className="text-gray-600 text-sm">
                Ayúdanos a mejorar la ciudad. Describe el problema y adjunta una foto si es posible.
              </p>
            </div>

            <div className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="category" className="text-gray-800 font-semibold">Categoría</Label>
                <Select>
                  <SelectTrigger id="category" className="rounded-xl border-2 border-gray-200 focus:border-purple-500">
                    <SelectValue placeholder="Selecciona una categoría" />
                  </SelectTrigger>
                  <SelectContent className="rounded-xl">
                    <SelectItem value="basura">Basura y Limpieza</SelectItem>
                    <SelectItem value="iluminacion">Iluminación Pública</SelectItem>
                    <SelectItem value="baches">Baches y Pavimento</SelectItem>
                    <SelectItem value="seguridad">Seguridad Ciudadana</SelectItem>
                    <SelectItem value="otros">Otros</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-2">
                <Label htmlFor="description" className="text-gray-800 font-semibold">Descripción</Label>
                <Textarea 
                  id="description" 
                  placeholder="Describe el problema con el mayor detalle posible..." 
                  rows={5} 
                  className="rounded-xl border-2 border-gray-200 focus:border-purple-500 resize-none"
                />
              </div>

              <div className="space-y-2">
                <Label className="text-gray-800 font-semibold">Adjuntar Foto</Label>
                <Button variant="outline" className="w-full flex items-center justify-center gap-2 rounded-xl border-2 border-gray-200 hover:border-purple-500 py-6">
                  <Paperclip className="h-5 w-5 text-purple-600" />
                  <span className="text-gray-700">Seleccionar archivo</span>
                </Button>
                <Input id="photo" type="file" className="hidden" />
              </div>

              <div className="flex items-center gap-3 text-sm text-purple-600 p-4 bg-purple-50 rounded-xl border border-purple-200">
                <MapPin className="h-5 w-5" />
                <span className="font-medium">Geolocalización automática activada.</span>
              </div>

              <Button 
                type="submit" 
                className="w-full text-lg bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-700 hover:to-blue-700 rounded-xl py-6 font-bold shadow-lg transform hover:scale-105 transition-all"
              >
                Enviar Reporte
              </Button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ReportIssue;
