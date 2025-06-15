import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { ArrowLeft, Trophy, Construction, Trash2, Heart, Shield, Users, Stethoscope, Palette, DollarSign } from "lucide-react";
import { Link } from "react-router-dom";

const achievements = [
  {
    category: "Infraestructura",
    icon: Construction,
    color: "text-blue-600",
    bgColor: "bg-blue-100",
    borderColor: "border-blue-500",
    accomplishments: [
      "Construcción y rehabilitación de calles y aceras",
      "Mejoramiento de contenes en toda la ciudad",
      "Construcción de drenajes pluviales eficientes",
      "Desarrollo de paseos peatonales modernos"
    ]
  },
  {
    category: "Limpieza y Saneamiento",
    icon: Trash2,
    color: "text-green-600",
    bgColor: "bg-green-100",
    borderColor: "border-green-500",
    accomplishments: [
      "Limpieza integral de cañadas y avenidas",
      "Programa de recogida de chatarras",
      "Saneamiento de espacios públicos",
      "Mejoramiento del sistema de recolección"
    ]
  },
  {
    category: "Bienestar Animal",
    icon: Heart,
    color: "text-pink-600",
    bgColor: "bg-pink-100",
    borderColor: "border-pink-500",
    accomplishments: [
      "Programa 'Firulay' para animales callejeros",
      "Campañas de esterilización masiva",
      "Jornadas de vacunación para mascotas",
      "Programas de desparasitación animal"
    ]
  },
  {
    category: "Seguridad Ciudadana",
    icon: Shield,
    color: "text-red-600",
    bgColor: "bg-red-100",
    borderColor: "border-red-500",
    accomplishments: [
      "Mejoras significativas en seguridad municipal",
      "Fortalecimiento de servicios de protección",
      "Programas de prevención comunitaria",
      "Coordinación con fuerzas del orden"
    ]
  },
  {
    category: "Participación Ciudadana",
    icon: Users,
    color: "text-purple-600",
    bgColor: "bg-purple-100",
    borderColor: "border-purple-500",
    accomplishments: [
      "Implementación del Presupuesto Participativo",
      "Fortalecimiento de juntas de vecinos",
      "Espacios de diálogo con munícipes",
      "Priorización democrática de obras públicas"
    ]
  },
  {
    category: "Salud",
    icon: Stethoscope,
    color: "text-teal-600",
    bgColor: "bg-teal-100",
    borderColor: "border-teal-500",
    accomplishments: [
      "Operativos médicos comunitarios",
      "Atención integral a pacientes",
      "Programas de salud preventiva",
      "Jornadas de salud animal"
    ]
  },
  {
    category: "Cultura y Deporte",
    icon: Palette,
    color: "text-orange-600",
    bgColor: "bg-orange-100",
    borderColor: "border-orange-500",
    accomplishments: [
      "Apoyo al Desfile Nacional de Carnaval",
      "Patrocinio del Mundial de Fútbol Femenino Sub-17",
      "Promoción de actividades deportivas",
      "Fomento de expresiones culturales locales"
    ]
  },
  {
    category: "Recaudación",
    icon: DollarSign,
    color: "text-emerald-600",
    bgColor: "bg-emerald-100",
    borderColor: "border-emerald-500",
    accomplishments: [
      "Aumento en recaudaciones municipales",
      "Mejoramiento de servicios de cobranza",
      "Optimización de recursos públicos",
      "Transparencia en manejo fiscal"
    ]
  }
];

