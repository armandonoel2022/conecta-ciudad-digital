import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { ArrowLeft, ArrowRight, CheckCircle, Megaphone, Trash2, Siren, AlarmClockOff, Users } from "lucide-react";
import { Link } from "react-router-dom";
import { useState } from "react";

const tutorialSteps = [
  {
    title: "¡Bienvenido a CiudadConecta!",
    description: "Tu plataforma para mejorar tu comunidad",
    content: "CiudadConecta te permite comunicarte directamente con las autoridades, reportar problemas y acceder a servicios municipales desde tu dispositivo.",
    icon: Users,
    color: "from-primary to-blue-600"
  },
  {
    title: "Reportar Incidencias",
    description: "Informa sobre problemas en tu área",
    content: "Puedes reportar baches, problemas de iluminación, basura acumulada y más. Incluye fotos y ubicación para un reporte más efectivo.",
    icon: Megaphone,
    color: "from-blue-500 to-blue-600"
  },
  {
    title: "Pago de Servicios",
    description: "Paga tus facturas de basura fácilmente",
    content: "Revisa y paga tus facturas de recolección de basura directamente desde la app. También puedes configurar pagos automáticos.",
    icon: Trash2,
    color: "from-green-500 to-green-600"
  },
  {
    title: "Alertas de Emergencia",
    description: "Mantente seguro con nuestros sistemas de alerta",
    content: "Usa el botón de pánico en emergencias y ayuda con las Alertas Amber para encontrar menores desaparecidos.",
    icon: Siren,
    color: "from-red-500 to-red-600"
  },
  {
    title: "¡Ya estás listo!",
    description: "Comienza a usar CiudadConecta",
    content: "Ahora puedes explorar todas las funciones. Tu participación activa ayuda a mejorar nuestra comunidad.",
    icon: CheckCircle,
    color: "from-primary to-indigo-600"
  }
];

const Tutorial = () => {
  const [currentStep, setCurrentStep] = useState(0);
  const totalSteps = tutorialSteps.length;
  const step = tutorialSteps[currentStep];
  const Icon = step.icon;

  const nextStep = () => {
    if (currentStep < totalSteps - 1) {
      setCurrentStep(currentStep + 1);
    }
  };

  const prevStep = () => {
    if (currentStep > 0) {
      setCurrentStep(currentStep - 1);
    }
  };

  const isLastStep = currentStep === totalSteps - 1;
  const isFirstStep = currentStep === 0;

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 animate-fade-in">
      <div className="max-w-2xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-4">
          <Link to="/" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold">TUTORIAL</h1>
            <p className="text-white/80">Aprende a usar CiudadConecta</p>
          </div>
        </div>

        {/* Progress Bar */}
        <div className="bg-white/10 backdrop-blur-sm rounded-2xl p-4">
          <div className="flex items-center justify-between mb-2">
            <span className="text-white text-sm font-medium">Progreso</span>
            <span className="text-white text-sm">{currentStep + 1} de {totalSteps}</span>
          </div>
          <div className="w-full bg-white/20 rounded-full h-2">
            <div 
              className="bg-white h-2 rounded-full transition-all duration-300" 
              style={{ width: `${((currentStep + 1) / totalSteps) * 100}%` }}
            ></div>
          </div>
        </div>

        {/* Tutorial Step */}
        <Card className="bg-white/95 backdrop-blur-sm shadow-xl">
          <CardHeader className="text-center pb-4">
            <div className={`mx-auto p-4 rounded-full w-fit mb-4 bg-gradient-to-r ${step.color}`}>
              <Icon className="h-16 w-16 text-white" />
            </div>
            <CardTitle className="text-2xl text-gray-800">{step.title}</CardTitle>
            <CardDescription className="text-lg">{step.description}</CardDescription>
          </CardHeader>
          <CardContent className="text-center space-y-6">
            <p className="text-gray-700 leading-relaxed text-lg">
              {step.content}
            </p>

            {/* Navigation Buttons */}
            <div className="flex justify-between items-center pt-4">
              <Button 
                onClick={prevStep}
                disabled={isFirstStep}
                variant="outline"
                className="flex items-center gap-2"
              >
                <ArrowLeft className="h-4 w-4" />
                Anterior
              </Button>

              <div className="flex gap-2">
                {tutorialSteps.map((_, index) => (
                  <button
                    key={index}
                    onClick={() => setCurrentStep(index)}
                    className={`w-3 h-3 rounded-full transition-colors ${
                      index === currentStep 
                        ? 'bg-primary' 
                        : index < currentStep 
                        ? 'bg-green-500' 
                        : 'bg-gray-300'
                    }`}
                  />
                ))}
              </div>

              {isLastStep ? (
                <Button asChild className="bg-primary hover:bg-primary/90">
                  <Link to="/" className="flex items-center gap-2">
                    <CheckCircle className="h-4 w-4" />
                    ¡Comenzar!
                  </Link>
                </Button>
              ) : (
                <Button 
                  onClick={nextStep}
                  className="bg-primary hover:bg-primary/90 flex items-center gap-2"
                >
                  Siguiente
                  <ArrowRight className="h-4 w-4" />
                </Button>
              )}
            </div>
          </CardContent>
        </Card>

        {/* Quick Actions (only on last step) */}
        {isLastStep && (
          <Card className="bg-white/95 backdrop-blur-sm shadow-xl">
            <CardHeader>
              <CardTitle>Acciones Rápidas</CardTitle>
              <CardDescription>Comienza con estas funciones principales</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <Button asChild variant="outline" className="h-auto p-4">
                  <Link to="/reportar" className="flex items-center gap-3">
                    <Megaphone className="h-6 w-6 text-primary" />
                    <div className="text-left">
                      <div className="font-semibold">Reportar Problema</div>
                      <div className="text-sm text-gray-600">Tu primer reporte</div>
                    </div>
                  </Link>
                </Button>
                
                <Button asChild variant="outline" className="h-auto p-4">
                  <Link to="/pago-basura" className="flex items-center gap-3">
                    <Trash2 className="h-6 w-6 text-green-600" />
                    <div className="text-left">
                      <div className="font-semibold">Ver Facturas</div>
                      <div className="text-sm text-gray-600">Revisar pagos</div>
                    </div>
                  </Link>
                </Button>
              </div>
            </CardContent>
          </Card>
        )}
      </div>
    </div>
  );
};

export default Tutorial;