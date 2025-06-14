
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { MapPin, Paperclip } from "lucide-react";

const ReportIssue = () => {
  return (
    <div className="max-w-2xl mx-auto animate-fade-in">
      <Card>
        <CardHeader>
          <CardTitle className="text-2xl">Reportar una Incidencia</CardTitle>
          <CardDescription>
            Ayúdanos a mejorar la ciudad. Describe el problema y adjunta una foto si es posible.
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-6">
          <div className="space-y-2">
            <Label htmlFor="category">Categoría</Label>
            <Select>
              <SelectTrigger id="category">
                <SelectValue placeholder="Selecciona una categoría" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="basura">Basura y Limpieza</SelectItem>
                <SelectItem value="iluminacion">Iluminación Pública</SelectItem>
                <SelectItem value="baches">Baches y Pavimento</SelectItem>
                <SelectItem value="seguridad">Seguridad Ciudadana</SelectItem>
                <SelectItem value="otros">Otros</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="space-y-2">
            <Label htmlFor="description">Descripción</Label>
            <Textarea id="description" placeholder="Describe el problema con el mayor detalle posible..." rows={5} />
          </div>
          <div className="space-y-2">
            <Label htmlFor="photo">Adjuntar Foto</Label>
            <Button variant="outline" className="w-full flex items-center justify-center gap-2">
              <Paperclip className="h-4 w-4" />
              <span>Seleccionar archivo</span>
            </Button>
            <Input id="photo" type="file" className="hidden" />
          </div>
          <div className="flex items-center gap-2 text-sm text-muted-foreground p-3 bg-gray-100 dark:bg-gray-800 rounded-md">
            <MapPin className="h-5 w-5 text-primary" />
            <span>Geolocalización automática activada.</span>
          </div>
          <Button type="submit" className="w-full text-lg" size="lg">Enviar Reporte</Button>
        </CardContent>
      </Card>
    </div>
  );
};

export default ReportIssue;
