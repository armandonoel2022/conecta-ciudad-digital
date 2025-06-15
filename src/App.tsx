
import { useState } from "react";
import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { AuthProvider } from "@/hooks/useAuth";
import ProtectedRoute from "@/components/ProtectedRoute";
import GlobalPanicAlerts from "@/components/GlobalPanicAlerts";
import GlobalAmberAlerts from "@/components/GlobalAmberAlerts";
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
import PanicButton from "./pages/PanicButton";
import AmberAlert from "./pages/AmberAlert";
import GarbagePayment from "./pages/GarbagePayment";
import ProfileSetup from "./pages/ProfileSetup";

const App = () => {
  const [queryClient] = useState(() => new QueryClient());

  return (
    <QueryClientProvider client={queryClient}>
      <TooltipProvider>
        <Toaster />
        <Sonner />
        <AuthProvider>
          <BrowserRouter>
            <GlobalPanicAlerts />
            <GlobalAmberAlerts />
            <Routes>
              <Route path="/auth" element={<Auth />} />
              <Route path="/perfil-setup" element={
                <ProtectedRoute>
                  <ProfileSetup />
                </Protecte

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
              </Route>
              <Route path="*" element={<NotFound />} />
            </Routes>
          </BrowserRouter>
        </AuthProvider>
      </TooltipProvider>
    </QueryClientProvider>
  );
};

export default App;
