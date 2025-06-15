
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Users, ArrowLeft, GraduationCap, Heart, Code } from "lucide-react";
import { Link } from "react-router-dom";

const AboutUs = () => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-600 via-blue-600 to-indigo-700 p-4 animate-fade-in">
      <div className="max-w-4xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-4">
          <Link to="/" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold">¿QUIÉNES SOMOS?</h1>
            <p className="text-white/80">Conoce nuestro equipo</p>
          </div>
        </div>

        {/* Main Content Card */}
        <div className="bg-white rounded-[2rem] p-8 shadow-xl">
          <div className="space-y-8">
            {/* Mission Section */}
            <div className="text-center">
              <div className="mx-auto bg-purple-100 p-4 rounded-full w-fit mb-4">
                <Users className="h-12 w-12 text-purple-600" />
              </div>
              <h2 className="text-3xl font-bold text-gray-800 mb-4">¿Quiénes Somos?</h2>
              <p className="text-lg text-gray-600 leading-relaxed max-w-3xl mx-auto">
                Somos un equipo de desarrolladores comprometidos con mejorar la comunicación entre 
                los ciudadanos y las autoridades, creando puentes digitales que fortalezcan nuestra 
                comunidad y faciliten la participación ciudadana.
              </p>
            </div>

            {/* Academic Section */}
            <div className="bg-gradient-to-r from-blue-50 to-purple-50 rounded-2xl p-6">
              <div className="flex items-center justify-center mb-4">
                <div className="bg-blue-100 p-3 rounded-full mr-4">
                  <GraduationCap className="h-8 w-8 text-blue-600" />
                </div>
                <h3 className="text-2xl font-semibold text-gray-800">Formación Académica</h3>
              </div>
              <p className="text-gray-700 text-center leading-relaxed">
                Somos estudiantes de <strong>Ingeniería de Sistemas y Computación</strong> de la 
                <strong> Pontificia Universidad Católica Madre y Maestra (PUCMM)</strong>. 
                Este proyecto representa no solo nuestro trabajo final de carrera, sino también 
                nuestro compromiso de aplicar los conocimientos adquiridos en esta prestigiosa 
                institución académica para generar un impacto positivo en la sociedad.
              </p>
            </div>

            {/* Vision Section */}
            <div className="bg-gradient-to-r from-purple-50 to-pink-50 rounded-2xl p-6">
              <div className="flex items-center justify-center mb-4">
                <div className="bg-purple-100 p-3 rounded-full mr-4">
                  <Heart className="h-8 w-8 text-purple-600" />
                </div>
                <h3 className="text-2xl font-semibold text-gray-800">Nuestra Visión</h3>
              </div>
              <p className="text-gray-700 text-center leading-relaxed">
                Más allá de la graduación, aspiramos a que <strong>CiudadConecta</strong> se convierta 
                en una herramienta real que empodere a los ciudadanos, mejore la transparencia 
                gubernamental y contribuya al desarrollo de comunidades más conectadas y participativas.
              </p>
            </div>

            {/* Team Section */}
            <div className="bg-gradient-to-r from-green-50 to-blue-50 rounded-2xl p-6">
              <div className="flex items-center justify-center mb-6">
                <div className="bg-green-100 p-3 rounded-full mr-4">
                  <Code className="h-8 w-8 text-green-600" />
                </div>
                <h3 className="text-2xl font-semibold text-gray-800">Nuestro Equipo</h3>
              </div>
              
              <div className="grid md:grid-cols-2 gap-6">
                <div className="text-center bg-white rounded-xl p-6 shadow-sm">
                  <div className="w-16 h-16 bg-gradient-to-br from-purple-400 to-blue-500 rounded-full mx-auto mb-4 flex items-center justify-center">
                    <span className="text-white font-bold text-xl">AN</span>
                  </div>
                  <h4 className="text-xl font-semibold text-gray-800 mb-2">Armando Noel Charle</h4>
                  <p className="text-gray-600">Desarrollador Full Stack</p>
                  <p className="text-sm text-gray-500 mt-2">Estudiante de Ingeniería de Sistemas - PUCMM</p>
                </div>
                
                <div className="text-center bg-white rounded-xl p-6 shadow-sm">
                  <div className="w-16 h-16 bg-gradient-to-br from-green-400 to-teal-500 rounded-full mx-auto mb-4 flex items-center justify-center">
                    <span className="text-white font-bold text-xl">JP</span>
                  </div>
                  <h4 className="text-xl font-semibold text-gray-800 mb-2">Josías Arturo Pérez</h4>
                  <p className="text-gray-600">Desarrollador Full Stack</p>
                  <p className="text-sm text-gray-500 mt-2">Estudiante de Ingeniería de Sistemas - PUCMM</p>
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
