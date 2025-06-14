import { Button } from "@/components/ui/button";
import { Card, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Megaphone, LightbulbOff, Trash2, Recycle, AlarmClockOff, Siren } from "lucide-react";
import { Link } from "react-router-dom";

const features = [
  {
    title: "Reportar Incidencia",
    description: "Informa sobre problemas en tu área.",
    icon: Megaphone,
    href: "/reportar",
  },
  {
    title: "Falta de Iluminación",
    description: "Reporta fallas en el alumbrado público.",
    icon: LightbulbOff,
    href: "/reportar-iluminacion",
  },
  {
    title: "Pago de Basura",
    description: "Realiza el pago de tu servicio.",
    icon: Trash2,
    href: "/pago-basura",
  },
  {
    title: "Guía de Reciclaje",
    description: "Aprende a separar tus residuos.",
    icon: Recycle,
    href: "/guia-reciclaje",
  },
  {
    title: "Botón de Pánico",
    description: "Alerta a las autoridades en emergencias.",
    icon: AlarmClockOff,
    href: "/boton-panico",
  },
  {
    title: "Alerta Amber",
    description: "Ayuda a encontrar a menores desaparecidos.",
    icon: Siren,
    href: "/alerta-amber",
  },
];

const Index = () => {
  return (
    <div className="space-y-8 animate-fade-in">
      <div className="bg-gradient-to-br from-primary via-violet-600 to-indigo-700 p-8 md:p-12 rounded-2xl shadow-lg text-center text-white flex flex-col items-center">
        <img src="/lovable-uploads/0ab84370-a353-4d89-95bd-a0118a04d236.png" alt="CiudadConecta Logo" className="h-24 md:h-32 w-auto mb-4" />
        <p className="text-lg text-indigo-100 max-w-2xl mx-auto">
          Tu voz para una ciudad mejor. Reporta incidencias, consulta servicios y participa en el progreso de tu comunidad.
        </p>
        <div className="mt-8">
          <Button asChild size="lg" className="text-lg bg-white text-primary font-bold hover:bg-gray-100 shadow-md transition-transform transform hover:scale-105">
            <Link to="/reportar">Comenzar</Link>
          </Button>
        </div>
      </div>

      <div className="space-y-6">
        <h2 className="text-3xl font-bold tracking-tight text-gray-900 dark:text-white">Servicios Principales</h2>
        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
          {features.map((feature) => (
            <Link to={feature.href} key={feature.title} className="group">
              <Card className="h-full hover:border-primary/40 hover:shadow-lg transition-all duration-300 transform hover:-translate-y-1">
                <CardHeader>
                  <div className="flex items-center gap-4">
                    <div className="bg-primary/10 p-3 rounded-xl">
                      <feature.icon className="h-6 w-6 text-primary" />
                    </div>
                    <div className="flex-1">
                      <CardTitle className="text-base font-semibold">{feature.title}</CardTitle>
                      <CardDescription className="text-sm mt-1">{feature.description}</CardDescription>
                    </div>
                  </div>
                </CardHeader>
              </Card>
            </Link>
          ))}
        </div>
      </div>
    </div>
  );
};

export default Index;
