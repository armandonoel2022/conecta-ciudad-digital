
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
    gradient: "from-primary to-blue-600",
  },
  {
    title: "Pago de Basura",
    description: "Realiza el pago de tu servicio.",
    icon: Trash2,
    href: "/pago-basura",
    gradient: "from-blue-500 to-primary",
  },
  {
    title: "Guía de Reciclaje",
    description: "Aprende a separar tus residuos.",
    icon: Recycle,
    href: "/guia-reciclaje",
    gradient: "from-primary to-blue-500",
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
    gradient: "from-amber to-amber-foreground",
  },
];

const Index = () => {
  const { user } = useAuth();
  const [userProfile, setUserProfile] = useState<{ first_name: string | null } | null>(null);
  const [userActivity, setUserActivity] = useState<{
    reportsCount: number;
    pendingBills: number;
    isNewUser: boolean;
  }>({ reportsCount: 0, pendingBills: 0, isNewUser: true });
  const [activityLoading, setActivityLoading] = useState(true);

  useEffect(() => {
    const fetchUserData = async () => {
      if (user) {
        setActivityLoading(true);
        try {
          // Fetch user profile
          const { data: profile, error: profileError } = await supabase
            .from('profiles')
            .select('first_name, created_at')
            .eq('id', user.id)
            .single();

          if (profileError && profileError.code !== 'PGRST116') {
            console.error('Error fetching user profile:', profileError);
          } else if (profile) {
            setUserProfile(profile);
          }

          // Fetch user reports count
          const { count: reportsCount } = await supabase
            .from('reports')
            .select('*', { count: 'exact', head: true })
            .eq('user_id', user.id);

          // Fetch pending bills count
          const { count: pendingBills } = await supabase
            .from('garbage_bills')
            .select('*', { count: 'exact', head: true })
            .eq('user_id', user.id)
            .eq('status', 'pending');

          // Determine if user is new (less than 3 reports and account created recently)
          const accountAge = profile?.created_at ? 
            (Date.now() - new Date(profile.created_at).getTime()) / (1000 * 60 * 60 * 24) : 0;
          
          const isNewUser = (reportsCount || 0) < 3 && accountAge < 30;

          setUserActivity({
            reportsCount: reportsCount || 0,
            pendingBills: pendingBills || 0,
            isNewUser
          });
        } catch (error) {
          console.error('Error fetching user data:', error);
        } finally {
          setActivityLoading(false);
        }
      } else {
        setActivityLoading(false);
      }
    };

    fetchUserData();
  }, [user]);

  const getUserGreeting = () => {
    if (userProfile?.first_name) {
      return `¡Hola, ${userProfile.first_name}!`;
    }
    return user?.email ? `¡Hola!` : 'Bienvenido';
  };

  const getContextualButton = () => {
    if (!user) {
      return {
        text: "COMENZAR",
        href: "/auth",
        description: "Inicia sesión para acceder a todos los servicios"
      };
    }

    if (userActivity.isNewUser) {
      return {
        text: "CONOCE LA PLATAFORMA",
        href: "/tutorial",
        description: "Descubre cómo usar CiudadConecta paso a paso"
      };
    }

    if (userActivity.pendingBills > 0) {
      return {
        text: `PAGAR FACTURAS (${userActivity.pendingBills})`,
        href: "/pago-basura",
        description: "Tienes facturas pendientes de pago"
      };
    }

    if (userActivity.reportsCount > 0) {
      return {
        text: "VER MIS REPORTES",
        href: "/mis-reportes",
        description: "Revisa el estado de tus reportes"
      };
    }

    return {
      text: "REPORTAR INCIDENCIA",
      href: "/reportar",
      description: "Reporta problemas en tu comunidad"
    };
  };

  const contextualButton = getContextualButton();

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 animate-fade-in">
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
                <p className="text-sm text-white/80 mt-1">{contextualButton.description}</p>
                {!activityLoading && userActivity.reportsCount > 0 && (
                  <div className="mt-2 text-xs text-white/70">
                    {userActivity.reportsCount} reporte(s) • {userActivity.pendingBills} factura(s) pendiente(s)
                  </div>
                )}
              </div>
            )}
            <Button asChild size="lg" className="bg-primary hover:bg-primary/90 text-white font-bold px-12 py-3 rounded-2xl text-lg shadow-lg transform hover:scale-105 transition-all">
              <Link to={contextualButton.href}>{contextualButton.text}</Link>
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
