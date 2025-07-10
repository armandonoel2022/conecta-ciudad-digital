import React, { useState } from 'react';
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { Badge } from '@/components/ui/badge';
import { Copy, Download, Shield, ShieldCheck, AlertTriangle, RefreshCw } from 'lucide-react';
import { use2FA } from '@/hooks/use2FA';
import { toast } from 'sonner';

interface TwoFactorSetupProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

export const TwoFactorSetup: React.FC<TwoFactorSetupProps> = ({ open, onOpenChange }) => {
  const { config, loading, setup2FA, enable2FA, disable2FA, regenerateBackupCodes } = use2FA();
  const [setupData, setSetupData] = useState<{
    secret: string;
    qrCode: string;
    backupCodes: string[];
  } | null>(null);
  const [verificationCode, setVerificationCode] = useState('');
  const [disableCode, setDisableCode] = useState('');
  const [showBackupCodes, setShowBackupCodes] = useState(false);

  const handleSetup = async () => {
    const result = await setup2FA();
    if (result) {
      setSetupData(result);
    }
  };

  const handleEnable = async () => {
    if (!verificationCode) {
      toast.error('Ingresa el código de verificación');
      return;
    }

    const success = await enable2FA(verificationCode);
    if (success) {
      setVerificationCode('');
      setSetupData(null);
    }
  };

  const handleDisable = async () => {
    if (!disableCode) {
      toast.error('Ingresa el código de verificación');
      return;
    }

    const success = await disable2FA(disableCode);
    if (success) {
      setDisableCode('');
      onOpenChange(false);
    }
  };

  const handleRegenerateBackupCodes = async () => {
    const newCodes = await regenerateBackupCodes();
    if (newCodes) {
      setShowBackupCodes(true);
    }
  };

  const copyToClipboard = (text: string) => {
    navigator.clipboard.writeText(text);
    toast.success('Copiado al portapapeles');
  };

  const downloadBackupCodes = (codes: string[]) => {
    const content = codes.join('\n');
    const blob = new Blob([content], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'ciudadconecta-backup-codes.txt';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
    toast.success('Códigos de respaldo descargados');
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <Shield className="h-5 w-5" />
            Autenticación de Dos Factores (2FA)
          </DialogTitle>
          <DialogDescription>
            Añade una capa extra de seguridad a tu cuenta
          </DialogDescription>
        </DialogHeader>

        {!config?.enabled ? (
          // Configuración inicial
          <div className="space-y-6">
            {!setupData ? (
              <Card>
                <CardHeader>
                  <CardTitle className="text-lg">¿Qué es 2FA?</CardTitle>
                  <CardDescription>
                    La autenticación de dos factores requiere tanto tu contraseña como un código de tu teléfono para iniciar sesión,
                    haciendo tu cuenta mucho más segura.
                  </CardDescription>
                </CardHeader>
                <CardContent>
                  <Button onClick={handleSetup} disabled={loading} className="w-full">
                    {loading ? 'Configurando...' : 'Configurar 2FA'}
                  </Button>
                </CardContent>
              </Card>
            ) : (
              <Tabs defaultValue="setup" className="w-full">
                <TabsList className="grid w-full grid-cols-2">
                  <TabsTrigger value="setup">Configurar App</TabsTrigger>
                  <TabsTrigger value="backup">Códigos de Respaldo</TabsTrigger>
                </TabsList>

                <TabsContent value="setup" className="space-y-4">
                  <Card>
                    <CardHeader>
                      <CardTitle className="text-lg">Paso 1: Escanea el código QR</CardTitle>
                      <CardDescription>
                        Usa Google Authenticator, Authy, o cualquier app compatible con TOTP
                      </CardDescription>
                    </CardHeader>
                    <CardContent className="space-y-4">
                      <div className="flex justify-center">
                        <img src={setupData.qrCode} alt="QR Code para 2FA" className="border rounded" />
                      </div>
                      
                      <div className="space-y-2">
                        <Label>O ingresa este código manualmente:</Label>
                        <div className="flex items-center gap-2">
                          <Input 
                            value={setupData.secret} 
                            readOnly 
                            className="font-mono text-sm"
                          />
                          <Button
                            size="sm"
                            variant="outline"
                            onClick={() => copyToClipboard(setupData.secret)}
                          >
                            <Copy className="h-4 w-4" />
                          </Button>
                        </div>
                      </div>
                    </CardContent>
                  </Card>

                  <Card>
                    <CardHeader>
                      <CardTitle className="text-lg">Paso 2: Verifica el código</CardTitle>
                      <CardDescription>
                        Ingresa el código de 6 dígitos de tu app de autenticación
                      </CardDescription>
                    </CardHeader>
                    <CardContent className="space-y-4">
                      <div className="space-y-2">
                        <Label htmlFor="verification">Código de verificación</Label>
                        <Input
                          id="verification"
                          value={verificationCode}
                          onChange={(e) => setVerificationCode(e.target.value.replace(/\D/g, '').slice(0, 6))}
                          placeholder="000000"
                          className="text-center text-lg font-mono tracking-widest"
                          maxLength={6}
                        />
                      </div>
                      <Button 
                        onClick={handleEnable} 
                        disabled={loading || verificationCode.length !== 6}
                        className="w-full"
                      >
                        {loading ? 'Verificando...' : 'Habilitar 2FA'}
                      </Button>
                    </CardContent>
                  </Card>
                </TabsContent>

                <TabsContent value="backup" className="space-y-4">
                  <Alert>
                    <AlertTriangle className="h-4 w-4" />
                    <AlertDescription>
                      <strong>¡Importante!</strong> Guarda estos códigos en un lugar seguro. 
                      Puedes usarlos para acceder a tu cuenta si pierdes tu dispositivo de autenticación.
                    </AlertDescription>
                  </Alert>

                  <Card>
                    <CardHeader>
                      <CardTitle className="text-lg">Códigos de Respaldo</CardTitle>
                      <CardDescription>
                        Cada código solo se puede usar una vez
                      </CardDescription>
                    </CardHeader>
                    <CardContent className="space-y-4">
                      <div className="grid grid-cols-2 gap-2">
                        {setupData.backupCodes.map((code, index) => (
                          <div key={index} className="flex items-center justify-between p-2 bg-gray-50 rounded font-mono text-sm">
                            {code}
                            <Button
                              size="sm"
                              variant="ghost"
                              onClick={() => copyToClipboard(code)}
                            >
                              <Copy className="h-3 w-3" />
                            </Button>
                          </div>
                        ))}
                      </div>
                      
                      <Button
                        variant="outline"
                        onClick={() => downloadBackupCodes(setupData.backupCodes)}
                        className="w-full"
                      >
                        <Download className="h-4 w-4 mr-2" />
                        Descargar códigos
                      </Button>
                    </CardContent>
                  </Card>
                </TabsContent>
              </Tabs>
            )}
          </div>
        ) : (
          // 2FA ya habilitado
          <div className="space-y-6">
            <Alert>
              <ShieldCheck className="h-4 w-4" />
              <AlertDescription>
                <strong>2FA está habilitado</strong> - Tu cuenta está protegida con autenticación de dos factores.
              </AlertDescription>
            </Alert>

            <Card>
              <CardHeader>
                <CardTitle className="text-lg">Estado actual</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="flex items-center justify-between">
                  <span>Estado:</span>
                  <Badge variant="default" className="bg-green-100 text-green-800">
                    <ShieldCheck className="h-3 w-3 mr-1" />
                    Habilitado
                  </Badge>
                </div>
                
                <div className="flex items-center justify-between">
                  <span>Configurado:</span>
                  <span className="text-sm text-gray-600">
                    {new Date(config.created_at).toLocaleDateString()}
                  </span>
                </div>

                {config.last_used_at && (
                  <div className="flex items-center justify-between">
                    <span>Último uso:</span>
                    <span className="text-sm text-gray-600">
                      {new Date(config.last_used_at).toLocaleDateString()}
                    </span>
                  </div>
                )}
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle className="text-lg">Códigos de Respaldo</CardTitle>
                <CardDescription>
                  Tienes {config.backup_codes.length} códigos de respaldo disponibles
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                <Button
                  variant="outline"
                  onClick={() => setShowBackupCodes(!showBackupCodes)}
                  className="w-full"
                >
                  {showBackupCodes ? 'Ocultar' : 'Ver'} códigos de respaldo
                </Button>

                {showBackupCodes && (
                  <div className="space-y-4">
                    <div className="grid grid-cols-2 gap-2">
                      {config.backup_codes.map((code, index) => (
                        <div key={index} className="flex items-center justify-between p-2 bg-gray-50 rounded font-mono text-sm">
                          {code}
                          <Button
                            size="sm"
                            variant="ghost"
                            onClick={() => copyToClipboard(code)}
                          >
                            <Copy className="h-3 w-3" />
                          </Button>
                        </div>
                      ))}
                    </div>
                    
                    <div className="flex gap-2">
                      <Button
                        variant="outline"
                        onClick={() => downloadBackupCodes(config.backup_codes)}
                        className="flex-1"
                      >
                        <Download className="h-4 w-4 mr-2" />
                        Descargar
                      </Button>
                      <Button
                        variant="outline"
                        onClick={handleRegenerateBackupCodes}
                        disabled={loading}
                        className="flex-1"
                      >
                        <RefreshCw className="h-4 w-4 mr-2" />
                        Regenerar
                      </Button>
                    </div>
                  </div>
                )}
              </CardContent>
            </Card>

            <Card className="border-red-200">
              <CardHeader>
                <CardTitle className="text-lg text-red-700">Deshabilitar 2FA</CardTitle>
                <CardDescription>
                  Esto reducirá la seguridad de tu cuenta
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="space-y-2">
                  <Label htmlFor="disable-code">Código de verificación</Label>
                  <Input
                    id="disable-code"
                    value={disableCode}
                    onChange={(e) => setDisableCode(e.target.value)}
                    placeholder="Código de 6 dígitos o código de respaldo"
                    className="text-center font-mono"
                  />
                </div>
                <Button 
                  variant="destructive"
                  onClick={handleDisable}
                  disabled={loading || !disableCode}
                  className="w-full"
                >
                  {loading ? 'Deshabilitando...' : 'Deshabilitar 2FA'}
                </Button>
              </CardContent>
            </Card>
          </div>
        )}
      </DialogContent>
    </Dialog>
  );
};