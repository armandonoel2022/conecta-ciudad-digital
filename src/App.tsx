import { useState } from "react";
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

const AppContent = () => {
  const { showAlert, dismissAlert, triggerTestAlert } = useGarbageAlerts();

  return (
    <>
      <GlobalAmberAlerts />
      <GlobalPanicAlerts />
      <GarbageAlert isVisible={showAlert} onDismiss={dismissAlert} />
      <TestMenu onTriggerGarbageAlert={triggerTestAlert} />
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
        </Route>
        <Route path="*" element={<NotFound />} />
      </Routes>
    </>
  );
};

const App = () => {
  const [queryClient] = useState(() => new QueryClient());

  return (
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
  );
};

export default App;
