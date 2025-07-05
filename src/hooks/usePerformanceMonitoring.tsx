import { useEffect, useCallback } from 'react';
import { useLocation } from 'react-router-dom';
import { trackPageView, trackPerformance, trackWebVitals } from '@/lib/analytics';
import { captureMessage, addTag } from '@/lib/sentry';

export const usePerformanceMonitoring = () => {
  const location = useLocation();

  // Trackear cambios de página
  useEffect(() => {
    trackPageView(location.pathname);
    addTag('current_page', location.pathname);
  }, [location.pathname]);

  // Inicializar Web Vitals una sola vez
  useEffect(() => {
    trackWebVitals();
  }, []);

  // Función para medir tiempo de operaciones
  const measureOperation = useCallback((name: string, operation: () => Promise<any> | any) => {
    const startTime = performance.now();
    
    const finish = () => {
      const duration = performance.now() - startTime;
      trackPerformance(name, duration);
      
      // Log en Sentry si la operación tarda mucho
      if (duration > 1000) {
        captureMessage(`Operación lenta detectada: ${name} tardó ${duration}ms`, 'warning');
      }
    };

    if (operation instanceof Promise) {
      return operation.finally(finish);
    } else {
      const result = operation();
      finish();
      return result;
    }
  }, []);

  // Detectar dispositivo y conexión
  useEffect(() => {
    if (typeof navigator !== 'undefined') {
      // Información del dispositivo
      const deviceInfo = {
        userAgent: navigator.userAgent,
        platform: navigator.platform,
        language: navigator.language,
        cookieEnabled: navigator.cookieEnabled,
        onLine: navigator.onLine,
      };

      // Información de la conexión (si está disponible)
      if ('connection' in navigator) {
        const connection = (navigator as any).connection;
        deviceInfo['connectionType'] = connection.effectiveType;
        deviceInfo['downlink'] = connection.downlink;
        deviceInfo['rtt'] = connection.rtt;
      }

      // Enviar información del dispositivo a Sentry
      Object.entries(deviceInfo).forEach(([key, value]) => {
        addTag(key, String(value));
      });

      // Log de información del dispositivo
      captureMessage('Device info captured', 'info');
    }
  }, []);

  // Monitorear errores no capturados
  useEffect(() => {
    const handleError = (event: ErrorEvent) => {
      captureMessage(`Uncaught error: ${event.message}`, 'error');
    };

    const handleUnhandledRejection = (event: PromiseRejectionEvent) => {
      captureMessage(`Unhandled promise rejection: ${event.reason}`, 'error');
    };

    window.addEventListener('error', handleError);
    window.addEventListener('unhandledrejection', handleUnhandledRejection);

    return () => {
      window.removeEventListener('error', handleError);
      window.removeEventListener('unhandledrejection', handleUnhandledRejection);
    };
  }, []);

  return {
    measureOperation,
  };
};