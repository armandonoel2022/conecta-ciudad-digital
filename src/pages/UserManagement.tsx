
import React from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import UserRoleManager from '@/components/UserRoleManager';
import { useUserRoles } from '@/hooks/useUserRoles';
import { Users, Shield, Crown, UserCheck } from 'lucide-react';

const UserManagement = () => {
  const { isAdmin, userRoles, loading } = useUserRoles();

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-purple-600 via-blue-600 to-indigo-700 p-4 flex items-center justify-center">
        <div className="bg-white/10 backdrop-blur-sm p-8 rounded-2xl">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-white mx-auto"></div>
          <p className="text-white mt-4">Cargando...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-600 via-blue-600 to-indigo-700 p-4">
      <div className="max-w-6xl mx-auto space-y-6">
        {/* Header */}
        <div className="bg-white/10 backdrop-blur-sm p-6 rounded-2xl shadow-xl text-white">
          <div className="flex items-center gap-3 mb-4">
            <Users className="h-8 w-8" />
            <h1 className="text-3xl font-bold">Gestión de Usuarios</h1>
          </div>
          <p className="text-white/90">
            Administra los roles y permisos de los usuarios del sistema
          </p>
        </div>

        {/* User Info Card */}
        <Card className="bg-white/95 backdrop-blur-sm">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <UserCheck className="h-5 w-5" />
              Tu Información
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="flex items-center gap-4">
              <div className="flex-1">
                <p className="text-sm text-gray-600">Roles asignados:</p>
                <div className="flex gap-2 mt-1">
                  {userRoles.length > 0 ? (
                    userRoles.map(role => {
                      const roleConfig = {
                        admin: { label: 'Administrador', icon: Crown, color: 'bg-red-100 text-red-800' },
                        community_leader: { label: 'Líder Comunitario', icon: Shield, color: 'bg-blue-100 text-blue-800' },
                        community_user: { label: 'Usuario Comunitario', icon: Users, color: 'bg-green-100 text-green-800' }
                      };
                      
                      const config = roleConfig[role as keyof typeof roleConfig];
                      const Icon = config.icon;
                      
                      return (
                        <div key={role} className={`px-3 py-1 rounded-full text-sm font-medium flex items-center gap-1 ${config.color}`}>
                          <Icon className="w-4 h-4" />
                          {config.label}
                        </div>
                      );
                    })
                  ) : (
                    <span className="px-3 py-1 bg-gray-100 text-gray-600 rounded-full text-sm">
                      Usuario Comunitario (por defecto)
                    </span>
                  )}
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Role Management */}
        <div className="bg-white/95 backdrop-blur-sm rounded-2xl p-6 shadow-xl">
          <UserRoleManager />
        </div>

        {/* Role Descriptions */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <Card className="bg-white/95 backdrop-blur-sm">
            <CardHeader className="pb-3">
              <CardTitle className="flex items-center gap-2 text-green-700">
                <Users className="h-5 w-5" />
                Usuario Comunitario
              </CardTitle>
            </CardHeader>
            <CardContent>
              <CardDescription>
                • Reportar incidencias<br/>
                • Ver guías de reciclaje<br/>
                • Usar botón de pánico<br/>
                • Pagar servicios de basura
              </CardDescription>
            </CardContent>
          </Card>

          <Card className="bg-white/95 backdrop-blur-sm">
            <CardHeader className="pb-3">
              <CardTitle className="flex items-center gap-2 text-blue-700">
                <Shield className="h-5 w-5" />
                Líder Comunitario
              </CardTitle>
            </CardHeader>
            <CardContent>
              <CardDescription>
                • Todas las funciones de usuario<br/>
                • Gestionar reportes de su área<br/>
                • Ver estadísticas comunitarias<br/>
                • Moderar contenido local
              </CardDescription>
            </CardContent>
          </Card>

          <Card className="bg-white/95 backdrop-blur-sm">
            <CardHeader className="pb-3">
              <CardTitle className="flex items-center gap-2 text-red-700">
                <Crown className="h-5 w-5" />
                Administrador
              </CardTitle>
            </CardHeader>
            <CardContent>
              <CardDescription>
                • Control total del sistema<br/>
                • Gestionar todos los usuarios<br/>
                • Asignar y remover roles<br/>
                • Acceso a todas las funciones
              </CardDescription>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
};

export default UserManagement;
