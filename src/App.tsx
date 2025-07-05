import { useState, useEffect } from "react";
import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { AuthProvider } from "@/hooks/useAuth";
import ProtectedRoute from "@/components/ProtectedRoute";
import GlobalAmberAlerts from "@/components/GlobalAmberAlerts";
import GlobalPanicAlerts from "@/components/GlobalPanicAlerts";
import GarbageAlert from "@/components/GarbageAlert";
import TestMenu from "@/components/TestMenu";
import { useGarbageAlerts } from "@/hooks/useGarbageAlerts";
import { usePerformanceMonitoring } from "@/hooks/usePerformanceMonitoring";
import { initializeAnalytics } from "@/lib/analytics";
import { initializeSentry, SentryErrorBoundary } from "@/lib/sentry";
import { useUserRoles } from "@/hooks/useUserRoles";
import { useGlobalTestNotifications } from "@/hooks/useGlobalTestNotifications";
import Index from "./pages/Index";
import Auth from "./pages/Auth";
import NotFound from "./pages/NotFound";
import Layout from "./components/Layout";
import ReportIssue from "./pages/ReportIssue";
import RecyclingGuide from "./pages/RecyclingGuide";
import Achievements from "./pages/Achievements";
import AboutUs from "./pages/AboutUs";
import Opportunities from "./pages/Opportunities";
import BeforeAfter from "./pages/BeforeAfter";
import CommunicationGuide from "./pages/CommunicationGuide";
import MissionVisionValues from "./pages/MissionVisionValues";
import AmberAlert from "./pages/AmberAlert";
import GarbagePayment from "./pages/GarbagePayment";
import ProfileSetup from "./pages/ProfileSetup";
import Settings from "./pages/Settings";
import PanicButton from "./pages/PanicButton";
import HelpSupport from "./pages/HelpSupport";
import UserManagement from "./pages/UserManagement";
import Reports from "./pages/Reports";
import Tutorial from "./pages/Tutorial";
import MisReportes from "./pages/MisReportes";
import APMDashboard from "./pages/APMDashboard";

const AppContent = () => {
  const { showAlert, dismissAlert, triggerTestAlert } = useGarbageAlerts();
  const { measureOperation } = usePerformanceMonitoring();
  const { isAdmin } = useUserRoles();
  const { activeNotification, triggerGlobalNotification, dismissNotification } = useGlobalTestNotifications();

  // Mostrar alerta global si hay una notificación activa
  const shouldShowGarbageAlert = showAlert || (activeNotification?.notification_type === 'garbage_alert');

  const handleGlobalTestAlert = async () => {
    console.log('Handling global test alert...');
    const success = await triggerGlobalNotification('garbage_alert', 'Prueba de alerta de recolección de basura');
    if (success) {
      console.log('Alerta global de basura enviada a todos los dispositivos');
      // También activar la alerta local como fallback
      triggerTestAlert();
    } else {
      console.error('Error enviando alerta global, usando alerta local');
      triggerTestAlert();
    }
  };

  return (
    <>
      <GlobalAmberAlerts />
      <GlobalPanicAlerts />
      <GarbageAlert 
        isVisible={shouldShowGarbageAlert} 
        onDismiss={() => {
          dismissAlert();
          if (activeNotification) {
            dismissNotification();
          }
        }} 
      />
      {isAdmin && <TestMenu onTriggerGarbageAlert={handleGlobalTestAlert} />}
      <Routes>
        <Route path="/auth" element={<Auth />} />
        <Route path="/perfil-setup" element={
          <ProtectedRoute>
            <ProfileSetup />
          </ProtectedRoute>
        } />
        <Route element={
          <ProtectedRoute>
            <Layout />
          </ProtectedRoute>
        }>
          <Route path="/" element={<Index />} />
          <Route path="/reportar" element={<ReportIssue />} />
          <Route path="/guia-reciclaje" element={<RecyclingGuide />} />
          <Route path="/logros" element={<Achievements />} />
          <Route path="/quienes-somos" element={<AboutUs />} />
          <Route path="/oportunidades" element={<Opportunities />} />
          <Route path="/antes-y-despues" element={<BeforeAfter />} />
          <Route path="/guia-comunicacion" element={<CommunicationGuide />} />
          <Route path="/mision-vision-valores" element={<MissionVisionValues />} />
          <Route path="/boton-panico" element={<PanicButton />} />
          <Route path="/alerta-amber" element={<AmberAlert />} />
          <Route path="/pago-basura" element={<GarbagePayment />} />
          <Route path="/configuracion" element={<Settings />} />
          <Route path="/ayuda" element={<HelpSupport />} />
          <Route path="/gestion-usuarios" element={<UserManagement />} />
          <Route path="/reportes" element={<Reports />} />
          <Route path="/tutorial" element={<Tutorial />} />
          <Route path="/mis-reportes" element={<MisReportes />} />
          <Route path="/apm-dashboard" element={<APMDashboard />} />
        </Route>
        <Route path="*" element={<NotFound />} />
      </Routes>
    </>
  );
};

const App = () => {
  const [queryClient] = useState(() => new QueryClient());

  // Inicializar servicios de monitoreo
  useEffect(() => {
    initializeSentry();
    initializeAnalytics();
  }, []);

  // Inicializar tema desde localStorage
  useEffect(() => {
    const savedTheme = localStorage.getItem('theme') as 'light' | 'dark' | 'system' | null;
    const root = window.document.documentElement;
    
    if (savedTheme) {
      root.classList.remove('light', 'dark');
      
      if (savedTheme === 'system') {
        const systemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
        root.classList.add(systemTheme);
      } else {
        root.classList.add(savedTheme);
      }
    } else {
      // Detectar preferencia del sistema por defecto
      const systemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
      root.classList.add(systemTheme);
    }
  }, []);

  return (
    <SentryErrorBoundary fallback={({ error, resetError }) => (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <div className="text-center p-8">
          <h1 className="text-2xl font-bold text-destructive mb-4">¡Oops! Algo salió mal</h1>
          <p className="text-muted-foreground mb-4">Ha ocurrido un error inesperado.</p>
          <button 
            onClick={resetError}
            className="bg-primary text-primary-foreground px-4 py-2 rounded-md hover:bg-primary/90"
          >
            Intentar de nuevo
          </button>
        </div>
      </div>
    )}>
      <QueryClientProvider client={queryClient}>
        <TooltipProvider>
          <Toaster />
          <Sonner />
          <AuthProvider>
            <BrowserRouter>
              <AppContent />
            </BrowserRouter>
          </AuthProvider>
        </TooltipProvider>
      </QueryClientProvider>
    </SentryErrorBoundary>
  );
};

export default App;
