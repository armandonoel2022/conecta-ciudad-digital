import React, { useEffect, useRef, useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from './ui/card';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from './ui/select';
import { MapPin, Thermometer } from 'lucide-react';
import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

interface HeatMapProps {
  reports: Array<{
    id: string;
    latitude: number | null;
    longitude: number | null;
    category: string;
    address: string | null;
    created_at: string;
  }>;
}

const ReportsHeatMap: React.FC<HeatMapProps> = ({ reports }) => {
  const mapContainer = useRef<HTMLDivElement>(null);
  const realMapContainer = useRef<HTMLDivElement>(null);
  const [selectedCategory, setSelectedCategory] = useState<string>('all');
  const [mapReady, setMapReady] = useState(false);
  const map = useRef<mapboxgl.Map | null>(null);

  // Filtrar reportes por categoría
  const filteredReports = selectedCategory === 'all' 
    ? reports 
    : reports.filter(report => report.category === selectedCategory);

  // Obtener reportes con coordenadas válidas
  const reportsWithCoords = filteredReports.filter(
    report => report.latitude && report.longitude
  );

  // Simular un mapa de calor básico con CSS mientras no tengamos Mapbox
  const getHeatmapData = () => {
    if (reportsWithCoords.length === 0) return [];

    // Agrupar reportes por proximidad (simplificado)
    const grouped = reportsWithCoords.reduce((acc, report) => {
      const key = `${Math.round(report.latitude! * 100)}-${Math.round(report.longitude! * 100)}`;
      if (!acc[key]) {
        acc[key] = {
          lat: report.latitude!,
          lng: report.longitude!,
          count: 0,
          reports: []
        };
      }
      acc[key].count++;
      acc[key].reports.push(report);
      return acc;
    }, {} as Record<string, any>);

    return Object.values(grouped);
  };

  const heatmapData = getHeatmapData();
  const maxCount = Math.max(...heatmapData.map((item: any) => item.count), 1);

  const getCategoryLabel = (category: string) => {
    const categories = {
      basura: 'Basura y Limpieza',
      iluminacion: 'Iluminación Pública',
      baches: 'Baches y Pavimento',
      seguridad: 'Seguridad Ciudadana',
      otros: 'Otros'
    };
    return categories[category as keyof typeof categories] || category;
  };

  const getIntensityColor = (count: number) => {
    const intensity = count / maxCount;
    if (intensity > 0.8) return 'bg-red-500';
    if (intensity > 0.6) return 'bg-orange-500';
    if (intensity > 0.4) return 'bg-yellow-500';
    if (intensity > 0.2) return 'bg-blue-500';
    return 'bg-green-500';
  };

  const getIntensitySize = (count: number) => {
    const intensity = count / maxCount;
    if (intensity > 0.8) return 'w-8 h-8';
    if (intensity > 0.6) return 'w-6 h-6';
    if (intensity > 0.4) return 'w-5 h-5';
    if (intensity > 0.2) return 'w-4 h-4';
    return 'w-3 h-3';
  };

  // Inicializar mapa de Mapbox
  useEffect(() => {
    if (!realMapContainer.current) return;

    // Configurar token de Mapbox
    mapboxgl.accessToken = 'pk.eyJ1IjoiYXJtYW5kb25vZWwiLCJhIjoiY21jeGx1eDF5MDJ4YTJqbjdlamQ4aTRxNCJ9.6M0rLVxf5UTiE7EBw7qjTQ';

    // Centro por defecto (Medellín, Colombia)
    let center: [number, number] = [-75.5636, 6.2442];
    let zoom = 11;

    // Si hay reportes con coordenadas, calcular centro
    if (reportsWithCoords.length > 0) {
      const avgLat = reportsWithCoords.reduce((sum, report) => sum + report.latitude!, 0) / reportsWithCoords.length;
      const avgLng = reportsWithCoords.reduce((sum, report) => sum + report.longitude!, 0) / reportsWithCoords.length;
      center = [avgLng, avgLat];
      zoom = 12;
    }

    // Inicializar mapa
    map.current = new mapboxgl.Map({
      container: realMapContainer.current,
      style: 'mapbox://styles/mapbox/light-v11',
      center: center,
      zoom: zoom,
    });

    // Agregar controles de navegación
    map.current.addControl(new mapboxgl.NavigationControl(), 'top-right');

    // Esperar a que el mapa se cargue antes de agregar marcadores
    map.current.on('load', () => {
      // Agregar marcadores para cada reporte con coordenadas
      reportsWithCoords.forEach((report) => {
        const marker = new mapboxgl.Marker({
          color: getMarkerColor(report.category)
        })
          .setLngLat([report.longitude!, report.latitude!])
          .setPopup(
            new mapboxgl.Popup({ offset: 25 })
              .setHTML(`
                <div class="p-3">
                  <h3 class="font-semibold text-sm mb-1">${getCategoryLabel(report.category)}</h3>
                  <p class="text-xs text-gray-600 mb-1">${report.address || 'Ubicación no especificada'}</p>
                  <p class="text-xs text-gray-500">${new Date(report.created_at).toLocaleDateString()}</p>
                </div>
              `)
          )
          .addTo(map.current!);
      });

      // Si hay reportes, ajustar el mapa para mostrar todos los puntos
      if (reportsWithCoords.length > 1) {
        const bounds = new mapboxgl.LngLatBounds();
        reportsWithCoords.forEach(report => {
          bounds.extend([report.longitude!, report.latitude!]);
        });
        map.current!.fitBounds(bounds, { padding: 50 });
      }
    });

    // Cleanup
    return () => {
      map.current?.remove();
    };
  }, [reportsWithCoords, selectedCategory]); // Agregar selectedCategory como dependencia

  const getMarkerColor = (category: string) => {
    const colors = {
      basura: '#22c55e',      // green
      iluminacion: '#eab308', // yellow
      baches: '#f97316',      // orange
      seguridad: '#ef4444',   // red
      otros: '#6366f1'        // indigo
    };
    return colors[category as keyof typeof colors] || '#6b7280';
  };

  return (
    <Card className="bg-white/95 backdrop-blur-sm">
      <CardHeader>
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <Thermometer className="h-5 w-5 text-primary" />
            <CardTitle>Mapa de Calor de Incidencias</CardTitle>
          </div>
          <Select value={selectedCategory} onValueChange={setSelectedCategory}>
            <SelectTrigger className="w-48">
              <SelectValue placeholder="Seleccionar categoría" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">Todas las categorías</SelectItem>
              <SelectItem value="basura">Basura y Limpieza</SelectItem>
              <SelectItem value="iluminacion">Iluminación Pública</SelectItem>
              <SelectItem value="baches">Baches y Pavimento</SelectItem>
              <SelectItem value="seguridad">Seguridad Ciudadana</SelectItem>
              <SelectItem value="otros">Otros</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </CardHeader>
      <CardContent>
        {reportsWithCoords.length === 0 ? (
          <div className="text-center py-8">
            <MapPin className="h-12 w-12 text-gray-400 mx-auto mb-4" />
            <p className="text-gray-500">No hay datos de ubicación disponibles</p>
            <p className="text-sm text-gray-400 mt-1">
              Los reportes con coordenadas GPS aparecerán en el mapa
            </p>
          </div>
        ) : (
          <div className="space-y-4">
            {/* Mapa simulado */}
            <div 
              ref={mapContainer} 
              className="relative w-full h-96 bg-gradient-to-br from-green-100 to-blue-100 rounded-lg border-2 border-dashed border-gray-300 overflow-hidden"
            >
              <div className="absolute inset-0 flex items-center justify-center">
                <div className="text-center">
                  <p className="text-gray-600 font-medium">Visualización de Densidad</p>
                  <p className="text-sm text-gray-500">
                    {reportsWithCoords.length} reportes con ubicación
                  </p>
                </div>
              </div>
              
              {/* Puntos de calor simulados */}
              {heatmapData.map((point: any, index) => (
                <div
                  key={index}
                  className={`absolute rounded-full opacity-70 ${getIntensityColor(point.count)} ${getIntensitySize(point.count)}`}
                  style={{
                    left: `${20 + (index % 5) * 15}%`,
                    top: `${20 + Math.floor(index / 5) * 15}%`,
                  }}
                  title={`${point.count} reporte(s) en esta área`}
                />
              ))}
            </div>

            {/* Leyenda */}
            <div className="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
              <div className="text-sm font-medium text-gray-700">Intensidad:</div>
              <div className="flex items-center gap-4">
                <div className="flex items-center gap-1">
                  <div className="w-3 h-3 bg-green-500 rounded-full"></div>
                  <span className="text-xs text-gray-600">Bajo</span>
                </div>
                <div className="flex items-center gap-1">
                  <div className="w-4 h-4 bg-yellow-500 rounded-full"></div>
                  <span className="text-xs text-gray-600">Medio</span>
                </div>
                <div className="flex items-center gap-1">
                  <div className="w-5 h-5 bg-orange-500 rounded-full"></div>
                  <span className="text-xs text-gray-600">Alto</span>
                </div>
                <div className="flex items-center gap-1">
                  <div className="w-6 h-6 bg-red-500 rounded-full"></div>
                  <span className="text-xs text-gray-600">Muy Alto</span>
                </div>
              </div>
            </div>

            {/* Mapa Real de Mapbox */}
            <div className="mt-6">
              <h3 className="text-lg font-semibold mb-3 flex items-center gap-2">
                <MapPin className="h-5 w-5 text-primary" />
                Ubicaciones Geográficas
              </h3>
              <div 
                ref={realMapContainer} 
                className="w-full h-96 rounded-lg border shadow-lg"
                style={{ minHeight: '400px' }}
              />
              <div className="flex items-center justify-between p-3 bg-gray-50 rounded-lg mt-2">
                <div className="text-sm font-medium text-gray-700">Categorías:</div>
                <div className="flex items-center gap-4">
                  <div className="flex items-center gap-1">
                    <div className="w-3 h-3 bg-green-500 rounded-full"></div>
                    <span className="text-xs text-gray-600">Basura</span>
                  </div>
                  <div className="flex items-center gap-1">
                    <div className="w-3 h-3 bg-yellow-500 rounded-full"></div>
                    <span className="text-xs text-gray-600">Iluminación</span>
                  </div>
                  <div className="flex items-center gap-1">
                    <div className="w-3 h-3 bg-orange-500 rounded-full"></div>
                    <span className="text-xs text-gray-600">Baches</span>
                  </div>
                  <div className="flex items-center gap-1">
                    <div className="w-3 h-3 bg-red-500 rounded-full"></div>
                    <span className="text-xs text-gray-600">Seguridad</span>
                  </div>
                  <div className="flex items-center gap-1">
                    <div className="w-3 h-3 bg-indigo-500 rounded-full"></div>
                    <span className="text-xs text-gray-600">Otros</span>
                  </div>
                </div>
              </div>
            </div>

            {/* Estadísticas por área */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
              {heatmapData.slice(0, 6).map((area: any, index) => (
                <div key={index} className="bg-white p-3 rounded-lg border">
                  <div className="flex items-center justify-between mb-2">
                    <div className={`w-3 h-3 rounded-full ${getIntensityColor(area.count)}`}></div>
                    <span className="text-sm font-medium">{area.count} reportes</span>
                  </div>
                  <p className="text-xs text-gray-600">
                    Área {index + 1} - {getCategoryLabel(selectedCategory === 'all' ? 'mixta' : selectedCategory)}
                  </p>
                </div>
              ))}
            </div>
          </div>
        )}
      </CardContent>
    </Card>
  );
};

export default ReportsHeatMap;