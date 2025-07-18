import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { 
  Home, Megaphone, Recycle, Trophy, Settings, LifeBuoy, Users, Briefcase, GitCompare, 
  BookOpen, Gem, AlarmClockOff, Siren, Trash2, LogOut, UserCog, BarChart3, FileText, ClipboardList, MessageSquare, Bell
} from 'lucide-react';
import { cn } from '@/lib/utils';
import { useAuth } from '@/hooks/useAuth';
import { useUserRoles } from '@/hooks/useUserRoles';
import { Button } from '@/components/ui/button';
import logoCiudadConecta from '@/assets/logo-ciudadconecta-v2-simple.png';

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
    <div className="flex flex-col h-full text-foreground bg-background/95 backdrop-blur-sm border-r border-border">
      <div className="p-6 flex items-center justify-center border-b border-border">
        <div className="w-10 h-10 rounded-xl flex items-center justify-center mr-3">
          <img 
            src={logoCiudadConecta} 
            alt="CiudadConecta" 
            className="w-full h-full object-contain"
          />
        </div>
        <h1 className="text-2xl font-bold bg-gradient-to-r from-primary to-blue-600 bg-clip-text text-transparent">CiudadConecta</h1>
      </div>

      {/* User Info */}
      {user && (
        <div className="p-4 border-b border-border">
          <div className="flex items-center space-x-3">
            <div className="w-10 h-10 bg-gradient-to-br from-primary to-blue-500 rounded-full flex items-center justify-center">
              <span className="text-primary-foreground font-semibold text-sm">
                {user.email?.charAt(0).toUpperCase()}
              </span>
            </div>
            <div>
              <p className="text-sm font-semibold text-foreground">{user.email}</p>
              <p className="text-xs text-muted-foreground">
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
                    ? 'bg-gradient-to-r from-primary to-blue-500 text-primary-foreground font-semibold shadow-lg' 
                    : 'hover:bg-accent hover:text-accent-foreground'
                )}
              >
                <item.icon className={cn(
                  "w-5 h-5 mr-3",
                  location.pathname === item.href ? "text-primary-foreground" : "text-primary"
                )} />
                <span className="text-sm">{item.label}</span>
              </Link>
            </li>
          ))}
          
          {/* Mis Reportes - Available for all authenticated users */}
          {user && (
            <li>
              <Link
                to="/mis-reportes"
                onClick={handleLinkClick}
                className={cn(
                  'flex items-center p-3 rounded-xl transition-all duration-200 group',
                  location.pathname === '/mis-reportes'
                    ? 'bg-gradient-to-r from-primary to-blue-500 text-primary-foreground font-semibold shadow-lg' 
                    : 'hover:bg-accent hover:text-accent-foreground'
                )}
              >
                <FileText className={cn(
                  "w-5 h-5 mr-3",
                  location.pathname === '/mis-reportes' ? "text-primary-foreground" : "text-primary"
                )} />
                <span className="text-sm">Mis Reportes</span>
              </Link>
            </li>
          )}
          
          {/* Admin and Community Leader menu items */}
          {(isAdmin || isCommunityLeader) && (
            <li>
              <Link
                to="/gestion-reportes"
                onClick={handleLinkClick}
                className={cn(
                  'flex items-center p-3 rounded-xl transition-all duration-200 group',
                  location.pathname === '/gestion-reportes'
                    ? 'bg-gradient-to-r from-primary to-blue-500 text-primary-foreground font-semibold shadow-lg' 
                    : 'hover:bg-accent hover:text-accent-foreground'
                )}
              >
                <ClipboardList className={cn(
                  "w-5 h-5 mr-3",
                  location.pathname === '/gestion-reportes' ? "text-primary-foreground" : "text-primary"
                )} />
                <span className="text-sm">Gestionar Reportes</span>
              </Link>
            </li>
          )}
          
          {/* Reports Analytics */}
          {(isAdmin || isCommunityLeader) && (
            <li>
              <Link
                to="/reportes"
                onClick={handleLinkClick}
                className={cn(
                  'flex items-center p-3 rounded-xl transition-all duration-200 group',
                  location.pathname === '/reportes'
                    ? 'bg-gradient-to-r from-primary to-blue-500 text-primary-foreground font-semibold shadow-lg' 
                    : 'hover:bg-accent hover:text-accent-foreground'
                )}
              >
                <BarChart3 className={cn(
                  "w-5 h-5 mr-3",
                  location.pathname === '/reportes' ? "text-primary-foreground" : "text-primary"
                )} />
                <span className="text-sm">Análisis de Reportes</span>
              </Link>
            </li>
          )}
          
          {/* Community Messages - Available for Community Leaders and Admins */}
          {(isAdmin || isCommunityLeader) && (
            <li>
              <Link
                to="/mensajes-comunitarios"
                onClick={handleLinkClick}
                className={cn(
                  'flex items-center p-3 rounded-xl transition-all duration-200 group',
                  location.pathname === '/mensajes-comunitarios'
                    ? 'bg-gradient-to-r from-primary to-blue-500 text-primary-foreground font-semibold shadow-lg' 
                    : 'hover:bg-accent hover:text-accent-foreground'
                )}
              >
                <MessageSquare className={cn(
                  "w-5 h-5 mr-3",
                  location.pathname === '/mensajes-comunitarios' ? "text-primary-foreground" : "text-primary"
                )} />
                <span className="text-sm">Mensajes Comunitarios</span>
              </Link>
            </li>
          )}
          
          {/* Garbage Alert Management - Admin only */}
          {isAdmin && (
            <li>
              <Link
                to="/gestion-alertas-basura"
                onClick={handleLinkClick}
                className={cn(
                  'flex items-center p-3 rounded-xl transition-all duration-200 group',
                  location.pathname === '/gestion-alertas-basura'
                    ? 'bg-gradient-to-r from-primary to-blue-500 text-primary-foreground font-semibold shadow-lg' 
                    : 'hover:bg-accent hover:text-accent-foreground'
                )}
              >
                <Bell className={cn(
                  "w-5 h-5 mr-3",
                  location.pathname === '/gestion-alertas-basura' ? "text-primary-foreground" : "text-primary"
                )} />
                <span className="text-sm">Alertas de Basura</span>
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
                    ? 'bg-gradient-to-r from-primary to-blue-500 text-primary-foreground font-semibold shadow-lg' 
                    : 'hover:bg-accent hover:text-accent-foreground'
                )}
              >
                <UserCog className={cn(
                  "w-5 h-5 mr-3",
                  location.pathname === '/gestion-usuarios' ? "text-primary-foreground" : "text-primary"
                )} />
                <span className="text-sm">Gestión de Usuarios</span>
              </Link>
            </li>
          )}
        </ul>
      </nav>
      
      <div className="p-4 border-t border-border space-y-2">
        <Link 
          to="/configuracion" 
          onClick={handleLinkClick}
          className={cn(
            'flex items-center p-3 rounded-xl transition-all duration-200',
            location.pathname === '/configuracion'
              ? 'bg-gradient-to-r from-primary to-blue-500 text-primary-foreground font-semibold shadow-lg'
              : 'hover:bg-accent hover:text-accent-foreground'
          )}
        >
          <Settings className={cn(
            "w-5 h-5 mr-3",
            location.pathname === '/configuracion' ? "text-primary-foreground" : "text-primary"
          )} />
          <span className="text-sm">Configuración</span>
        </Link>
        <Link 
          to="/ayuda"
          onClick={handleLinkClick}
          className={cn(
            'flex items-center p-3 rounded-xl transition-all duration-200',
            location.pathname === '/ayuda'
              ? 'bg-gradient-to-r from-primary to-blue-500 text-primary-foreground font-semibold shadow-lg'
              : 'hover:bg-accent hover:text-accent-foreground'
          )}
        >
          <LifeBuoy className={cn(
            "w-5 h-5 mr-3",
            location.pathname === '/ayuda' ? "text-primary-foreground" : "text-primary"
          )} />
          <span className="text-sm">Ayuda</span>
        </Link>
        <Button
          onClick={handleSignOut}
          variant="ghost"
          className="w-full justify-start p-3 rounded-xl hover:bg-destructive/10 hover:text-destructive transition-all duration-200"
        >
          <LogOut className="w-5 h-5 mr-3 text-destructive" />
          <span className="text-sm">Cerrar Sesión</span>
        </Button>
      </div>
    </div>
  );
};

export default AppSidebar;
