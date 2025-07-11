import React, { useEffect, useRef, useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from './ui/card';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from './ui/select';
import { MapPin, Thermometer, TrendingUp, AlertCircle } from 'lucide-react';
import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

interface HeatMapProps {
  reports: Array<{
    id: string;
    latitude: number | null;
    longitude: number | null;
    category: string;
    address: string | null;
    neighborhood: string | null;
    created_at: string;
  }>;
}

const ReportsHeatMap: React.FC<HeatMapProps> = ({ reports }) => {
  const mapContainer = useRef<HTMLDivElement>(null);
  const realMapContainer = useRef<HTMLDivElement>(null);
  const heatMapContainer = useRef<HTMLDivElement>(null);
  const [selectedCategory, setSelectedCategory] = useState<string>('all');
  const [mapReady, setMapReady] = useState(false);
  const map = useRef<mapboxgl.Map | null>(null);
  const heatMap = useRef<mapboxgl.Map | null>(null);

  // Filtrar reportes por categoría
  const filteredReports = selectedCategory === 'all' 
    ? reports 
    : reports.filter(report => report.category === selectedCategory);

  // Obtener reportes con coordenadas válidas para Santo Domingo
  // Santo Domingo está aproximadamente entre 18.3°-18.7° N y 69.7°-70.1° W
  const reportsWithCoords = filteredReports.filter(
    report => {
      if (!report.latitude || !report.longitude) return false;
      
      // Filtrar coordenadas que estén dentro del área de Santo Domingo
      const lat = report.latitude;
      const lng = report.longitude;
      
      // Rangos aproximados para Santo Domingo, República Dominicana
      const isInSantoDomingo = 
        lat >= 18.2 && lat <= 18.8 &&  // Latitud (Norte)
        lng >= -70.2 && lng <= -69.6;  // Longitud (Oeste)
        
      return isInSantoDomingo;
    }
  );

  // Simular un mapa de calor básico con CSS mientras no tengamos Mapbox
  const getHeatmapData = () => {
    if (reportsWithCoords.length === 0) return [];

    // Agrupar reportes por proximidad geográfica (grid más pequeño para más precisión)
    const grouped = reportsWithCoords.reduce((acc, report) => {
      const key = `${Math.round(report.latitude! * 1000)}-${Math.round(report.longitude! * 1000)}`;
      if (!acc[key]) {
        acc[key] = {
          lat: report.latitude!,
          lng: report.longitude!,
          count: 0,
          reports: [],
          categories: {} as Record<string, number>
        };
      }
      acc[key].count++;
      acc[key].reports.push(report);
      
      // Contar por categorías
      if (!acc[key].categories[report.category]) {
        acc[key].categories[report.category] = 0;
      }
      acc[key].categories[report.category]++;
      
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

    // Centro por defecto (Santo Domingo, República Dominicana)
    let center: [number, number] = [-69.9, 18.5];
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

  // Inicializar mapa de calor mejorado con fondo real
  useEffect(() => {
    if (!heatMapContainer.current) return;

    // Configurar token de Mapbox
    mapboxgl.accessToken = 'pk.eyJ1IjoiYXJtYW5kb25vZWwiLCJhIjoiY21jeGx1eDF5MDJ4YTJqbjdlamQ4aTRxNCJ9.6M0rLVxf5UTiE7EBw7qjTQ';

    // Centro por defecto (Santo Domingo, República Dominicana)
    let center: [number, number] = [-69.9, 18.5];
    let zoom = 10;

    // Si hay reportes con coordenadas, calcular centro y zoom apropiado
    if (reportsWithCoords.length > 0) {
      const avgLat = reportsWithCoords.reduce((sum, report) => sum + report.latitude!, 0) / reportsWithCoords.length;
      const avgLng = reportsWithCoords.reduce((sum, report) => sum + report.longitude!, 0) / reportsWithCoords.length;
      center = [avgLng, avgLat];
      zoom = reportsWithCoords.length === 1 ? 13 : 11;
    }

    // Inicializar mapa de calor
    heatMap.current = new mapboxgl.Map({
      container: heatMapContainer.current,
      style: 'mapbox://styles/mapbox/light-v11',
      center: center,
      zoom: zoom,
      interactive: true, // Habilitar interacción para explorar
      attributionControl: false, // Ocultar controles
    });

    // Esperar a que el mapa se cargue
    heatMap.current.on('load', () => {
      // Agregar puntos de calor como marcadores personalizados
      heatmapData.forEach((point: any) => {
        const intensity = point.count / maxCount;
        let size = 20; // tamaño base
        let color = '#22c55e'; // verde por defecto

        // Determinar tamaño y color basado en intensidad
        if (intensity > 0.8) {
          size = 40;
          color = '#ef4444'; // rojo
        } else if (intensity > 0.6) {
          size = 32;
          color = '#f97316'; // naranja
        } else if (intensity > 0.4) {
          size = 26;
          color = '#eab308'; // amarillo
        } else if (intensity > 0.2) {
          size = 22;
          color = '#3b82f6'; // azul
        }

        // Crear elemento HTML para el marcador de calor
        const heatElement = document.createElement('div');
        heatElement.className = 'heat-marker';
        heatElement.style.cssText = `
          width: ${size}px;
          height: ${size}px;
          background-color: ${color};
          border-radius: 50%;
          opacity: 0.7;
          border: 2px solid white;
          box-shadow: 0 2px 4px rgba(0,0,0,0.3);
          cursor: pointer;
          display: flex;
          align-items: center;
          justify-content: center;
          color: white;
          font-weight: bold;
          font-size: ${size > 30 ? '12px' : '10px'};
        `;
        heatElement.textContent = point.count.toString();

        // Crear popup detallado con información por categorías
        const categoriesInfo = Object.entries(point.categories)
          .sort(([,a], [,b]) => (b as number) - (a as number))
          .map(([cat, count]) => `${getCategoryLabel(cat)}: ${count}`)
          .join('<br>');

        // Agregar marcador de calor
        new mapboxgl.Marker(heatElement)
          .setLngLat([point.lng, point.lat])
          .setPopup(
            new mapboxgl.Popup({ 
              offset: 15,
              closeButton: true,
              closeOnClick: false
            })
              .setHTML(`
                <div class="p-3 min-w-48">
                  <h4 class="font-semibold text-sm mb-2 text-gray-800">
                    📍 Zona de Alta Densidad
                  </h4>
                  <div class="mb-2">
                    <span class="text-lg font-bold text-red-600">${point.count}</span>
                    <span class="text-sm text-gray-600 ml-1">reportes totales</span>
                  </div>
                  <div class="text-xs text-gray-700 mb-2">
                    <strong>Desglose por categoría:</strong><br>
                    ${categoriesInfo}
                  </div>
                  <div class="text-xs text-gray-500 border-t pt-2">
                    💡 Esta área requiere atención prioritaria
                  </div>
                </div>
              `)
          )
          .addTo(heatMap.current!);
      });

      // Si hay múltiples puntos, ajustar vista para mostrar todos
      if (heatmapData.length > 1) {
        const bounds = new mapboxgl.LngLatBounds();
        heatmapData.forEach(point => {
          bounds.extend([point.lng, point.lat]);
        });
        heatMap.current!.fitBounds(bounds, { padding: 50 });
      }

      // Agregar funcionalidad de click en cualquier zona del mapa
      heatMap.current.on('click', (e) => {
        const clickedLng = e.lngLat.lng;
        const clickedLat = e.lngLat.lat;
        
        // Buscar reportes cercanos al punto clickeado (radio de ~100 metros)
        const nearbyReports = reportsWithCoords.filter(report => {
          const distance = Math.sqrt(
            Math.pow((report.latitude! - clickedLat) * 111000, 2) + 
            Math.pow((report.longitude! - clickedLng) * 111000 * Math.cos(clickedLat * Math.PI / 180), 2)
          );
          return distance <= 500; // 500 metros de radio
        });

        if (nearbyReports.length > 0) {
          // Agrupar por categorías
          const categoriesInArea = nearbyReports.reduce((acc, report) => {
            if (!acc[report.category]) {
              acc[report.category] = 0;
            }
            acc[report.category]++;
            return acc;
          }, {} as Record<string, number>);

          const categoriesInfo = Object.entries(categoriesInArea)
            .sort(([,a], [,b]) => b - a)
            .map(([cat, count]) => `${getCategoryLabel(cat)}: ${count}`)
            .join('<br>');

          // Crear popup para la zona clickeada
          new mapboxgl.Popup({ 
            closeButton: true,
            closeOnClick: true
          })
            .setLngLat([clickedLng, clickedLat])
            .setHTML(`
              <div class="p-3 min-w-48">
                <h4 class="font-semibold text-sm mb-2 text-gray-800">
                  🔍 Análisis de Zona
                </h4>
                <div class="mb-2">
                  <span class="text-lg font-bold text-blue-600">${nearbyReports.length}</span>
                  <span class="text-sm text-gray-600 ml-1">reportes en 500m</span>
                </div>
                <div class="text-xs text-gray-700 mb-2">
                  <strong>Distribución por tipo:</strong><br>
                  ${categoriesInfo}
                </div>
                <div class="text-xs text-gray-500 border-t pt-2">
                  💡 Radio de análisis: 500 metros
                </div>
              </div>
            `)
            .addTo(heatMap.current!);
        } else {
          // Mostrar mensaje cuando no hay reportes cerca
          new mapboxgl.Popup({ 
            closeButton: true,
            closeOnClick: true
          })
            .setLngLat([clickedLng, clickedLat])
            .setHTML(`
              <div class="p-3">
                <h4 class="font-semibold text-sm mb-2 text-gray-800">
                  📍 Zona Analizada
                </h4>
                <p class="text-sm text-gray-600">
                  No hay reportes en un radio de 500 metros
                </p>
                <div class="text-xs text-gray-500 mt-2">
                  ✅ Esta zona está libre de incidencias
                </div>
              </div>
            `)
            .addTo(heatMap.current!);
        }
      });

      // Cambiar cursor al pasar sobre el mapa
      heatMap.current.on('mouseenter', () => {
        heatMap.current!.getCanvas().style.cursor = 'crosshair';
      });

      heatMap.current.on('mouseleave', () => {
        heatMap.current!.getCanvas().style.cursor = '';
      });
    });

    // Cleanup
    return () => {
      heatMap.current?.remove();
    };
  }, [heatmapData, reportsWithCoords]);

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

  // Obtener zonas calientes por barrios
  const getHotZonesByNeighborhood = () => {
    if (filteredReports.length === 0) return [];

    // Agrupar reportes por barrio
    const grouped = filteredReports.reduce((acc, report) => {
      const neighborhood = report.neighborhood || 'Sin especificar';
      if (!acc[neighborhood]) {
        acc[neighborhood] = {
          name: neighborhood,
          count: 0,
          categories: {} as Record<string, number>,
          reports: []
        };
      }
      acc[neighborhood].count++;
      acc[neighborhood].reports.push(report);
      
      // Contar por categorías
      if (!acc[neighborhood].categories[report.category]) {
        acc[neighborhood].categories[report.category] = 0;
      }
      acc[neighborhood].categories[report.category]++;
      
      return acc;
    }, {} as Record<string, any>);

    // Convertir a array y ordenar por cantidad de reportes
    return Object.values(grouped)
      .sort((a: any, b: any) => b.count - a.count)
      .slice(0, 10); // Top 10 barrios
  };

  const hotZones = getHotZonesByNeighborhood();

  const getZoneRiskLevel = (count: number, maxZoneCount: number) => {
    const intensity = count / maxZoneCount;
    if (intensity > 0.7) return { level: 'Muy Alto', color: 'bg-red-500', textColor: 'text-red-700', bgColor: 'bg-red-50' };
    if (intensity > 0.5) return { level: 'Alto', color: 'bg-orange-500', textColor: 'text-orange-700', bgColor: 'bg-orange-50' };
    if (intensity > 0.3) return { level: 'Medio', color: 'bg-yellow-500', textColor: 'text-yellow-700', bgColor: 'bg-yellow-50' };
    return { level: 'Bajo', color: 'bg-green-500', textColor: 'text-green-700', bgColor: 'bg-green-50' };
  };

  const maxZoneCount = hotZones.length > 0 ? hotZones[0].count : 1;

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
          <div className="space-y-6">
            {/* Layout principal: Mapa de calor y Zonas calientes */}
            <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
              {/* Mapa de calor real con fondo geográfico */}
              <div className="lg:col-span-2">
                <div 
                  ref={heatMapContainer} 
                  className="w-full h-96 rounded-lg border shadow-lg"
                  style={{ minHeight: '400px' }}
                >
                  {/* El mapa real se carga aquí */}
                </div>

                {/* Leyenda */}
                <div className="flex items-center justify-between p-4 bg-gray-50 rounded-lg mt-4">
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
              </div>

              {/* Zonas Calientes */}
              <div className="lg:col-span-1">
                <div className="bg-white border rounded-lg p-4 h-fit">
                  <div className="flex items-center gap-2 mb-4">
                    <TrendingUp className="h-5 w-5 text-red-500" />
                    <h3 className="text-lg font-semibold text-gray-800">Zonas Calientes</h3>
                  </div>
                  
                  {hotZones.length === 0 ? (
                    <div className="text-center py-8">
                      <AlertCircle className="h-8 w-8 text-gray-400 mx-auto mb-2" />
                      <p className="text-sm text-gray-500">Sin datos de barrios</p>
                    </div>
                  ) : (
                    <div className="space-y-3 max-h-96 overflow-y-auto">
                      {hotZones.map((zone: any, index) => {
                        const riskLevel = getZoneRiskLevel(zone.count, maxZoneCount);
                        const topCategory = Object.entries(zone.categories)
                          .sort(([,a], [,b]) => (b as number) - (a as number))[0];
                        
                        return (
                          <div 
                            key={index} 
                            className={`p-3 rounded-lg border-l-4 ${riskLevel.bgColor} border-l-${riskLevel.color.replace('bg-', '')}`}
                          >
                            <div className="flex items-center justify-between mb-2">
                              <h4 className="font-medium text-sm text-gray-800 truncate">
                                {zone.name}
                              </h4>
                              <div className="flex items-center gap-2">
                                <div className={`w-2 h-2 rounded-full ${riskLevel.color}`}></div>
                                <span className={`text-xs font-medium ${riskLevel.textColor}`}>
                                  {riskLevel.level}
                                </span>
                              </div>
                            </div>
                            
                            <div className="space-y-2">
                              <div className="flex items-center justify-between">
                                <span className="text-lg font-bold text-gray-900">
                                  {zone.count}
                                </span>
                                <span className="text-xs text-gray-600">
                                  reportes totales
                                </span>
                              </div>
                              
                              {topCategory && (
                                <div className="space-y-1">
                                  <div className="text-xs text-gray-600">
                                    <span className="font-medium">Principal: </span>
                                    {getCategoryLabel(String(topCategory[0]))} 
                                    <span className="font-bold text-primary ml-1">
                                      ({String(topCategory[1])} reportes)
                                    </span>
                                  </div>
                                  
                                  {Object.entries(zone.categories).length > 1 && (
                                    <div className="text-xs text-gray-500">
                                      <span className="font-medium">Otras: </span>
                                      {Object.entries(zone.categories)
                                        .sort(([,a], [,b]) => (b as number) - (a as number))
                                        .slice(1, 3)
                                        .map(([cat, count]) => `${getCategoryLabel(cat)} (${count})`)
                                        .join(', ')}
                                      {Object.entries(zone.categories).length > 3 && '...'}
                                    </div>
                                  )}
                                </div>
                              )}
                              
                              <div className="pt-1 border-t border-gray-200">
                                <p className="text-xs text-gray-500">
                                  💡 Zona de alta concentración - requiere atención
                                </p>
                              </div>
                            </div>
                          </div>
                        );
                      })}
                    </div>
                  )}
                </div>
              </div>
            </div>

            {/* Mapa Real de Mapbox */}
            <div>
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