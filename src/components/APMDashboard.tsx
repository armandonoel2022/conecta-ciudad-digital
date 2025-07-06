import { useState, useEffect } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Activity, Zap, Globe, Smartphone, Wifi } from 'lucide-react';

interface PerformanceMetric {
  name: string;
  value: number;
  unit: string;
  status: 'good' | 'needs-improvement' | 'poor';
}

interface DeviceInfo {
  userAgent: string;
  platform: string;
  language: string;
  onLine: boolean;
  connectionType?: string;
  downlink?: number;
  rtt?: number;
}

export const APMDashboard = () => {
  const [metrics, setMetrics] = useState<PerformanceMetric[]>([]);
  const [deviceInfo, setDeviceInfo] = useState<DeviceInfo | null>(null);
  const [pageViews, setPageViews] = useState(0);
  const [gaId, setGaId] = useState('');
  const [sentryDsn, setSentryDsn] = useState('');

  useEffect(() => {
    // Cargar configuración desde localStorage
    const loadConfiguration = () => {
      const storedGaId = localStorage.getItem('ga_measurement_id') || '';
      const storedSentryDsn = localStorage.getItem('sentry_dsn') || '';
      setGaId(storedGaId);
      setSentryDsn(storedSentryDsn);
    };

    // Obtener métricas de performance
    const getPerformanceMetrics = () => {
      if ('performance' in window) {
        const navigation = performance.getEntriesByType('navigation')[0] as PerformanceNavigationTiming;
        const paint = performance.getEntriesByType('paint');

        const newMetrics: PerformanceMetric[] = [];

        if (navigation) {
          const loadTime = navigation.loadEventEnd - navigation.loadEventStart;
          const domContentLoaded = navigation.domContentLoadedEventEnd - navigation.domContentLoadedEventStart;
          const firstByte = navigation.responseStart - navigation.requestStart;

          newMetrics.push(
            {
              name: 'Tiempo de carga',
              value: Math.round(loadTime),
              unit: 'ms',
              status: loadTime < 1000 ? 'good' : loadTime < 3000 ? 'needs-improvement' : 'poor'
            },
            {
              name: 'DOM Content Loaded',
              value: Math.round(domContentLoaded),
              unit: 'ms',
              status: domContentLoaded < 800 ? 'good' : domContentLoaded < 1800 ? 'needs-improvement' : 'poor'
            },
            {
              name: 'Primer Byte (TTFB)',
              value: Math.round(firstByte),
              unit: 'ms',
              status: firstByte < 200 ? 'good' : firstByte < 600 ? 'needs-improvement' : 'poor'
            }
          );
        }

        paint.forEach((entry) => {
          newMetrics.push({
            name: entry.name === 'first-paint' ? 'Primera Pintura' : 'Primera Pintura con Contenido',
            value: Math.round(entry.startTime),
            unit: 'ms',
            status: entry.startTime < 1000 ? 'good' : entry.startTime < 2500 ? 'needs-improvement' : 'poor'
          });
        });

        setMetrics(newMetrics);
      }
    };

    // Obtener información del dispositivo
    const getDeviceInfo = () => {
      const info: DeviceInfo = {
        userAgent: navigator.userAgent,
        platform: navigator.platform,
        language: navigator.language,
        onLine: navigator.onLine,
      };

      // Información de conexión si está disponible
      if ('connection' in navigator) {
        const connection = (navigator as any).connection;
        info.connectionType = connection.effectiveType;
        info.downlink = connection.downlink;
        info.rtt = connection.rtt;
      }

      setDeviceInfo(info);
    };

    loadConfiguration();
    getPerformanceMetrics();
    getDeviceInfo();

    // Simular contador de páginas vistas (en una app real vendría de Analytics)
    const storedViews = localStorage.getItem('apm_page_views');
    setPageViews(storedViews ? parseInt(storedViews) : 1);
    localStorage.setItem('apm_page_views', String((storedViews ? parseInt(storedViews) : 0) + 1));
  }, []);

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'good': return 'bg-green-100 text-green-800 border-green-200';
      case 'needs-improvement': return 'bg-yellow-100 text-yellow-800 border-yellow-200';
      case 'poor': return 'bg-red-100 text-red-800 border-red-200';
      default: return 'bg-gray-100 text-gray-800 border-gray-200';
    }
  };

  const getStatusText = (status: string) => {
    switch (status) {
      case 'good': return 'Excelente';
      case 'needs-improvement': return 'Mejorable';
      case 'poor': return 'Necesita mejora';
      default: return 'Desconocido';
    }
  };

  const getBrowserName = (userAgent: string) => {
    if (userAgent.includes('Chrome')) return 'Google Chrome';
    if (userAgent.includes('Firefox')) return 'Mozilla Firefox';
    if (userAgent.includes('Safari')) return 'Safari';
    if (userAgent.includes('Edge')) return 'Microsoft Edge';
    return 'Navegador desconocido';
  };

  const getDeviceType = (userAgent: string) => {
    if (/Mobi|Android/i.test(userAgent)) return 'Móvil';
    if (/Tablet/i.test(userAgent)) return 'Tablet';
    return 'Escritorio';
  };

  return (
    <div className="space-y-6">
      {/* Resumen de métricas */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Páginas Vistas</CardTitle>
            <Activity className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{pageViews}</div>
            <p className="text-xs text-muted-foreground">En esta sesión</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Estado Conexión</CardTitle>
            <Wifi className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{deviceInfo?.onLine ? 'En línea' : 'Sin conexión'}</div>
            <p className="text-xs text-muted-foreground">
              {deviceInfo?.connectionType && `${deviceInfo.connectionType.toUpperCase()}`}
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Tipo de Dispositivo</CardTitle>
            <Smartphone className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{deviceInfo ? getDeviceType(deviceInfo.userAgent) : 'N/A'}</div>
            <p className="text-xs text-muted-foreground">{deviceInfo?.platform}</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Navegador</CardTitle>
            <Globe className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-lg font-bold">{deviceInfo ? getBrowserName(deviceInfo.userAgent) : 'N/A'}</div>
            <p className="text-xs text-muted-foreground">{deviceInfo?.language}</p>
          </CardContent>
        </Card>
      </div>

      {/* Métricas de rendimiento */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Zap className="h-5 w-5" />
            Métricas de Rendimiento
          </CardTitle>
          <CardDescription>
            Métricas de Core Web Vitals y rendimiento de la aplicación
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {metrics.map((metric, index) => (
              <div key={index} className="p-4 border rounded-lg">
                <div className="flex items-center justify-between mb-2">
                  <h4 className="font-medium text-sm">{metric.name}</h4>
                  <Badge className={getStatusColor(metric.status)}>
                    {getStatusText(metric.status)}
                  </Badge>
                </div>
                <div className="text-2xl font-bold">
                  {metric.value}{metric.unit}
                </div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>

      {/* Información de conexión */}
      {deviceInfo?.connectionType && (
        <Card>
          <CardHeader>
            <CardTitle>Información de Conexión</CardTitle>
            <CardDescription>Detalles sobre la conexión a internet del usuario</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <div>
                <p className="text-sm font-medium text-muted-foreground">Tipo de Conexión</p>
                <p className="text-lg font-semibold">{deviceInfo.connectionType?.toUpperCase()}</p>
              </div>
              {deviceInfo.downlink && (
                <div>
                  <p className="text-sm font-medium text-muted-foreground">Velocidad Descarga</p>
                  <p className="text-lg font-semibold">{deviceInfo.downlink} Mbps</p>
                </div>
              )}
              {deviceInfo.rtt && (
                <div>
                  <p className="text-sm font-medium text-muted-foreground">Latencia (RTT)</p>
                  <p className="text-lg font-semibold">{deviceInfo.rtt} ms</p>
                </div>
              )}
            </div>
          </CardContent>
        </Card>
      )}

      {/* Configuración */}
      <Card>
        <CardHeader>
          <CardTitle>Estado de Configuración</CardTitle>
          <CardDescription>Estado actual de las herramientas de monitoreo</CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-2">
            <div className="flex items-center justify-between">
              <span>Google Analytics</span>
              <Badge variant={gaId && gaId.startsWith('G-') ? "default" : "outline"}>
                {gaId && gaId.startsWith('G-') ? "✅ Configurado" : "Configurar ID"}
              </Badge>
            </div>
            <div className="flex items-center justify-between">
              <span>Sentry APM</span>
              <Badge variant={sentryDsn && sentryDsn.includes('ingest') ? "default" : "outline"}>
                {sentryDsn && sentryDsn.includes('ingest') ? "✅ Configurado" : "Configurar DSN"}
              </Badge>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
};