const Achievements = () => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-600 via-blue-600 to-indigo-700 p-4 animate-fade-in">
      <div className="max-w-4xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-4">
          <Link to="/" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold">LOGROS</h1>
            <p className="text-white/80">Avances significativos de Santo Domingo Este</p>
          </div>
        </div>

        {/* Content Card */}
        <div className="bg-white rounded-[2rem] p-6 shadow-xl">
          <div className="space-y-8">
            {/* Introduction */}
            <div className="text-center">
              <div className="mx-auto bg-gradient-to-br from-purple-500 to-blue-600 p-4 rounded-full w-fit mb-4">
                <Trophy className="h-12 w-12 text-white" />
              </div>
              <h2 className="text-2xl font-bold text-gray-800 mb-3">Logros de la Alcaldía</h2>
              <p className="text-gray-600 leading-relaxed max-w-3xl mx-auto">
                La Alcaldía de Santo Domingo Este ha logrado avances significativos en diversas áreas, 
                destacando la construcción y rehabilitación de infraestructura, limpieza y saneamiento, 
                así como el fortalecimiento de programas sociales y la participación ciudadana.
              </p>
            </div>

            {/* Achievements Grid */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {achievements.map((section, index) => (
                <Card key={index} className={`border-l-4 ${section.borderColor} hover:shadow-lg transition-shadow`}>
                  <CardHeader className="pb-3">
                    <div className="flex items-center gap-3">
                      <div className={`p-2 rounded-lg ${section.bgColor}`}>
                        <section.icon className={`h-6 w-6 ${section.color}`} />
                      </div>
                      <CardTitle className="text-lg text-gray-800">{section.category}</CardTitle>
                    </div>
                  </CardHeader>
                  <CardContent>
                    <div className="space-y-2">
                      {section.accomplishments.map((accomplishment, accomplishmentIndex) => (
                        <div key={accomplishmentIndex} className="flex items-start gap-2">
                          <div className={`w-2 h-2 rounded-full ${section.bgColor} mt-2 flex-shrink-0`}></div>
                          <p className="text-sm text-gray-700 leading-relaxed">{accomplishment}</p>
                        </div>
                      ))}
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>

            {/* Highlighted Programs */}
            <div className="mt-8 space-y-4">
              <h3 className="text-xl font-bold text-gray-800 text-center mb-6">Programas Destacados</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="bg-gradient-to-r from-pink-50 to-purple-50 p-6 rounded-xl border border-pink-200">
                  <div className="flex items-center gap-3 mb-3">
                    <Heart className="h-6 w-6 text-pink-600" />
                    <h4 className="font-bold text-pink-800">Programa "Firulay"</h4>
                  </div>
                  <p className="text-pink-700 text-sm leading-relaxed">
                    Cuidado integral de animales callejeros incluyendo esterilización, 
                    vacunación y desparasitación para mejorar el bienestar animal en la ciudad.
                  </p>
                </div>
                <div className="bg-gradient-to-r from-blue-50 to-indigo-50 p-6 rounded-xl border border-blue-200">
                  <div className="flex items-center gap-3 mb-3">
                    <Users className="h-6 w-6 text-blue-600" />
                    <h4 className="font-bold text-blue-800">Presupuesto Participativo</h4>
                  </div>
                  <p className="text-blue-700 text-sm leading-relaxed">
                    Los munícipes identifican y priorizan obras importantes para su comunidad, 
                    fortaleciendo la democracia participativa local.
                  </p>
                </div>
              </div>
            </div>

            {/* Impact Summary */}
            <div className="bg-gradient-to-r from-purple-50 to-blue-50 p-6 rounded-xl border border-purple-200 mt-8">
              <div className="text-center">
                <h3 className="text-xl font-bold text-purple-800 mb-3">Impacto en la Comunidad</h3>
                <p className="text-purple-700 leading-relaxed">
                  Estos logros representan el compromiso continuo de la Alcaldía de Santo Domingo Este 
                  con el bienestar de sus ciudadanos, mejorando la calidad de vida a través de 
                  infraestructura moderna, servicios eficientes y programas sociales inclusivos.
                </p>
                <div className="flex justify-center gap-2 mt-4 flex-wrap">
                  <Badge className="bg-purple-100 text-purple-800 hover:bg-purple-200">
                    Infraestructura Mejorada
                  </Badge>
                  <Badge className="bg-blue-100 text-blue-800 hover:bg-blue-200">
                    Servicios Optimizados
                  </Badge>
                  <Badge className="bg-green-100 text-green-800 hover:bg-green-200">
                    Participación Ciudadana
                  </Badge>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Achievements;
