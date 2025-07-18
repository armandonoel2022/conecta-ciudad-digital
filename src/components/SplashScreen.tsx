import { useEffect, useState } from 'react';
import logoCiudadConecta from '@/assets/logo-ciudadconecta-v3.png';

interface SplashScreenProps {
  onFinish: () => void;
}

const SplashScreen = ({ onFinish }: SplashScreenProps) => {
  const [isVisible, setIsVisible] = useState(true);
  const [progress, setProgress] = useState(0);
  const [loadingText, setLoadingText] = useState('Iniciando CiudadConecta...');

  useEffect(() => {
    // Simulación de carga con mensajes y sonido
    const loadingSteps = [
      { progress: 15, text: 'Iniciando CiudadConecta...' },
      { progress: 30, text: 'Cargando servicios...' },
      { progress: 50, text: 'Conectando con la comunidad...' },
      { progress: 70, text: 'Verificando permisos...' },
      { progress: 85, text: 'Preparando interfaz...' },
      { progress: 100, text: '¡Bienvenido a CiudadConecta!' }
    ];

    let stepIndex = 0;
    
    // Reproducir sonido de inicio (opcional)
    const playStartupSound = () => {
      try {
        const audioContext = new (window.AudioContext || (window as any).webkitAudioContext)();
        const oscillator = audioContext.createOscillator();
        const gainNode = audioContext.createGain();
        
        oscillator.connect(gainNode);
        gainNode.connect(audioContext.destination);
        
        oscillator.frequency.setValueAtTime(800, audioContext.currentTime);
        oscillator.frequency.exponentialRampToValueAtTime(400, audioContext.currentTime + 0.3);
        
        gainNode.gain.setValueAtTime(0.1, audioContext.currentTime);
        gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.3);
        
        oscillator.start(audioContext.currentTime);
        oscillator.stop(audioContext.currentTime + 0.3);
      } catch (error) {
        // Silenciar errores de audio si no es soportado
      }
    };
    
    const updateProgress = () => {
      if (stepIndex < loadingSteps.length) {
        const step = loadingSteps[stepIndex];
        setProgress(step.progress);
        setLoadingText(step.text);
        
        if (stepIndex === 0) {
          playStartupSound();
        }
        
        stepIndex++;
      } else {
        setTimeout(() => {
          setIsVisible(false);
          setTimeout(onFinish, 500);
        }, 1000);
      }
    };

    // Iniciar primera actualización inmediatamente
    updateProgress();
    
    // Continuar actualizaciones cada 700ms para que dure más tiempo
    const interval = setInterval(updateProgress, 700);

    return () => clearInterval(interval);
  }, [onFinish]);

  return (
    <div 
      className={`fixed inset-0 z-50 flex items-center justify-center bg-gradient-to-br from-primary via-blue-600 to-indigo-700 transition-opacity duration-500 ${
        isVisible ? 'opacity-100' : 'opacity-0'
      }`}
    >
      <div className="text-center">
        {/* Logo circular con animación */}
        <div className="relative mb-8">
          <div className="w-40 h-40 mx-auto animate-scale-in">
            <div className="w-full h-full rounded-full overflow-hidden bg-white/10 backdrop-blur-sm border-2 border-white/30 flex items-center justify-center shadow-2xl">
              <img 
                src={logoCiudadConecta} 
                alt="CiudadConecta Logo" 
                className="w-32 h-32 object-contain animate-pulse"
                style={{ animationDuration: '1.5s' }}
              />
            </div>
          </div>
          
          {/* Círculos animados alrededor del logo */}
          <div className="absolute inset-0 flex items-center justify-center">
            <div className="w-48 h-48 border-2 border-white/30 rounded-full animate-spin" style={{ animationDuration: '4s' }}></div>
          </div>
          <div className="absolute inset-0 flex items-center justify-center">
            <div className="w-56 h-56 border border-white/20 rounded-full animate-ping" style={{ animationDuration: '3s' }}></div>
          </div>
          <div className="absolute inset-0 flex items-center justify-center">
            <div className="w-64 h-64 border border-white/10 rounded-full animate-pulse" style={{ animationDuration: '2s' }}></div>
          </div>
        </div>

        {/* Texto animado */}
        <div className="space-y-4 animate-fade-in">
          <h1 className="text-4xl font-bold text-white tracking-wide drop-shadow-lg">
            CiudadConecta
          </h1>
          <p className="text-white/80 text-lg font-medium">
            Conectando ciudadanos, construyendo futuro
          </p>
          
          {/* Sistema de carga mejorado */}
          <div className="mt-8 w-80 mx-auto space-y-3">
            <div className="text-white/90 text-sm font-medium animate-fade-in" style={{ animationDelay: '0.5s' }}>
              {loadingText}
            </div>
            
            <div className="w-full bg-white/20 rounded-full h-2 overflow-hidden shadow-inner">
              <div 
                className="bg-gradient-to-r from-white via-blue-200 to-white h-full rounded-full transition-all duration-700 ease-out shadow-lg"
                style={{ 
                  width: `${progress}%`,
                  boxShadow: '0 0 10px rgba(255,255,255,0.5)'
                }}
              ></div>
            </div>
            
            <div className="flex justify-between text-white/70 text-xs">
              <span>Cargando sistema...</span>
              <span>{progress}%</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default SplashScreen;