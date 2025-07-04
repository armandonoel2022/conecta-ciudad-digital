
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Users, ArrowLeft, GraduationCap, Heart, Code } from "lucide-react";
import { Link } from "react-router-dom";

const AboutUs = () => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 animate-fade-in">
      <div className="max-w-4xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-4">
          <Link to="/" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold">¿QUIÉNES SOMOS?</h1>
            <p className="text-white/80">Conoce nuestra plataforma</p>
          </div>
        </div>

        {/* Main Content Card */}
        <div className="bg-white rounded-[2rem] p-8 shadow-xl">
          <div className="space-y-8">
            {/* About Section */}
            <div className="text-center">
              <div className="mx-auto bg-blue-100 p-4 rounded-full w-fit mb-4">
                <Users className="h-12 w-12 text-primary" />
              </div>
              <h2 className="text-3xl font-bold text-gray-800 mb-4">¿Quiénes Somos?</h2>
              <p className="text-lg text-gray-600 leading-relaxed max-w-3xl mx-auto">
                <strong>CiudadConecta</strong> es una plataforma digital integral desarrollada para 
                fortalecer la comunicación entre ciudadanos y autoridades municipales en República Dominicana, 
                promoviendo la transparencia, participación ciudadana y mejora continua de los servicios públicos.
              </p>
            </div>

            {/* Mission Section */}
            <div className="bg-gradient-to-r from-blue-50 to-blue-100 rounded-2xl p-6">
              <div className="flex items-center justify-center mb-4">
                <div className="bg-blue-100 p-3 rounded-full mr-4">
                  <Heart className="h-8 w-8 text-primary" />
                </div>
                <h3 className="text-2xl font-semibold text-gray-800">Nuestra Misión</h3>
              </div>
              <p className="text-gray-700 text-center leading-relaxed">
                Facilitar la comunicación directa entre ciudadanos y autoridades mediante tecnología 
                innovadora que permite reportar incidencias, acceder a servicios públicos, y participar 
                activamente en el desarrollo de comunidades más conectadas y transparentes.
              </p>
            </div>

            {/* Vision Section */}
            <div className="bg-gradient-to-r from-green-50 to-blue-50 rounded-2xl p-6">
              <div className="flex items-center justify-center mb-4">
                <div className="bg-green-100 p-3 rounded-full mr-4">
                  <GraduationCap className="h-8 w-8 text-green-600" />
                </div>
                <h3 className="text-2xl font-semibold text-gray-800">Nuestra Visión</h3>
              </div>
              <p className="text-gray-700 text-center leading-relaxed">
                Ser la plataforma líder en participación ciudadana digital en República Dominicana, 
                transformando la manera en que los ciudadanos interactúan con las instituciones públicas 
                y contribuyendo a la construcción de una sociedad más democrática y eficiente.
              </p>
            </div>

            {/* Benefits Section */}
            <div className="bg-gradient-to-r from-amber-50 to-orange-50 rounded-2xl p-6">
              <div className="flex items-center justify-center mb-6">
                <div className="bg-amber-100 p-3 rounded-full mr-4">
                  <Code className="h-8 w-8 text-amber-600" />
                </div>
                <h3 className="text-2xl font-semibold text-gray-800">Beneficios de CiudadConecta</h3>
              </div>
              
              <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
                <div className="text-center bg-white rounded-xl p-4 shadow-sm">
                  <h4 className="font-semibold text-gray-800 mb-2">Comunicación Directa</h4>
                  <p className="text-sm text-gray-600">Canal directo entre ciudadanos y autoridades</p>
                </div>
                <div className="text-center bg-white rounded-xl p-4 shadow-sm">
                  <h4 className="font-semibold text-gray-800 mb-2">Transparencia</h4>
                  <p className="text-sm text-gray-600">Seguimiento en tiempo real del estado de reportes</p>
                </div>
                <div className="text-center bg-white rounded-xl p-4 shadow-sm">
                  <h4 className="font-semibold text-gray-800 mb-2">Servicios Digitales</h4>
                  <p className="text-sm text-gray-600">Pago de servicios municipales desde cualquier lugar</p>
                </div>
                <div className="text-center bg-white rounded-xl p-4 shadow-sm">
                  <h4 className="font-semibold text-gray-800 mb-2">Participación Activa</h4>
                  <p className="text-sm text-gray-600">Herramientas para involucrar a la comunidad</p>
                </div>
                <div className="text-center bg-white rounded-xl p-4 shadow-sm">
                  <h4 className="font-semibold text-gray-800 mb-2">Eficiencia</h4>
                  <p className="text-sm text-gray-600">Optimización de procesos administrativos</p>
                </div>
                <div className="text-center bg-white rounded-xl p-4 shadow-sm">
                  <h4 className="font-semibold text-gray-800 mb-2">Accesibilidad</h4>
                  <p className="text-sm text-gray-600">Disponible 24/7 desde cualquier dispositivo</p>
                </div>
              </div>
            </div>

            {/* Footer Message */}
            <div className="text-center pt-4">
              <p className="text-gray-600 italic">
                "Construyendo el futuro digital de nuestras comunidades, un código a la vez."
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default AboutUs;
