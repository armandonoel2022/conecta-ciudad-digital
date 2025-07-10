import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from './useAuth';
import { TOTP } from 'otpauth';
import QRCode from 'qrcode';
import { toast } from 'sonner';

interface User2FA {
  id: string;
  user_id: string;
  secret: string;
  enabled: boolean;
  backup_codes: string[];
  created_at: string;
  updated_at: string;
  last_used_at: string | null;
}

export const use2FA = () => {
  const { user } = useAuth();
  const [config, setConfig] = useState<User2FA | null>(null);
  const [loading, setLoading] = useState(false);
  const [qrCodeUrl, setQrCodeUrl] = useState<string>('');

  // Cargar configuración de 2FA del usuario
  const load2FAConfig = async () => {
    if (!user) return;

    try {
      const { data, error } = await supabase
        .from('user_2fa')
        .select('*')
        .eq('user_id', user.id)
        .maybeSingle();

      if (error && error.code !== 'PGRST116') {
        console.error('Error loading 2FA config:', error);
        return;
      }

      setConfig(data);
    } catch (error) {
      console.error('Error loading 2FA config:', error);
    }
  };

  // Generar códigos de respaldo
  const generateBackupCodes = (): string[] => {
    const codes: string[] = [];
    for (let i = 0; i < 10; i++) {
      const code = Math.random().toString(36).substring(2, 10).toUpperCase();
      codes.push(code);
    }
    return codes;
  };

  // Configurar 2FA por primera vez
  const setup2FA = async (): Promise<{ secret: string; qrCode: string; backupCodes: string[] } | null> => {
    if (!user) return null;

    setLoading(true);
    try {
      // Generar secreto único
      const secret = new TOTP({
        issuer: 'CiudadConecta',
        label: user.email || user.id,
        algorithm: 'SHA1',
        digits: 6,
        period: 30,
      });

      const secretKey = secret.secret.base32;
      const backupCodes = generateBackupCodes();

      // Generar código QR
      const otpauthUrl = secret.toString();
      const qrCode = await QRCode.toDataURL(otpauthUrl);

      // Guardar en base de datos (pero no habilitado hasta que se verifique)
      const { error } = await supabase
        .from('user_2fa')
        .upsert({
          user_id: user.id,
          secret: secretKey,
          enabled: false,
          backup_codes: backupCodes
        });

      if (error) {
        console.error('Error saving 2FA config:', error);
        toast.error('Error al configurar 2FA');
        return null;
      }

      setQrCodeUrl(qrCode);
      await load2FAConfig();

      return {
        secret: secretKey,
        qrCode,
        backupCodes
      };

    } catch (error) {
      console.error('Error setting up 2FA:', error);
      toast.error('Error al configurar 2FA');
      return null;
    } finally {
      setLoading(false);
    }
  };

  // Verificar código TOTP
  const verifyTOTP = (token: string, secret?: string): boolean => {
    try {
      const secretToUse = secret || config?.secret;
      if (!secretToUse) return false;

      const totp = new TOTP({
        issuer: 'CiudadConecta',
        label: user?.email || user?.id || '',
        algorithm: 'SHA1',
        digits: 6,
        period: 30,
        secret: secretToUse
      });

      // Verificar el token actual y tokens de ventana de tiempo (±1 período)
      const delta = totp.validate({ token, window: 1 });
      return delta !== null;
    } catch (error) {
      console.error('Error verifying TOTP:', error);
      return false;
    }
  };

  // Habilitar 2FA después de verificar el código
  const enable2FA = async (verificationCode: string): Promise<boolean> => {
    if (!user || !config) return false;

    setLoading(true);
    try {
      // Verificar el código
      const isValid = verifyTOTP(verificationCode, config.secret);
      if (!isValid) {
        toast.error('Código de verificación inválido');
        return false;
      }

      // Habilitar 2FA
      const { error } = await supabase
        .from('user_2fa')
        .update({ enabled: true })
        .eq('user_id', user.id);

      if (error) {
        console.error('Error enabling 2FA:', error);
        toast.error('Error al habilitar 2FA');
        return false;
      }

      await load2FAConfig();
      toast.success('2FA habilitado correctamente');
      return true;

    } catch (error) {
      console.error('Error enabling 2FA:', error);
      toast.error('Error al habilitar 2FA');
      return false;
    } finally {
      setLoading(false);
    }
  };

  // Deshabilitar 2FA
  const disable2FA = async (verificationCode: string): Promise<boolean> => {
    if (!user || !config) return false;

    setLoading(true);
    try {
      // Verificar el código antes de deshabilitar
      const isValid = verifyTOTP(verificationCode) || config.backup_codes.includes(verificationCode.toUpperCase());
      if (!isValid) {
        toast.error('Código de verificación inválido');
        return false;
      }

      // Deshabilitar 2FA
      const { error } = await supabase
        .from('user_2fa')
        .delete()
        .eq('user_id', user.id);

      if (error) {
        console.error('Error disabling 2FA:', error);
        toast.error('Error al deshabilitar 2FA');
        return false;
      }

      setConfig(null);
      setQrCodeUrl('');
      toast.success('2FA deshabilitado correctamente');
      return true;

    } catch (error) {
      console.error('Error disabling 2FA:', error);
      toast.error('Error al deshabilitar 2FA');
      return false;
    } finally {
      setLoading(false);
    }
  };

  // Verificar código durante el login (incluyendo códigos de respaldo)
  const verifyLogin2FA = async (code: string): Promise<boolean> => {
    if (!user || !config) return false;

    try {
      // Verificar TOTP
      const isValidTOTP = verifyTOTP(code);
      
      // Verificar código de respaldo
      const isValidBackup = config.backup_codes.includes(code.toUpperCase());

      if (isValidTOTP || isValidBackup) {
        // Actualizar última vez usado
        await supabase
          .from('user_2fa')
          .update({ last_used_at: new Date().toISOString() })
          .eq('user_id', user.id);

        // Si se usó un código de respaldo, removerlo
        if (isValidBackup) {
          const updatedBackupCodes = config.backup_codes.filter(
            bc => bc !== code.toUpperCase()
          );
          await supabase
            .from('user_2fa')
            .update({ backup_codes: updatedBackupCodes })
            .eq('user_id', user.id);
        }

        return true;
      }

      return false;
    } catch (error) {
      console.error('Error verifying login 2FA:', error);
      return false;
    }
  };

  // Regenerar códigos de respaldo
  const regenerateBackupCodes = async (): Promise<string[] | null> => {
    if (!user || !config) return null;

    setLoading(true);
    try {
      const newBackupCodes = generateBackupCodes();
      
      const { error } = await supabase
        .from('user_2fa')
        .update({ backup_codes: newBackupCodes })
        .eq('user_id', user.id);

      if (error) {
        console.error('Error regenerating backup codes:', error);
        toast.error('Error al regenerar códigos de respaldo');
        return null;
      }

      await load2FAConfig();
      toast.success('Códigos de respaldo regenerados');
      return newBackupCodes;

    } catch (error) {
      console.error('Error regenerating backup codes:', error);
      toast.error('Error al regenerar códigos de respaldo');
      return null;
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (user) {
      load2FAConfig();
    }
  }, [user]);

  return {
    config,
    loading,
    qrCodeUrl,
    setup2FA,
    enable2FA,
    disable2FA,
    verifyTOTP,
    verifyLogin2FA,
    regenerateBackupCodes,
    load2FAConfig
  };
};