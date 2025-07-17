import { useEffect, useState } from 'react';
import logoCiudadConecta from '@/assets/logo-ciudadconecta-v2-simple.png';

interface SplashScreenProps {
  onFinish: () => void;
}

const SplashScreen = ({ onFinish }: SplashScreenProps) => {
  const [isVisible, setIsVisible] = useState(true);

  useEffect(() => {
    const timer = setTimeout(() => {
      setIsVisible(false);
      setTimeout(onFinish, 500); // Wait for fade out animation
    }, 2500);

    return () => clearTimeout(timer);
  }, [onFinish]);

  return (
    <div 
      className={`fixed inset-0 z-50 flex items-center justify-center bg-gradient-to-br from-primary via-blue-600 to-indigo-700 transition-opacity duration-500 ${
        isVisible ? 'opacity-100' : 'opacity-0'
      }`}
    >
      <div className="text-center">
        {/* Logo con animación */}
        <div className="relative mb-8">
          <div className="w-32 h-32 mx-auto animate-scale-in">
            <img 
              src={logoCiudadConecta} 
              alt="CiudadConecta Logo" 
              className="w-full h-full object-contain drop-shadow-2xl animate-pulse"
            />
          </div>
          
          {/* Círculos animados alrededor del logo */}
          <div className="absolute inset-0 flex items-center justify-center">
            <div className="w-40 h-40 border-2 border-white/30 rounded-full animate-spin"></div>
          </div>
          <div className="absolute inset-0 flex items-center justify-center">
            <div className="w-48 h-48 border border-white/20 rounded-full animate-ping"></div>
          </div>
        </div>

        {/* Texto animado */}
        <div className="space-y-4 animate-fade-in">
          <h1 className="text-4xl font-bold text-white tracking-wide">
            CiudadConecta
          </h1>
          <p className="text-white/80 text-lg font-medium">
            Conectando ciudadanos, construyendo futuro
          </p>
          
          {/* Barra de carga animada */}
          <div className="mt-8 w-64 mx-auto">
            <div className="h-1 bg-white/20 rounded-full overflow-hidden">
              <div className="h-full bg-white rounded-full animate-[slide-in-right_2s_ease-out]"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default SplashScreen;