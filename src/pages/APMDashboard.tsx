import { ArrowLeft } from "lucide-react";
import { Link } from "react-router-dom";
import { APMDashboard as Dashboard } from "@/components/APMDashboard";
import { useUserRoles } from "@/hooks/useUserRoles";
import { Navigate } from "react-router-dom";

const APMDashboard = () => {
  const { isAdmin, loading } = useUserRoles();

  if (loading) {
    return <div>Cargando...</div>;
  }

  if (!isAdmin) {
    return <Navigate to="/" replace />;
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 animate-fade-in">
      <div className="max-w-6xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-6">
          <Link to="/configuracion" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold">DASHBOARD APM</h1>
            <p className="text-white/80">Monitoreo de rendimiento y analytics</p>
          </div>
        </div>

        {/* Dashboard Content */}
        <div className="bg-white/10 backdrop-blur-sm rounded-2xl p-6">
          <Dashboard />
        </div>
      </div>
    </div>
  );
};

export default APMDashboard;