
import { useState, useEffect } from 'react';
import { useAuth } from '@/hooks/useAuth';
import { supabase } from '@/integrations/supabase/client';

export type UserRole = 'admin' | 'community_leader' | 'community_user';

interface UserRoleData {
  id: string;
  user_id: string;
  role: UserRole;
  assigned_by: string | null;
  assigned_at: string;
  is_active: boolean;
}

export const useUserRoles = () => {
  const { user } = useAuth();
  const [userRoles, setUserRoles] = useState<UserRole[]>([]);
  const [loading, setLoading] = useState(true);
  const [isAdmin, setIsAdmin] = useState(false);
  const [isCommunityLeader, setIsCommunityLeader] = useState(false);

  useEffect(() => {
    if (user) {
      fetchUserRoles();
    } else {
      setUserRoles([]);
      setIsAdmin(false);
      setIsCommunityLeader(false);
      setLoading(false);
    }
  }, [user]);

  const fetchUserRoles = async () => {
    if (!user) return;

    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('user_roles')
        .select('*')
        .eq('user_id', user.id)
        .eq('is_active', true);

      if (error) {
        console.error('Error fetching user roles:', error);
        return;
      }

      const roles = data?.map((role: UserRoleData) => role.role) || [];
      setUserRoles(roles);
      setIsAdmin(roles.includes('admin'));
      setIsCommunityLeader(roles.includes('community_leader'));
    } catch (error) {
      console.error('Error fetching user roles:', error);
    } finally {
      setLoading(false);
    }
  };

  const assignRole = async (userId: string, role: UserRole) => {
    if (!user || !isAdmin) {
      throw new Error('Solo los administradores pueden asignar roles');
    }

    try {
      // Definir jerarquía de roles
      const roleHierarchy = {
        'community_user': 1,
        'community_leader': 2,
        'admin': 3
      };

      // Si se asigna un rol superior, desactivar roles inferiores
      if (role === 'admin' || role === 'community_leader') {
        const rolesToDeactivate = [];
        
        if (role === 'admin') {
          rolesToDeactivate.push('community_user', 'community_leader');
        } else if (role === 'community_leader') {
          rolesToDeactivate.push('community_user');
        }

        // Desactivar roles inferiores
        for (const roleToDeactivate of rolesToDeactivate) {
          await supabase
            .from('user_roles')
            .update({ is_active: false })
            .eq('user_id', userId)
            .eq('role', roleToDeactivate)
            .eq('is_active', true);
        }
      }

      // Asignar el nuevo rol
      const { error } = await supabase
        .from('user_roles')
        .insert({
          user_id: userId,
          role: role,
          assigned_by: user.id
        });

      if (error) throw error;
      
      console.log(`Rol ${role} asignado exitosamente al usuario ${userId}`);
      return true;
    } catch (error) {
      console.error('Error assigning role:', error);
      throw error;
    }
  };

  const removeRole = async (userId: string, role: UserRole) => {
    if (!user || !isAdmin) {
      throw new Error('Solo los administradores pueden remover roles');
    }

    try {
      const { error } = await supabase
        .from('user_roles')
        .update({ is_active: false })
        .eq('user_id', userId)
        .eq('role', role);

      if (error) throw error;
      
      console.log(`Rol ${role} removido exitosamente del usuario ${userId}`);
      return true;
    } catch (error) {
      console.error('Error removing role:', error);
      throw error;
    }
  };

  const getAllUserRoles = async () => {
    if (!user || !isAdmin) {
      throw new Error('Solo los administradores pueden ver todos los roles');
    }

    try {
      const { data, error } = await supabase
        .from('user_roles')
        .select('*')
        .eq('is_active', true)
        .order('assigned_at', { ascending: false });

      if (error) throw error;
      return data;
    } catch (error) {
      console.error('Error fetching all user roles:', error);
      throw error;
    }
  };

  return {
    userRoles,
    loading,
    isAdmin,
    isCommunityLeader,
    assignRole,
    removeRole,
    getAllUserRoles,
    refreshRoles: fetchUserRoles
  };
};
