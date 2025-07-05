import * as Sentry from '@sentry/react';

// Configuración de Sentry
const getSentryDSN = () => {
  if (typeof window !== 'undefined') {
    return localStorage.getItem('sentry_dsn') || 'YOUR_SENTRY_DSN_HERE';
  }
  return 'YOUR_SENTRY_DSN_HERE';
};

export const initializeSentry = () => {
  const SENTRY_DSN = getSentryDSN();
  if (SENTRY_DSN !== 'YOUR_SENTRY_DSN_HERE') {
    Sentry.init({
      dsn: SENTRY_DSN,
      integrations: [
        Sentry.browserTracingIntegration(),
      ],
      // Performance Monitoring
      tracesSampleRate: 1.0,
      // Configuración adicional
      environment: import.meta.env.MODE || 'production',
      beforeSend(event) {
        // Filtrar errores en desarrollo
        if (import.meta.env.DEV) {
          console.log('Sentry Event:', event);
        }
        return event;
      },
    });
    
    console.log('Sentry APM inicializado con DSN:', SENTRY_DSN.substring(0, 20) + '...');
  }
};

// Wrapper para componentes React con Sentry
export const SentryErrorBoundary = Sentry.ErrorBoundary;

// Funciones de utilidad para tracking manual
export const captureError = (error: Error, context?: Record<string, any>) => {
  Sentry.withScope((scope) => {
    if (context) {
      Object.keys(context).forEach(key => {
        scope.setTag(key, context[key]);
      });
    }
    Sentry.captureException(error);
  });
};

export const captureMessage = (message: string, level: 'info' | 'warning' | 'error' = 'info') => {
  Sentry.captureMessage(message, level);
};

// Función para trackear performance personalizado
export const trackTransaction = (name: string, operation: string) => {
  return Sentry.startSpan({ name, op: operation }, () => {});
};

// Función para agregar contexto de usuario
export const setUserContext = (user: { id: string; email?: string; name?: string }) => {
  Sentry.setUser(user);
};

// Función para agregar tags personalizados
export const addTag = (key: string, value: string) => {
  Sentry.setTag(key, value);
};

// Función para agregar contexto adicional
export const addContext = (key: string, context: Record<string, any>) => {
  Sentry.setContext(key, context);
};