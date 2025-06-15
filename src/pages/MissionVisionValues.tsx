
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Target, Eye, Heart, ArrowLeft, Users, Shield, Lightbulb, Handshake, Star, Globe } from "lucide-react";
import { Link } from "react-router-dom";

const MissionVisionValues = () => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-600 via-blue-600 to-indigo-700 p-4 animate-fade-in">
      <div className="max-w-4xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-4">
          <Link to="/" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold">MISIÓN, VISIÓN Y VALORES</h1>
            <p className="text-white/80">Nuestros principios fundamentales</p>
          </div>
        </div>

        {/* Content Card */}
        <div className="bg-white rounded-[2rem] p-8 shadow-xl">
          <div className="space-y-8">
            {/* Mission Section */}
            <div className="text-center">
              <div className="mx-auto bg-blue-100 p-4 rounded-full w-fit mb-4">
                <Target className="h-12 w-12 text-blue-600" />
              </div>
              <h2 className="text-3xl font-bold text-gray-800 mb-4">Nuestra Misión</h2>
              <p className="text-lg text-gray-700 leading-relaxed max-w-3xl mx-auto">
                Facilitar la comunicación directa entre ciudadanos y autoridades mediante una 
                plataforma digital integral que permita reportar incidencias, acceder a servicios 
                públicos, y participar activamente en el desarrollo de comunidades más conectadas, 
                transparentes y participativas en la República Dominicana.
              </p>
            </div>

            {/* Vision Section */}
            <div className="bg-gradient-to-r from-purple-50 to-blue-50 rounded-2xl p-6">
              <div className="flex items-center justify-center mb-4">
                <div className="bg-purple-100 p-3 rounded-full mr-4">
                  <Eye className="h-8 w-8 text-purple-600" />
                </div>
                <h3 className="text-2xl font-semibold text-gray-800">Nuestra Visión</h3>
              </div>
              <p className="text-gray-700 text-center leading-relaxed">
                Ser la plataforma líder en participación ciudadana digital en República Dominicana, 
                transformando la manera en que los ciudadanos interactúan con las instituciones 
                públicas y contribuyendo a la construcción de una sociedad más democrática, 
                transparente y eficiente.
              </p>
            </div>

            {/* Values Section */}
            <div>
              <div className="flex items-center justify-center mb-6">
                <div className="bg-green-100 p-3 rounded-full mr-4">
                  <Heart className="h-8 w-8 text-green-600" />
                </div>
                <h3 className="text-2xl font-semibold text-gray-800">Nuestros Valores</h3>
              </div>
              
              <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
                {/* Transparencia */}
                <div className="bg-blue-50 rounded-xl p-6 text-center">
                  <div className="bg-blue-100 p-3 rounded-full w-fit mx-auto mb-3">
                    <Eye className="h-6 w-6 text-blue-600" />
                  </div>
                  <h4 className="text-lg font-semibold text-gray-800 mb-2">Transparencia</h4>
                  <p className="text-sm text-gray-600">
                    Promovemos la claridad y honestidad en todas las comunicaciones entre 
                    ciudadanos y autoridades.
                  </p>
                </div>

                {/* Participación */}
                <div className="bg-purple-50 rounded-xl p-6 text-center">
                  <div className="bg-purple-100 p-3 rounded-full w-fit mx-auto mb-3">
                    <Users className="h-6 w-6 text-purple-600" />
                  </div>
                  <h4 className="text-lg font-semibold text-gray-800 mb-2">Participación</h4>
                  <p className="text-sm text-gray-600">
                    Creemos en el poder de la participación ciudadana activa para mejorar 
                    nuestras comunidades.
                  </p>
                </div>

                {/* Seguridad */}
                <div className="bg-green-50 rounded-xl p-6 text-center">
                  <div className="bg-green-100 p-3 rounded-full w-fit mx-auto mb-3">
                    <Shield className="h-6 w-6 text-green-600" />
                  </div>
                  <h4 className="text-lg font-semibold text-gray-800 mb-2">Seguridad</h4>
                  <p className="text-sm text-gray-600">
                    Protegemos la información de nuestros usuarios y garantizamos un 
                    entorno digital seguro.
                  </p>
                </div>

                {/* Innovación */}
                <div className="bg-yellow-50 rounded-xl p-6 text-center">
                  <div className="bg-yellow-100 p-3 rounded-full w-fit mx-auto mb-3">
                    <Lightbulb className="h-6 w-6 text-yellow-600" />
                  </div>
                  <h4 className="text-lg font-semibold text-gray-800 mb-2">Innovación</h4>
                  <p className="text-sm text-gray-600">
                    Utilizamos tecnología de vanguardia para crear soluciones efectivas 
                    y accesibles.
                  </p>
                </div>

                {/* Colaboración */}
                <div className="bg-indigo-50 rounded-xl p-6 text-center">
                  <div className="bg-indigo-100 p-3 rounded-full w-fit mx-auto mb-3">
                    <Handshake className="h-6 w-6 text-indigo-600" />
                  </div>
                  <h4 className="text-lg font-semibold text-gray-800 mb-2">Colaboración</h4>
                  <p className="text-sm text-gray-600">
                    Fomentamos el trabajo conjunto entre ciudadanos, instituciones y 
                    organizaciones.
                  </p>
                </div>

                {/* Excelencia */}
                <div className="bg-pink-50 rounded-xl p-6 text-center">
                  <div className="bg-pink-100 p-3 rounded-full w-fit mx-auto mb-3">
                    <Star className="h-6 w-6 text-pink-600" />
                  </div>
                  <h4 className="text-lg font-semibold text-gray-800 mb-2">Excelencia</h4>
                  <p className="text-sm text-gray-600">
                    Nos comprometemos con la calidad y mejora continua en todos nuestros 
                    procesos y servicios.
                  </p>
                </div>
              </div>
            </div>

            {/* Impact Section */}
            <div className="bg-gradient-to-r from-orange-50 to-red-50 rounded-2xl p-6">
              <div className="flex items-center justify-center mb-4">
                <div className="bg-orange-100 p-3 rounded-full mr-4">
                  <Globe className="h-8 w-8 text-orange-600" />
                </div>
                <h3 className="text-2xl font-semibold text-gray-800">Nuestro Impacto</h3>
              </div>
              <p className="text-gray-700 text-center leading-relaxed">
                A través de CiudadConecta, buscamos empoderar a cada ciudadano dominicano 
                para que sea parte activa del cambio positivo en su comunidad, creando 
                puentes digitales que fortalezcan la democracia participativa y mejoren 
                la calidad de vida de todos.
              </p>
            </div>

            {/* Footer Message */}
            <div className="text-center pt-4 border-t border-gray-200">
              <p className="text-gray-600 italic">
                "Conectando ciudadanos, transformando comunidades"
              </p>
              <p className="text-sm text-gray-500 mt-2">
                Desarrollado con dedicación por estudiantes de Ingeniería de Sistemas - PUCMM
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default MissionVisionValues;
