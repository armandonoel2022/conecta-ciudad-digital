
import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { 
  Home, Megaphone, Recycle, Trophy, Settings, LifeBuoy, Users, Briefcase, GitCompare, 
  BookOpen, Gem, AlarmClockOff, Siren, Trash2, LightbulbOff
} from 'lucide-react';
import { cn } from '@/lib/utils';

const menuItems = [
  { href: '/', label: 'Inicio', icon: Home },
  { href: '/reportar', label: 'Reportar Incidencia', icon: Megaphone },
  { href: '/reportar-iluminacion', label: 'Falta de Iluminación', icon: LightbulbOff },
  { href: '/pago-basura', label: 'Pago de basura', icon: Trash2 },
  { href: '/guia-reciclaje', label: 'Guía de Reciclaje', icon: Recycle },
  { href: '/guia-comunicacion', label: 'Guía de comunicación', icon: BookOpen },
  { href: '/logros', label: 'Logros', icon: Trophy },
  { href: '/antes-y-despues', label: 'Antes y después', icon: GitCompare },
  { href: '/oportunidades', label: 'Oportunidades', icon: Briefcase },
  { href: '/quienes-somos', label: '¿Quiénes somos?', icon: Users },
  { href: '/mision-vision-valores', label: 'Misión, visión y valores', icon: Gem },
  { href: '/boton-panico', label: 'Botón de pánico', icon: AlarmClockOff },
  { href: '/alerta-amber', label: 'Alerta Amber', icon: Siren },
];

const AppSidebar = ({ closeSidebar }: { closeSidebar: () => void }) => {
  const location = useLocation();

  const handleLinkClick = () => {
    if (window.innerWidth < 768) {
      closeSidebar();
    }
  };

  return (
    <div className="flex flex-col h-full text-gray-700 bg-white/95 backdrop-blur-sm">
      <div className="p-6 flex items-center justify-center border-b border-gray-200">
        <div className="w-10 h-10 bg-gradient-to-br from-purple-500 to-blue-600 rounded-xl flex items-center justify-center mr-3">
          <div className="w-5 h-5 bg-white rounded-md"></div>
        </div>
        <h1 className="text-2xl font-bold bg-gradient-to-r from-purple-600 to-blue-600 bg-clip-text text-transparent">CiudadConecta</h1>
      </div>
      
      <nav className="flex-grow p-4 overflow-y-auto">
        <ul className="space-y-2">
          {menuItems.map((item) => (
            <li key={item.href}>
              <Link
                to={item.href}
                onClick={handleLinkClick}
                className={cn(
                  'flex items-center p-3 rounded-xl transition-all duration-200 group',
                  location.pathname === item.href 
                    ? 'bg-gradient-to-r from-purple-500 to-blue-500 text-white font-semibold shadow-lg' 
                    : 'hover:bg-purple-50 hover:text-purple-700'
                )}
              >
                <item.icon className={cn(
                  "w-5 h-5 mr-3",
                  location.pathname === item.href ? "text-white" : "text-purple-600"
                )} />
                <span className="text-sm">{item.label}</span>
              </Link>
            </li>
          ))}
        </ul>
      </nav>
      
      <div className="p-4 border-t border-gray-200 space-y-2">
        <Link to="#" className="flex items-center p-3 rounded-xl hover:bg-purple-50 hover:text-purple-700 transition-all duration-200">
          <Settings className="w-5 h-5 mr-3 text-purple-600" />
          <span className="text-sm">Configuración</span>
        </Link>
        <Link to="#" className="flex items-center p-3 rounded-xl hover:bg-purple-50 hover:text-purple-700 transition-all duration-200">
          <LifeBuoy className="w-5 h-5 mr-3 text-purple-600" />
          <span className="text-sm">Ayuda</span>
        </Link>
      </div>
    </div>
  );
};

export default AppSidebar;
