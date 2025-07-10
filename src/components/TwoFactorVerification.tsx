import React, { useState } from 'react';
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { Shield, Smartphone, Key } from 'lucide-react';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';

interface TwoFactorVerificationProps {
  open: boolean;
  onVerify: (code: string) => Promise<boolean>;
  loading: boolean;
}

export const TwoFactorVerification: React.FC<TwoFactorVerificationProps> = ({
  open,
  onVerify,
  loading
}) => {
  const [code, setCode] = useState('');
  const [backupCode, setBackupCode] = useState('');
  const [activeTab, setActiveTab] = useState('totp');

  const handleVerify = async () => {
    const codeToVerify = activeTab === 'totp' ? code : backupCode;
    if (!codeToVerify) return;

    const success = await onVerify(codeToVerify);
    if (success) {
      setCode('');
      setBackupCode('');
    }
  };

  const handleKeyPress = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter') {
      handleVerify();
    }
  };

  return (
    <Dialog open={open} onOpenChange={() => {}}>
      <DialogContent className="max-w-md" onPointerDownOutside={(e) => e.preventDefault()}>
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <Shield className="h-5 w-5" />
            Verificación de Dos Factores
          </DialogTitle>
          <DialogDescription>
            Ingresa el código de tu app de autenticación o un código de respaldo
          </DialogDescription>
        </DialogHeader>

        <Tabs value={activeTab} onValueChange={setActiveTab} className="w-full">
          <TabsList className="grid w-full grid-cols-2">
            <TabsTrigger value="totp" className="flex items-center gap-2">
              <Smartphone className="h-4 w-4" />
              App
            </TabsTrigger>
            <TabsTrigger value="backup" className="flex items-center gap-2">
              <Key className="h-4 w-4" />
              Respaldo
            </TabsTrigger>
          </TabsList>

          <TabsContent value="totp" className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="totp-code">Código de verificación</Label>
              <Input
                id="totp-code"
                value={code}
                onChange={(e) => setCode(e.target.value.replace(/\D/g, '').slice(0, 6))}
                onKeyPress={handleKeyPress}
                placeholder="000000"
                className="text-center text-2xl font-mono tracking-widest"
                maxLength={6}
                autoComplete="one-time-code"
                autoFocus
              />
            </div>
            
            <Alert>
              <Smartphone className="h-4 w-4" />
              <AlertDescription>
                Abre tu app de autenticación (Google Authenticator, Authy, etc.) e ingresa el código de 6 dígitos.
              </AlertDescription>
            </Alert>

            <Button 
              onClick={handleVerify}
              disabled={loading || code.length !== 6}
              className="w-full"
            >
              {loading ? 'Verificando...' : 'Verificar'}
            </Button>
          </TabsContent>

          <TabsContent value="backup" className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="backup-code">Código de respaldo</Label>
              <Input
                id="backup-code"
                value={backupCode}
                onChange={(e) => setBackupCode(e.target.value.toUpperCase().replace(/[^A-Z0-9]/g, '').slice(0, 8))}
                onKeyPress={handleKeyPress}
                placeholder="XXXXXXXX"
                className="text-center text-xl font-mono tracking-widest"
                maxLength={8}
                autoComplete="one-time-code"
              />
            </div>
            
            <Alert>
              <Key className="h-4 w-4" />
              <AlertDescription>
                Usa uno de los códigos de respaldo que guardaste cuando configuraste 2FA. 
                Cada código solo se puede usar una vez.
              </AlertDescription>
            </Alert>

            <Button 
              onClick={handleVerify}
              disabled={loading || backupCode.length < 8}
              className="w-full"
            >
              {loading ? 'Verificando...' : 'Verificar'}
            </Button>
          </TabsContent>
        </Tabs>

        <div className="text-center">
          <p className="text-sm text-gray-600">
            ¿Problemas para acceder? Contacta al administrador del sistema.
          </p>
        </div>
      </DialogContent>
    </Dialog>
  );
};