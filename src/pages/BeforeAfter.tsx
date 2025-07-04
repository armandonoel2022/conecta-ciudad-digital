
import { ArrowLeft } from "lucide-react";
import { Link } from "react-router-dom";
import VideoList from "@/components/VideoList";

const BeforeAfter = () => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 animate-fade-in">
      <div className="max-w-4xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-4">
          <Link to="/" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold">ANTES Y DESPUÉS</h1>
            <p className="text-white/80">Resultados y mejoras en nuestra comunidad</p>
          </div>
        </div>

        {/* Content Card */}
        <div className="bg-white rounded-[2rem] p-6 shadow-xl space-y-6">
          <div className="text-center mb-6">
            <h2 className="text-2xl font-bold text-gray-800 mb-2">Transformaciones en la Comunidad</h2>
            <p className="text-gray-600">
              Mira cómo hemos transformado y mejorado nuestra comunidad
            </p>
          </div>

          {/* Videos List */}
          <div>
            <VideoList />
          </div>
        </div>
      </div>
    </div>
  );
};

export default BeforeAfter;
