
import React, { useState, useEffect } from 'react';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Badge } from '@/components/ui/badge';
import { useUserRoles, UserRole } from '@/hooks/useUserRoles';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';
import { Users, Shield, Crown } from 'lucide-react';

interface UserProfile {
  id: string;
  full_name: string | null;
  first_name: string | null;
  last_name: string | null;
}

interface UserWithRoles extends UserProfile {
  roles: UserRole[];
}

const roleConfig = {
  admin: { label: 'Administrador', icon: Crown, color: 'bg-red-500' },
  community_leader: { label: 'Líder Comunitario', icon: Shield, color: 'bg-blue-500' },
  community_user: { label: 'Usuario Comunitario', icon: Users, color: 'bg-green-500' }
};

const UserRoleManager = () => {
  const { isAdmin, assignRole, removeRole, getAllUserRoles } = useUserRoles();
  const { toast } = useToast();
  const [users, setUsers] = useState<UserWithRoles[]>([]);
  const [selectedUser, setSelectedUser] = useState<string>('');
  const [selectedRole, setSelectedRole] = useState<UserRole>('community_user');
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (isAdmin) {
      fetchUsersWithRoles();
    }
  }, [isAdmin]);

  const fetchUsersWithRoles = async () => {
    try {
      setLoading(true);
      
      // Obtener todos los perfiles (ahora los admins pueden ver todos)
      const { data: allProfiles, error: profilesError } = await supabase
        .from('profiles')
        .select('id, full_name, first_name, last_name, created_at')
        .order('created_at', { ascending: false });
        
      if (profilesError) {
        console.error('Error obteniendo perfiles:', profilesError);
        throw profilesError;
      }
      
      if (!allProfiles || allProfiles.length === 0) {
        setUsers([]);
        return;
      }
      
      // Para cada perfil, obtener sus roles
      const usersWithRoles = await Promise.all(
        allProfiles.map(async (profile) => {
          const { data: roles } = await supabase
            .from('user_roles')
            .select('role')
            .eq('user_id', profile.id)
            .eq('is_active', true);
          
          return {
            ...profile,
            roles: roles?.map(r => r.role) || []
          };
        })
      );
      
      console.log(`✅ Usuarios cargados: ${usersWithRoles.length} de ${allProfiles.length} perfiles`);
      setUsers(usersWithRoles);

    } catch (error) {
      console.error('Error fetching users with roles:', error);
      toast({
        title: 'Error',
        description: 'No se pudieron cargar los usuarios y roles',
        variant: 'destructive'
      });
    } finally {
      setLoading(false);
    }
  };

  const handleAssignRole = async () => {
    if (!selectedUser || !selectedRole) {
      toast({
        title: 'Error',
        description: 'Por favor selecciona un usuario y un rol',
        variant: 'destructive'
      });
      return;
    }

    try {
      await assignRole(selectedUser, selectedRole);
      toast({
        title: 'Éxito',
        description: 'Rol asignado correctamente',
      });
      fetchUsersWithRoles();
      setSelectedUser('');
    } catch (error) {
      toast({
        title: 'Error',
        description: 'No se pudo asignar el rol',
        variant: 'destructive'
      });
    }
  };

  const handleRemoveRole = async (userId: string, role: UserRole) => {
    try {
      await removeRole(userId, role);
      toast({
        title: 'Éxito',
        description: 'Rol removido correctamente',
      });
      fetchUsersWithRoles();
    } catch (error) {
      toast({
        title: 'Error',
        description: 'No se pudo remover el rol',
        variant: 'destructive'
      });
    }
  };

  const getUserDisplayName = (user: UserProfile) => {
    return user.full_name || `${user.first_name || ''} ${user.last_name || ''}`.trim() || 'Usuario sin nombre';
  };

  if (!isAdmin) {
    return (
      <Card>
        <CardContent className="p-6">
          <p className="text-center text-gray-500">
            Solo los administradores pueden gestionar roles de usuario.
          </p>
        </CardContent>
      </Card>
    );
  }

  return (
    <div className="space-y-6">
      <Card>
        <CardHeader>
          <CardTitle>Asignar Nuevo Rol</CardTitle>
          <CardDescription>
            Selecciona un usuario y asígnale un rol específico
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <Select value={selectedUser} onValueChange={setSelectedUser}>
              <SelectTrigger>
                <SelectValue placeholder="Seleccionar usuario" />
              </SelectTrigger>
              <SelectContent>
                {users.map(user => (
                  <SelectItem key={user.id} value={user.id}>
                    {getUserDisplayName(user)}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>

            <Select value={selectedRole} onValueChange={(value: UserRole) => setSelectedRole(value)}>
              <SelectTrigger>
                <SelectValue placeholder="Seleccionar rol" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="community_user">Usuario Comunitario</SelectItem>
                <SelectItem value="community_leader">Líder Comunitario</SelectItem>
                <SelectItem value="admin">Administrador</SelectItem>
              </SelectContent>
            </Select>

            <Button onClick={handleAssignRole} disabled={loading}>
              Asignar Rol
            </Button>
          </div>
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle>Usuarios y Roles Actuales</CardTitle>
          <CardDescription>
            Gestiona los roles de todos los usuarios del sistema
          </CardDescription>
        </CardHeader>
        <CardContent>
          {loading ? (
            <p className="text-center text-gray-500">Cargando usuarios...</p>
          ) : (
            <div className="space-y-4">
              {users.map(user => (
                <div key={user.id} className="flex items-center justify-between p-4 border rounded-lg">
                  <div>
                    <h3 className="font-semibold">{getUserDisplayName(user)}</h3>
                    <div className="flex gap-2 mt-2">
                      {user.roles.length > 0 ? (
                        user.roles.map(role => {
                          const config = roleConfig[role];
                          const Icon = config.icon;
                          return (
                            <Badge key={role} variant="secondary" className="flex items-center gap-1">
                              <Icon className="w-3 h-3" />
                              {config.label}
                            </Badge>
                          );
                        })
                      ) : (
                        <Badge variant="outline">Sin roles asignados</Badge>
                      )}
                    </div>
                  </div>
                  <div className="flex gap-2">
                    {user.roles.map(role => (
                      <Button
                        key={role}
                        variant="outline"
                        size="sm"
                        onClick={() => handleRemoveRole(user.id, role)}
                      >
                        Remover {roleConfig[role].label}
                      </Button>
                    ))}
                  </div>
                </div>
              ))}
              {users.length === 0 && (
                <p className="text-center text-gray-500">No hay usuarios registrados</p>
              )}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
};

export default UserRoleManager;
