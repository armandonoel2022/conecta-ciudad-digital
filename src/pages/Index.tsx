
import { Button } from "@/components/ui/button";
import { Card, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Megaphone, Trash2, Recycle, Siren, AlarmClockOff } from "lucide-react";
import { Link } from "react-router-dom";
import { useAuth } from "@/hooks/useAuth";
import { useState, useEffect } from "react";
import { supabase } from "@/integrations/supabase/client";

const features = [
  {
    title: "Reportar Incidencia",
    description: "Informa sobre problemas en tu área.",
    icon: Megaphone,
    href: "/reportar",
    gradient: "from-purple-500 to-purple-600",
  },
  {
    title: "Pago de Basura",
    description: "Realiza el pago de tu servicio.",
    icon: Trash2,
    href: "/pago-basura",
    gradient: "from-blue-500 to-purple-500",
  },
  {
    title: "Guía de Reciclaje",
    description: "Aprende a separar tus residuos.",
    icon: Recycle,
    href: "/guia-reciclaje",
    gradient: "from-purple-600 to-pink-500",
  },
  {
    title: "Botón de Pánico",
    description: "Alerta a las autoridades en emergencias.",
    icon: AlarmClockOff,
    href: "/boton-panico",
    gradient: "from-red-500 to-red-600",
  },
  {
    title: "Alerta Amber",
    description: "Ayuda a encontrar a menores desaparecidos.",
    icon: Siren,
    href: "/alerta-amber",
    gradient: "from-purple-500 to-pink-600",
  },
];

const Index = () => {
  const { user } = useAuth();
  const [userProfile, setUserProfile] = useState<{ first_name: string | null } | null>(null);

  useEffect(() => {
    const fetchUserProfile = async () => {
      if (user) {
        try {
          const { data, error } = await supabase
            .from('profiles')
            .select('first_name')
            .eq('id', user.id)
            .single();

          if (error && error.code !== 'PGRST116') { // PGRST116 is "no rows returned"
            console.error('Error fetching user profile:', error);
          } else if (data) {
            setUserProfile(data);
          }
        } catch (error) {
          console.error('Error fetching user profile:', error);
        }
      }
    };

    fetchUserProfile();
  }, [user]);

  const getUserGreeting = () => {
    if (userProfile?.first_name) {
      return `¡Hola, ${userProfile.first_name}!`;
    }
    return user?.email ? `¡Hola!` : 'Bienvenido';
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-600 via-blue-600 to-indigo-700 p-4 animate-fade-in">
      <div className="max-w-md mx-auto space-y-6">
        {/* Hero Section */}
        <div className="bg-white/10 backdrop-blur-sm p-8 rounded-[2rem] shadow-xl text-center text-white relative overflow-hidden">
          <div className="absolute inset-0 bg-gradient-to-br from-white/20 to-transparent rounded-[2rem]"></div>
          <div className="relative z-10">
            <h1 className="text-3xl font-bold tracking-tight mb-3">
                <br />
              <span className="text-4xl font-extrabold">CiudadConecta</span>
            </h1>
            <p className="text-lg text-white/90 mb-6 leading-relaxed">
              Tu voz para una ciudad mejor. Reporta, consulta y participa.
            </p>
            {user && (
              <div className="mb-6 p-4 bg-white/10 rounded-xl">
                <p className="text-lg font-semibold">{getUserGreeting()}</p>
                <p className="text-sm text-white/80 mt-1">Tu participación hace la diferencia</p>
              </div>
            )}
            <Button asChild size="lg" className="bg-purple-600 hover:bg-purple-700 text-white font-bold px-12 py-3 rounded-2xl text-lg shadow-lg transform hover:scale-105 transition-all">
              <Link to="/reportar">COMENZAR</Link>
            </Button>
          </div>
        </div>

        {/* Services Section */}
        <div className="bg-white rounded-[2rem] p-6 shadow-xl">
          <div className="text-center mb-6">
            <h2 className="text-2xl font-bold text-gray-800 mb-2">SERVICIOS PRINCIPALES</h2>
          </div>
          
          <div className="space-y-4">
            {features.map((feature, index) => (
              <Link to={feature.href} key={feature.title} className="block group">
                <div className={`bg-gradient-to-r ${feature.gradient} p-6 rounded-2xl shadow-lg transform hover:scale-105 transition-all duration-300 hover:shadow-xl`}>
                  <div className="flex items-center gap-4">
                    <div className="bg-white/20 p-3 rounded-xl backdrop-blur-sm">
                      <feature.icon className="h-6 w-6 text-white" />
                    </div>
                    <div className="flex-1 text-white">
                      <h3 className="font-bold text-lg leading-tight">{feature.title}</h3>
                      <p className="text-white/90 text-sm mt-1">{feature.description}</p>
                    </div>
                    <div className="bg-white/20 rounded-full p-2 backdrop-blur-sm">
                      <div className="w-2 h-2 bg-white rounded-full"></div>
                    </div>
                  </div>
                </div>
              </Link>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Index;
