import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { 
  Home, Megaphone, Recycle, Trophy, Settings, LifeBuoy, Users, Briefcase, GitCompare, 
  BookOpen, Gem, AlarmClockOff, Siren, Trash2, LogOut, UserCog, BarChart3
} from 'lucide-react';
import { cn } from '@/lib/utils';
import { useAuth } from '@/hooks/useAuth';
import { useUserRoles } from '@/hooks/useUserRoles';
import { Button } from '@/components/ui/button';

const menuItems = [
  { href: '/', label: 'Inicio', icon: Home },
  { href: '/reportar', label: 'Reportar Incidencia', icon: Megaphone },
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
  const { user, signOut } = useAuth();
  const { isAdmin, isCommunityLeader } = useUserRoles();

  const handleLinkClick = () => {
    if (window.innerWidth < 768) {
      closeSidebar();
    }
  };

  const handleSignOut = async () => {
    try {
      await signOut();
      closeSidebar();
    } catch (error) {
      console.error('Error signing out:', error);
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

      {/* User Info */}
      {user && (
        <div className="p-4 border-b border-gray-200">
          <div className="flex items-center space-x-3">
            <div className="w-10 h-10 bg-gradient-to-br from-purple-400 to-blue-500 rounded-full flex items-center justify-center">
              <span className="text-white font-semibold text-sm">
                {user.email?.charAt(0).toUpperCase()}
              </span>
            </div>
            <div>
              <p className="text-sm font-semibold text-gray-800">{user.email}</p>
              <p className="text-xs text-gray-500">
                {isAdmin ? 'Administrador' : isCommunityLeader ? 'Líder Comunitario' : 'Usuario'}
              </p>
            </div>
          </div>
        </div>
      )}
      
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
          
          {/* Admin and Community Leader menu items */}
          {(isAdmin || isCommunityLeader) && (
            <li>
              <Link
                to="/reportes"
                onClick={handleLinkClick}
                className={cn(
                  'flex items-center p-3 rounded-xl transition-all duration-200 group',
                  location.pathname === '/reportes'
                    ? 'bg-gradient-to-r from-purple-500 to-blue-500 text-white font-semibold shadow-lg' 
                    : 'hover:bg-purple-50 hover:text-purple-700'
                )}
              >
                <BarChart3 className={cn(
                  "w-5 h-5 mr-3",
                  location.pathname === '/reportes' ? "text-white" : "text-purple-600"
                )} />
                <span className="text-sm">Reportes</span>
              </Link>
            </li>
          )}
          
          {/* Admin-only menu item */}
          {isAdmin && (
            <li>
              <Link
                to="/gestion-usuarios"
                onClick={handleLinkClick}
                className={cn(
                  'flex items-center p-3 rounded-xl transition-all duration-200 group',
                  location.pathname === '/gestion-usuarios'
                    ? 'bg-gradient-to-r from-purple-500 to-blue-500 text-white font-semibold shadow-lg' 
                    : 'hover:bg-purple-50 hover:text-purple-700'
                )}
              >
                <UserCog className={cn(
                  "w-5 h-5 mr-3",
                  location.pathname === '/gestion-usuarios' ? "text-white" : "text-purple-600"
                )} />
                <span className="text-sm">Gestión de Usuarios</span>
              </Link>
            </li>
          )}
        </ul>
      </nav>
      
      <div className="p-4 border-t border-gray-200 space-y-2">
        <Link 
          to="/configuracion" 
          onClick={handleLinkClick}
          className={cn(
            'flex items-center p-3 rounded-xl transition-all duration-200',
            location.pathname === '/configuracion'
              ? 'bg-gradient-to-r from-purple-500 to-blue-500 text-white font-semibold shadow-lg'
              : 'hover:bg-purple-50 hover:text-purple-700'
          )}
        >
          <Settings className={cn(
            "w-5 h-5 mr-3",
            location.pathname === '/configuracion' ? "text-white" : "text-purple-600"
          )} />
          <span className="text-sm">Configuración</span>
        </Link>
        <Link 
          to="/ayuda"
          onClick={handleLinkClick}
          className={cn(
            'flex items-center p-3 rounded-xl transition-all duration-200',
            location.pathname === '/ayuda'
              ? 'bg-gradient-to-r from-purple-500 to-blue-500 text-white font-semibold shadow-lg'
              : 'hover:bg-purple-50 hover:text-purple-700'
          )}
        >
          <LifeBuoy className={cn(
            "w-5 h-5 mr-3",
            location.pathname === '/ayuda' ? "text-white" : "text-purple-600"
          )} />
          <span className="text-sm">Ayuda</span>
        </Link>
        <Button
          onClick={handleSignOut}
          variant="ghost"
          className="w-full justify-start p-3 rounded-xl hover:bg-red-50 hover:text-red-700 transition-all duration-200"
        >
          <LogOut className="w-5 h-5 mr-3 text-red-600" />
          <span className="text-sm">Cerrar Sesión</span>
        </Button>
      </div>
    </div>
  );
};

export default AppSidebar;
