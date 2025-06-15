
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Phone, Building, Shield, AlertTriangle, Clock, ArrowLeft } from "lucide-react";
import { Link } from "react-router-dom";

const contacts = [
  {
    category: "Emergencias",
    icon: AlertTriangle,
    color: "text-red-600",
    bgColor: "bg-red-100",
    contacts: [
      {
        name: "Sistema Nacional de Emergencias",
        number: "9-1-1",
        description: "Para emergencias médicas, de seguridad y rescate",
      }
    ]
  },
  {
    category: "Servicios Gubernamentales",
    icon: Building,
    color: "text-blue-600",
    bgColor: "bg-blue-100",
    contacts: [
      {
        name: "Centro de Contacto Gubernamental",
        number: "*462",
        description: "Información sobre servicios gubernamentales y orientación",
      },
      {
        name: "Denuncias y Quejas",
        number: "311",
        description: "Para denuncias, quejas y sugerencias sobre servicios públicos",
      },
      {
        name: "Atención al Ciudadano",
        number: "700",
        description: "Servicios de atención ciudadana general",
      }
    ]
  },
  {
    category: "Instituciones Oficiales",
    icon: Shield,
    color: "text-purple-600",
    bgColor: "bg-purple-100",
    contacts: [
      {
        name: "Palacio Nacional",
        number: "809-695-8000",
        description: "Presidencia de la República Dominicana",
      },
      {
        name: "Ministerio de la Presidencia",
        number: "809-475-5243",
        description: "Contacto alternativo: 809-695-8000",
      },
      {
        name: "Ministerio de Interior y Policía",
        number: "809-686-6251",
        description: "Extensiones: 3227 y 3228",
      }
    ]
  },
  {
    category: "Gobierno Local",
    icon: Building,
    color: "text-green-600",
    bgColor: "bg-green-100",
    contacts: [
      {
        name: "Ayuntamiento de Santo Domingo Este",
        number: "809-788-7676",
        description: "Carr. Mella #49, Esq. Santo Domingo Este",
        hours: "Lun-Vie: 8:00 AM - 4:00 PM"
      }
    ]
  }
];

const CommunicationGuide = () => {
  const handleCall = (phoneNumber: string) => {
    window.open(`tel:${phoneNumber}`, '_self');
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-600 via-blue-600 to-indigo-700 p-4 animate-fade-in">
      <div className="max-w-md mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-4">
          <Link to="/" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold">CONTACTOS IMPORTANTES</h1>
            <p className="text-white/80">Números de autoridades y servicios</p>
          </div>
        </div>

        {/* Content Card */}
        <div className="bg-white rounded-[2rem] p-6 shadow-xl space-y-6">
          <div className="text-center">
            <h2 className="text-xl font-bold text-gray-800 mb-2">Directorio de Contactos</h2>
            <p className="text-gray-600 text-sm">
              Números telefónicos importantes de autoridades y servicios públicos
            </p>
          </div>

          {contacts.map((section, sectionIndex) => (
            <div key={sectionIndex} className="space-y-4">
              <div className="flex items-center gap-3">
                <div className={`p-2 rounded-lg ${section.bgColor}`}>
                  <section.icon className={`h-5 w-5 ${section.color}`} />
                </div>
                <h3 className="font-bold text-lg text-gray-800">{section.category}</h3>
              </div>

              <div className="space-y-3">
                {section.contacts.map((contact, contactIndex) => (
                  <Card key={contactIndex} className="border-l-4 border-l-purple-500">
                    <CardHeader className="pb-2">
                      <div className="flex items-center justify-between">
                        <CardTitle className="text-base text-gray-800">{contact.name}</CardTitle>
                        <Button
                          size="sm"
                          onClick={() => handleCall(contact.number)}
                          className="bg-green-600 hover:bg-green-700 text-white"
                        >
                          <Phone className="h-4 w-4 mr-1" />
                          Llamar
                        </Button>
                      </div>
                      <div className="flex items-center gap-2 text-lg font-bold text-purple-600">
                        <Phone className="h-4 w-4" />
                        {contact.number}
                      </div>
                    </CardHeader>
                    <CardContent className="pt-0">
                      <CardDescription className="text-gray-600">
                        {contact.description}
                      </CardDescription>
                      {contact.hours && (
                        <div className="flex items-center gap-2 mt-2 text-sm text-gray-500">
                          <Clock className="h-4 w-4" />
                          {contact.hours}
                        </div>
                      )}
                    </CardContent>
                  </Card>
                ))}
              </div>
            </div>
          ))}

          {/* Important Notice */}
          <div className="bg-yellow-50 border border-yellow-200 rounded-xl p-4 mt-6">
            <div className="flex items-start gap-3">
              <AlertTriangle className="h-5 w-5 text-yellow-600 mt-0.5" />
              <div>
                <h4 className="font-semibold text-yellow-800 mb-1">Información Importante</h4>
                <p className="text-sm text-yellow-700">
                  Los horarios de atención pueden variar según la institución. 
                  Para emergencias reales, siempre utiliza el 9-1-1.
                </p>
              </div>
            </div>
          </div>

          {/* Additional Info */}
          <div className="bg-blue-50 border border-blue-200 rounded-xl p-4">
            <h4 className="font-semibold text-blue-800 mb-2">Oficina de Libre Acceso a la Información</h4>
            <p className="text-sm text-blue-700">
              Para solicitudes de información pública, puedes contactar directamente 
              a la Oficina de Libre Acceso a la Información Pública del gobierno dominicano.
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default CommunicationGuide;
