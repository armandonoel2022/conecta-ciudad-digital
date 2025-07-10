
import React, { useState, useEffect } from 'react';
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { ArrowLeft, Mail, Lock, User, Phone } from "lucide-react";
import { Link, useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { useToast } from "@/hooks/use-toast";
import { Checkbox } from "@/components/ui/checkbox";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog";

const Auth = () => {
  const [isLoading, setIsLoading] = useState(false);
  const [loginData, setLoginData] = useState({ email: '', password: '' });
  const [signupData, setSignupData] = useState({ 
    email: '', 
    password: '', 
    fullName: '', 
    phone: '' 
  });
  const [acceptedPrivacy, setAcceptedPrivacy] = useState(false);
  const [acceptedTerms, setAcceptedTerms] = useState(false);
  const [showForgotPassword, setShowForgotPassword] = useState(false);
  const [resetEmail, setResetEmail] = useState('');
  const [failedAttempts, setFailedAttempts] = useState(0);
  const [isBlocked, setIsBlocked] = useState(false);
  const [blockTimeLeft, setBlockTimeLeft] = useState(0);
  const navigate = useNavigate();
  const { toast } = useToast();

  useEffect(() => {
    // Check if user is already logged in
    const checkAuth = async () => {
      const { data: { session } } = await supabase.auth.getSession();
      if (session) {
        navigate('/');
      }
    };
    checkAuth();

    // Check for blocked status
    const blockedUntil = localStorage.getItem('blockedUntil');
    if (blockedUntil && new Date(blockedUntil) > new Date()) {
      setIsBlocked(true);
      const timeLeft = Math.ceil((new Date(blockedUntil).getTime() - new Date().getTime()) / 1000);
      setBlockTimeLeft(timeLeft);
      
      const timer = setInterval(() => {
        const newTimeLeft = Math.ceil((new Date(blockedUntil).getTime() - new Date().getTime()) / 1000);
        if (newTimeLeft <= 0) {
          setIsBlocked(false);
          setFailedAttempts(0);
          localStorage.removeItem('blockedUntil');
          localStorage.removeItem('failedAttempts');
          clearInterval(timer);
        } else {
          setBlockTimeLeft(newTimeLeft);
        }
      }, 1000);

      return () => clearInterval(timer);
    }

    const attempts = localStorage.getItem('failedAttempts');
    if (attempts) {
      setFailedAttempts(parseInt(attempts));
    }

    // Handle password reset from email
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('type') === 'recovery') {
      toast({
        title: "Recuperación de contraseña",
        description: "Ahora puedes cambiar tu contraseña",
      });
    }
  }, [navigate]);

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!loginData.email || !loginData.password) {
      toast({
        title: "Error",
        description: "Por favor, completa todos los campos",
        variant: "destructive",
      });
      return;
    }

    setIsLoading(true);
    try {
      const { data, error } = await supabase.auth.signInWithPassword({
        email: loginData.email,
        password: loginData.password,
      });

      if (error) {
        // Handle failed login attempts
        const newFailedAttempts = failedAttempts + 1;
        setFailedAttempts(newFailedAttempts);
        localStorage.setItem('failedAttempts', newFailedAttempts.toString());
        
        if (newFailedAttempts >= 5) {
          const blockUntil = new Date(Date.now() + 15 * 60 * 1000); // 15 minutes
          localStorage.setItem('blockedUntil', blockUntil.toISOString());
          setIsBlocked(true);
          setBlockTimeLeft(15 * 60);
          
          toast({
            title: "Cuenta bloqueada",
            description: "Demasiados intentos fallidos. Tu cuenta ha sido bloqueada por 15 minutos.",
            variant: "destructive",
          });
          return;
        }
        
        let errorMessage = "Error al iniciar sesión";
        if (error.message.includes("Invalid login credentials")) {
          errorMessage = `Credenciales inválidas. Verifica tu email y contraseña. Intentos restantes: ${5 - newFailedAttempts}`;
        } else if (error.message.includes("Email not confirmed")) {
          errorMessage = "Por favor, confirma tu email antes de iniciar sesión.";
        }
        
        toast({
          title: "Error",
          description: errorMessage,
          variant: "destructive",
        });
        return;
      }

      if (data.user) {
        toast({
          title: "¡Bienvenido!",
          description: "Has iniciado sesión correctamente",
        });
        navigate('/');
      }
    } catch (error) {
      console.error('Login error:', error);
      toast({
        title: "Error",
        description: "Ocurrió un error inesperado",
        variant: "destructive",
      });
    } finally {
      setIsLoading(false);
    }
  };

  const handleForgotPassword = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!resetEmail) {
      toast({
        title: "Error",
        description: "Por favor, ingresa tu email",
        variant: "destructive",
      });
      return;
    }

    setIsLoading(true);
    try {
      const redirectUrl = "https://3aae6aac-723c-4f19-8bc0-e936a90c7a7a.lovableproject.com/auth";
      
      const { error } = await supabase.auth.resetPasswordForEmail(resetEmail, {
        redirectTo: redirectUrl,
      });

      if (error) {
        toast({
          title: "Error",
          description: "Error al enviar email de recuperación",
          variant: "destructive",
        });
        return;
      }

      toast({
        title: "Email enviado",
        description: "Revisa tu email para restablecer tu contraseña",
      });
      setShowForgotPassword(false);
      setResetEmail('');
    } catch (error) {
      console.error('Password reset error:', error);
      toast({
        title: "Error",
        description: "Ocurrió un error inesperado",
        variant: "destructive",
      });
    } finally {
      setIsLoading(false);
    }
  };

  const handleSignup = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!signupData.email || !signupData.password || !signupData.fullName) {
      toast({
        title: "Error",
        description: "Por favor, completa todos los campos obligatorios",
        variant: "destructive",
      });
      return;
    }

    if (!acceptedPrivacy || !acceptedTerms) {
      toast({
        title: "Error",
        description: "Debes aceptar las Políticas de Privacidad y los Términos y Condiciones",
        variant: "destructive",
      });
      return;
    }

    if (signupData.password.length < 6) {
      toast({
        title: "Error",
        description: "La contraseña debe tener al menos 6 caracteres",
        variant: "destructive",
      });
      return;
    }

    setIsLoading(true);
    try {
      // Use the production/preview URL instead of localhost
      const redirectUrl = "https://3aae6aac-723c-4f19-8bc0-e936a90c7a7a.lovableproject.com/confirmacion-registro";
      
      const { data, error } = await supabase.auth.signUp({
        email: signupData.email,
        password: signupData.password,
        options: {
          emailRedirectTo: redirectUrl,
          data: {
            full_name: signupData.fullName,
            phone: signupData.phone
          }
        }
      });

      if (error) {
        let errorMessage = "Error al crear la cuenta";
        if (error.message.includes("User already registered")) {
          errorMessage = "Ya existe una cuenta con este email";
        }
        
        toast({
          title: "Error",
          description: errorMessage,
          variant: "destructive",
        });
        return;
      }

      if (data.user) {
        toast({
          title: "¡Cuenta creada!",
          description: "Tu cuenta ha sido creada correctamente. Revisa tu email para confirmar tu cuenta.",
        });
        // Reset form
        setSignupData({ email: '', password: '', fullName: '', phone: '' });
      }
    } catch (error) {
      console.error('Signup error:', error);
      toast({
        title: "Error",
        description: "Ocurrió un error inesperado",
        variant: "destructive",
      });
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 flex items-center justify-center">
      <div className="w-full max-w-md">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-6">
          <Link to="/" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold">CiudadConecta</h1>
            <p className="text-white/80">Accede a tu cuenta</p>
          </div>
        </div>

        {/* Auth Card */}
        <Card className="backdrop-blur-sm bg-white/95 shadow-xl">
          <CardHeader className="text-center">
            <CardTitle className="text-2xl font-bold text-gray-800">Bienvenido</CardTitle>
            <CardDescription>
              Inicia sesión o crea una cuenta para comenzar
            </CardDescription>
          </CardHeader>
          <CardContent>
            <Tabs defaultValue="login" className="w-full">
              <TabsList className="grid w-full grid-cols-2 mb-6">
                <TabsTrigger value="login">Iniciar Sesión</TabsTrigger>
                <TabsTrigger value="signup">Registrarse</TabsTrigger>
              </TabsList>

              <TabsContent value="login">
                <form onSubmit={handleLogin} className="space-y-4">
                  <div className="space-y-2">
                    <Label htmlFor="email" className="text-gray-800 font-semibold">
                      Email
                    </Label>
                    <div className="relative">
                      <Mail className="absolute left-3 top-3 h-5 w-5 text-gray-400" />
                      <Input
                        id="email"
                        type="email"
                        placeholder="tu@email.com"
                        value={loginData.email}
                        onChange={(e) => setLoginData({ ...loginData, email: e.target.value })}
                        className="pl-10 rounded-xl border-2 border-gray-200 focus:border-primary"
                        disabled={isLoading}
                      />
                    </div>
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="password" className="text-gray-800 font-semibold">
                      Contraseña
                    </Label>
                    <div className="relative">
                      <Lock className="absolute left-3 top-3 h-5 w-5 text-gray-400" />
                      <Input
                        id="password"
                        type="password"
                        placeholder="••••••••"
                        value={loginData.password}
                        onChange={(e) => setLoginData({ ...loginData, password: e.target.value })}
                        className="pl-10 rounded-xl border-2 border-gray-200 focus:border-primary"
                        disabled={isLoading}
                      />
                    </div>
                  </div>

                  {/* Block notification */}
                  {isBlocked && (
                    <div className="bg-red-50 border border-red-200 rounded-lg p-4 mb-4">
                      <p className="text-red-800 font-semibold">Cuenta bloqueada temporalmente</p>
                      <p className="text-red-600 text-sm">
                        Tiempo restante: {Math.floor(blockTimeLeft / 60)}:{(blockTimeLeft % 60).toString().padStart(2, '0')}
                      </p>
                    </div>
                  )}

                  <Button
                    type="submit"
                    className="w-full bg-gradient-to-r from-primary to-blue-600 hover:from-primary/90 hover:to-blue-700 rounded-xl py-6 font-bold text-lg"
                    disabled={isLoading || isBlocked}
                  >
                    {isLoading ? "Iniciando sesión..." : isBlocked ? "Cuenta Bloqueada" : "Iniciar Sesión"}
                  </Button>

                  {/* Forgot password link */}
                  <div className="text-center mt-4">
                    <button
                      type="button"
                      onClick={() => setShowForgotPassword(true)}
                      className="text-primary hover:text-primary/80 text-sm font-semibold underline"
                      disabled={isLoading}
                    >
                      ¿Olvidaste tu contraseña?
                    </button>
                  </div>
                </form>
              </TabsContent>

              <TabsContent value="signup">
                <form onSubmit={handleSignup} className="space-y-4">
                  <div className="space-y-2">
                    <Label htmlFor="signup-name" className="text-gray-800 font-semibold">
                      Nombre Completo *
                    </Label>
                    <div className="relative">
                      <User className="absolute left-3 top-3 h-5 w-5 text-gray-400" />
                      <Input
                        id="signup-name"
                        type="text"
                        placeholder="Juan Pérez"
                        value={signupData.fullName}
                        onChange={(e) => setSignupData({ ...signupData, fullName: e.target.value })}
                        className="pl-10 rounded-xl border-2 border-gray-200 focus:border-primary"
                        disabled={isLoading}
                      />
                    </div>
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="signup-phone" className="text-gray-800 font-semibold">
                      Teléfono
                    </Label>
                    <div className="relative">
                      <Phone className="absolute left-3 top-3 h-5 w-5 text-gray-400" />
                      <Input
                        id="signup-phone"
                        type="tel"
                        placeholder="+52 123 456 7890"
                        value={signupData.phone}
                        onChange={(e) => setSignupData({ ...signupData, phone: e.target.value })}
                        className="pl-10 rounded-xl border-2 border-gray-200 focus:border-primary"
                        disabled={isLoading}
                      />
                    </div>
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="signup-email" className="text-gray-800 font-semibold">
                      Email *
                    </Label>
                    <div className="relative">
                      <Mail className="absolute left-3 top-3 h-5 w-5 text-gray-400" />
                      <Input
                        id="signup-email"
                        type="email"
                        placeholder="tu@email.com"
                        value={signupData.email}
                        onChange={(e) => setSignupData({ ...signupData, email: e.target.value })}
                        className="pl-10 rounded-xl border-2 border-gray-200 focus:border-primary"
                        disabled={isLoading}
                      />
                    </div>
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="signup-password" className="text-gray-800 font-semibold">
                      Contraseña *
                    </Label>
                    <div className="relative">
                      <Lock className="absolute left-3 top-3 h-5 w-5 text-gray-400" />
                      <Input
                        id="signup-password"
                        type="password"
                        placeholder="••••••••"
                        value={signupData.password}
                        onChange={(e) => setSignupData({ ...signupData, password: e.target.value })}
                        className="pl-10 rounded-xl border-2 border-gray-200 focus:border-primary"
                        disabled={isLoading}
                      />
                    </div>
                  </div>

                  {/* Privacy Policy and Terms Checkboxes */}
                  <div className="space-y-4 pt-4">
                    <div className="flex items-start space-x-3">
                      <Checkbox
                        id="privacy-policy"
                        checked={acceptedPrivacy}
                        onCheckedChange={(checked) => setAcceptedPrivacy(checked === true)}
                        className="mt-1"
                      />
                      <Label 
                        htmlFor="privacy-policy" 
                        className="text-sm text-gray-700 leading-relaxed cursor-pointer"
                      >
                        He leído y acepto las{" "}
                        <Link 
                          to="/politica-privacidad" 
                          className="text-primary font-semibold underline hover:text-primary/80"
                        >
                          Bases y Políticas de Privacidad
                        </Link>
                        {" "}*
                      </Label>
                    </div>

                    <div className="flex items-start space-x-3">
                      <Checkbox
                        id="terms-conditions"
                        checked={acceptedTerms}
                        onCheckedChange={(checked) => setAcceptedTerms(checked === true)}
                        className="mt-1"
                      />
                      <Label 
                        htmlFor="terms-conditions" 
                        className="text-sm text-gray-700 leading-relaxed cursor-pointer"
                      >
                        Acepto los{" "}
                        <Link 
                          to="/politica-privacidad" 
                          className="text-primary font-semibold underline hover:text-primary/80"
                        >
                          Términos y Condiciones
                        </Link>
                        {" "}*
                      </Label>
                    </div>
                  </div>

                  <Button
                    type="submit"
                    className="w-full bg-gradient-to-r from-primary to-blue-600 hover:from-primary/90 hover:to-blue-700 rounded-xl py-6 font-bold text-lg"
                    disabled={isLoading || !acceptedPrivacy || !acceptedTerms}
                  >
                    {isLoading ? "Creando cuenta..." : "Crear Cuenta"}
                  </Button>
                </form>
              </TabsContent>
            </Tabs>
          </CardContent>
        </Card>
      </div>

      {/* Forgot Password Dialog */}
      <Dialog open={showForgotPassword} onOpenChange={setShowForgotPassword}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle>Recuperar Contraseña</DialogTitle>
            <DialogDescription>
              Ingresa tu email para recibir instrucciones de recuperación
            </DialogDescription>
          </DialogHeader>
          <form onSubmit={handleForgotPassword} className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="reset-email" className="text-gray-800 font-semibold">
                Email
              </Label>
              <div className="relative">
                <Mail className="absolute left-3 top-3 h-5 w-5 text-gray-400" />
                <Input
                  id="reset-email"
                  type="email"
                  placeholder="tu@email.com"
                  value={resetEmail}
                  onChange={(e) => setResetEmail(e.target.value)}
                  className="pl-10 rounded-xl border-2 border-gray-200 focus:border-primary"
                  disabled={isLoading}
                />
              </div>
            </div>
            <div className="flex gap-3 pt-4">
              <Button
                type="button"
                variant="outline"
                onClick={() => setShowForgotPassword(false)}
                className="flex-1"
                disabled={isLoading}
              >
                Cancelar
              </Button>
              <Button
                type="submit"
                className="flex-1 bg-gradient-to-r from-primary to-blue-600"
                disabled={isLoading}
              >
                {isLoading ? "Enviando..." : "Enviar"}
              </Button>
            </div>
          </form>
        </DialogContent>
      </Dialog>
    </div>
  );
};

export default Auth;
