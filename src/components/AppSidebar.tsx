
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
    if (window.innerWidth < 768) { // md breakpoint
      closeSidebar();
    }
  };

  return (
    <div className="flex flex-col h-full text-gray-700 dark:text-gray-200 bg-white dark:bg-gray-900 border-r dark:border-gray-200 dark:border-gray-800">
      <div className="p-4 flex items-center justify-center border-b dark:border-gray-800">
        <img src="/logo.svg" alt="CiudadConecta Logo" className="h-10 w-10 mr-3" />
        <h1 className="text-2xl font-bold text-primary">CiudadConecta</h1>
      </div>
      <nav className="flex-grow p-4 overflow-y-auto">
        <ul>
          {menuItems.map((item) => (
            <li key={item.href} className="mb-2">
              <Link
                to={item.href}
                onClick={handleLinkClick}
                className={cn(
                  'flex items-center p-3 rounded-lg hover:bg-primary/10 transition-colors duration-200',
                  location.pathname === item.href ? 'bg-primary/20 text-primary font-semibold' : 'hover:text-primary'
                )}
              >
                <item.icon className="w-5 h-5 mr-3" />
                <span className="text-sm">{item.label}</span>
              </Link>
            </li>
          ))}
        </ul>
      </nav>
      <div className="p-4 border-t dark:border-gray-800">
        <Link to="#" className="flex items-center p-3 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors duration-200">
          <Settings className="w-5 h-5 mr-3" />
          <span>Configuración</span>
        </Link>
        <Link to="#" className="flex items-center p-3 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors duration-200">
          <LifeBuoy className="w-5 h-5 mr-3" />
          <span>Ayuda</span>
        </Link>
      </div>
    </div>
  );
};

export default AppSidebar;
