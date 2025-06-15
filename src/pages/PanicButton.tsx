
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { AlarmClockOff, ArrowLeft } from "lucide-react";
import { Link } from "react-router-dom";

const PanicButton = () => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-red-600 via-red-500 to-red-700 p-4 animate-fade-in">
      <div className="max-w-md mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-4">
          <Link to="/" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold">BOTÓN DE PÁNICO</h1>
            <p className="text-white/80">Alerta de emergencia</p>
          </div>
        </div>

        {/* Content Card */}
        <div className="bg-white rounded-[2rem] p-6 shadow-xl">
          <div className="flex items-center justify-center h-64">
            <Card className="w-full text-center border-none shadow-none">
              <CardHeader>
                <div className="mx-auto bg-red-100 p-4 rounded-full w-fit">
                  <AlarmClockOff className="h-12 w-12 text-red-600" />
                </div>
                <CardTitle className="mt-4 text-2xl text-gray-800">Botón de Pánico</CardTitle>
                <CardDescription className="text-gray-600">
                  ¡Estamos trabajando en esta sección!
                </CardDescription>
              </CardHeader>
              <CardContent>
                <p className="text-sm text-gray-500">Vuelve pronto para ver el contenido.</p>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </div>
  );
};

export default PanicButton;
