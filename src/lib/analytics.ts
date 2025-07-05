import ReactGA from 'react-ga4';

// Configuración de Google Analytics
const getGAMeasurementId = () => {
  if (typeof window !== 'undefined') {
    return localStorage.getItem('ga_measurement_id') || 'G-XXXXXXXXXX';
  }
  return 'G-XXXXXXXXXX';
};

export const initializeAnalytics = () => {
  const GA_MEASUREMENT_ID = getGAMeasurementId();
  if (typeof window !== 'undefined' && GA_MEASUREMENT_ID !== 'G-XXXXXXXXXX') {
    ReactGA.initialize(GA_MEASUREMENT_ID);
    console.log('Google Analytics inicializado con ID:', GA_MEASUREMENT_ID);
  }
};

// Función para trackear páginas
export const trackPageView = (path: string, title?: string) => {
  const GA_MEASUREMENT_ID = getGAMeasurementId();
  if (typeof window !== 'undefined' && GA_MEASUREMENT_ID !== 'G-XXXXXXXXXX') {
    ReactGA.send({ 
      hitType: 'pageview', 
      page: path,
      title: title || document.title 
    });
  }
};

// Función para trackear eventos personalizados
export const trackEvent = (action: string, category: string, label?: string, value?: number) => {
  const GA_MEASUREMENT_ID = getGAMeasurementId();
  if (typeof window !== 'undefined' && GA_MEASUREMENT_ID !== 'G-XXXXXXXXXX') {
    ReactGA.event({
      action,
      category,
      label,
      value
    });
  }
};

// Función para trackear errores
export const trackError = (error: string, fatal: boolean = false) => {
  const GA_MEASUREMENT_ID = getGAMeasurementId();
  if (typeof window !== 'undefined' && GA_MEASUREMENT_ID !== 'G-XXXXXXXXXX') {
    ReactGA.event({
      action: 'exception',
      category: 'Error',
      label: error,
      value: fatal ? 1 : 0
    });
  }
};

// Función para trackear rendimiento
export const trackPerformance = (name: string, duration: number) => {
  const GA_MEASUREMENT_ID = getGAMeasurementId();
  if (typeof window !== 'undefined' && GA_MEASUREMENT_ID !== 'G-XXXXXXXXXX') {
    ReactGA.event({
      action: 'timing_complete',
      category: 'Performance',
      label: name,
      value: Math.round(duration)
    });
  }
};

// Función para obtener Web Vitals
export const trackWebVitals = () => {
  if (typeof window !== 'undefined' && 'PerformanceObserver' in window) {
    // Core Web Vitals
    const observer = new PerformanceObserver((list) => {
      for (const entry of list.getEntries()) {
        if (entry.entryType === 'paint') {
          trackPerformance(entry.name, entry.startTime);
        }
        if (entry.entryType === 'navigation') {
          const navEntry = entry as PerformanceNavigationTiming;
          trackPerformance('load_time', navEntry.loadEventEnd - navEntry.loadEventStart);
          trackPerformance('dom_content_loaded', navEntry.domContentLoadedEventEnd - navEntry.domContentLoadedEventStart);
        }
      }
    });

    try {
      observer.observe({ entryTypes: ['paint', 'navigation'] });
    } catch (e) {
      console.warn('Performance Observer no soportado:', e);
    }
  }
};