import React, { useState } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { Progress } from "@/components/ui/progress";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { 
  Brain, 
  TrendingUp, 
  MapPin, 
  AlertTriangle, 
  Target, 
  Activity,
  Zap,
  BarChart3,
  Radar,
  Clock,
  ArrowUp,
  ArrowDown,
  Minus
} from "lucide-react";
import { useAdvancedAnalytics, useClusterAnalysis, usePredictiveAnalysis } from "@/hooks/useAdvancedAnalyticsOptimized";
import { format } from 'date-fns';

interface DataMiningDashboardProps {
  dateRange?: [Date, Date] | null;
}

const DataMiningDashboard: React.FC<DataMiningDashboardProps> = ({ dateRange }) => {
  const { data: advancedData, isLoading: isLoadingAdvanced } = useAdvancedAnalytics(dateRange);
  const { data: clusters, isLoading: isLoadingClusters } = useClusterAnalysis();
  const { data: predictions, isLoading: isLoadingPredictions } = usePredictiveAnalysis();
  const [selectedAnomaly, setSelectedAnomaly] = useState<any>(null);

  if (isLoadingAdvanced || isLoadingClusters || isLoadingPredictions) {
    return (
      <div className="space-y-6">
        <div className="text-center">
          <div className="inline-flex items-center gap-2 text-primary">
            <Brain className="h-6 w-6 animate-pulse" />
            <span className="text-lg font-medium">Procesando análisis avanzado...</span>
          </div>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          {[1, 2, 3].map((i) => (
            <Card key={i} className="animate-pulse">
              <CardHeader>
                <div className="h-4 bg-muted rounded w-3/4"></div>
                <div className="h-3 bg-muted rounded w-1/2"></div>
              </CardHeader>
              <CardContent>
                <div className="h-8 bg-muted rounded"></div>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    );
  }

  const getRiskLevelColor = (level: string) => {
    switch (level) {
      case 'critical': return 'destructive';
      case 'high': return 'destructive';
      case 'medium': return 'secondary';
      default: return 'outline';
    }
  };

  const getTrendIcon = (trend: string) => {
    switch (trend) {
      case 'increasing': return <ArrowUp className="h-4 w-4 text-red-500" />;
      case 'decreasing': return <ArrowDown className="h-4 w-4 text-green-500" />;
      default: return <Minus className="h-4 w-4 text-gray-500" />;
    }
  };

  const getTimelineColor = (timeline: string) => {
    switch (timeline) {
      case 'next_week': return 'destructive';
      case 'next_month': return 'secondary';
      default: return 'default';
    }
  };

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center gap-3">
        <div className="p-3 bg-white/20 rounded-xl">
          <Brain className="h-6 w-6 text-white" />
        </div>
        <div className="flex-1">
          <h2 className="text-2xl font-bold text-white">Data Mining & Analytics Avanzado</h2>
          <p className="text-white/90">
            Análisis inteligente de patrones, predicciones y anomalías
          </p>
        </div>
        {/* Indicador de procesamiento */}
        {advancedData && (
          <div className="bg-white/10 px-3 py-2 rounded-lg">
            <div className="flex items-center gap-2 text-white">
              {advancedData.processingLocation === 'server' ? (
                <>
                  <Zap className="h-4 w-4 text-green-400" />
                  <span className="text-sm font-medium">Servidor</span>
                </>
              ) : (
                <>
                  <Activity className="h-4 w-4 text-yellow-400" />
                  <span className="text-sm font-medium">Cliente</span>
                </>
              )}
            </div>
          </div>
        )}
      </div>

      <Tabs defaultValue="clusters" className="space-y-6">
        <TabsList className="grid w-full grid-cols-5">
          <TabsTrigger value="clusters" className="flex items-center gap-2">
            <MapPin className="h-4 w-4" />
            Clusters
          </TabsTrigger>
          <TabsTrigger value="predictions" className="flex items-center gap-2">
            <Target className="h-4 w-4" />
            Predicciones
          </TabsTrigger>
          <TabsTrigger value="correlations" className="flex items-center gap-2">
            <Activity className="h-4 w-4" />
            Correlaciones
          </TabsTrigger>
          <TabsTrigger value="anomalies" className="flex items-center gap-2">
            <AlertTriangle className="h-4 w-4" />
            Anomalías
          </TabsTrigger>
          <TabsTrigger value="trends" className="flex items-center gap-2">
            <TrendingUp className="h-4 w-4" />
            Tendencias
          </TabsTrigger>
        </TabsList>

        {/* Clusters Tab */}
        <TabsContent value="clusters" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <MapPin className="h-5 w-5" />
                Análisis de Clusters Geográficos
              </CardTitle>
              <CardDescription>
                Agrupación automática de reportes por proximidad geográfica y densidad
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                {clusters?.map((cluster, index) => (
                  <Card key={cluster.id} className="relative">
                    <CardHeader className="pb-3">
                      <div className="flex items-center justify-between">
                        <CardTitle className="text-sm">Cluster {index + 1}</CardTitle>
                        <Badge variant={getRiskLevelColor(cluster.riskLevel)}>
                          {cluster.riskLevel.toUpperCase()}
                        </Badge>
                      </div>
                    </CardHeader>
                    <CardContent className="space-y-3">
                      <div className="flex items-center justify-between text-sm">
                        <span className="text-muted-foreground">Reportes:</span>
                        <span className="font-medium">{cluster.density}</span>
                      </div>
                      <div className="flex items-center justify-between text-sm">
                        <span className="text-muted-foreground">Radio:</span>
                        <span className="font-medium">{cluster.radius.toFixed(4)}°</span>
                      </div>
                      <div className="flex items-center justify-between text-sm">
                        <span className="text-muted-foreground">Centro:</span>
                        <span className="text-xs font-mono">
                          {cluster.center.latitude.toFixed(4)}, {cluster.center.longitude.toFixed(4)}
                        </span>
                      </div>
                      {cluster.riskLevel === 'critical' && (
                        <Alert className="mt-2">
                          <AlertTriangle className="h-4 w-4" />
                          <AlertDescription className="text-xs">
                            Área de alta prioridad - Requiere atención inmediata
                          </AlertDescription>
                        </Alert>
                      )}
                    </CardContent>
                  </Card>
                ))}
              </div>
              
              {(!clusters || clusters.length === 0) && (
                <div className="text-center text-muted-foreground py-8">
                  <MapPin className="h-12 w-12 mx-auto mb-4 opacity-50" />
                  <p>No hay suficientes datos para generar clusters geográficos</p>
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>

        {/* Predictions Tab */}
        <TabsContent value="predictions" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Target className="h-5 w-5" />
                Análisis Predictivo
              </CardTitle>
              <CardDescription>
                Predicciones basadas en tendencias históricas y patrones de comportamiento
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                {predictions?.map((prediction, index) => (
                  <Card key={index}>
                    <CardHeader className="pb-3">
                      <div className="flex items-center justify-between">
                        <CardTitle className="text-sm">{prediction.area}</CardTitle>
                        <Badge variant={getTimelineColor(prediction.timeline)}>
                          {prediction.timeline.replace('_', ' ').toUpperCase()}
                        </Badge>
                      </div>
                    </CardHeader>
                    <CardContent className="space-y-4">
                      <div className="flex items-center justify-between">
                        <span className="text-sm text-muted-foreground">Problemas predichos:</span>
                        <span className="text-lg font-bold text-primary">
                          {prediction.predictedIssues}
                        </span>
                      </div>
                      
                      <div className="space-y-2">
                        <div className="flex items-center justify-between text-sm">
                          <span className="text-muted-foreground">Confianza:</span>
                          <span className="font-medium">
                            {(prediction.confidence * 100).toFixed(0)}%
                          </span>
                        </div>
                        <Progress value={prediction.confidence * 100} className="h-2" />
                      </div>

                      {prediction.riskFactors.length > 0 && (
                        <div className="space-y-2">
                          <span className="text-sm font-medium">Factores de riesgo:</span>
                          <ul className="space-y-1">
                            {prediction.riskFactors.map((factor, i) => (
                              <li key={i} className="text-xs text-muted-foreground flex items-center gap-2">
                                <div className="w-1 h-1 bg-orange-500 rounded-full" />
                                {factor}
                              </li>
                            ))}
                          </ul>
                        </div>
                      )}

                      {prediction.recommendations.length > 0 && (
                        <div className="space-y-2">
                          <span className="text-sm font-medium">Recomendaciones:</span>
                          <ul className="space-y-1">
                            {prediction.recommendations.map((rec, i) => (
                              <li key={i} className="text-xs text-muted-foreground flex items-center gap-2">
                                <div className="w-1 h-1 bg-green-500 rounded-full" />
                                {rec}
                              </li>
                            ))}
                          </ul>
                        </div>
                      )}
                    </CardContent>
                  </Card>
                ))}
              </div>

              {(!predictions || predictions.length === 0) && (
                <div className="text-center text-muted-foreground py-8">
                  <Target className="h-12 w-12 mx-auto mb-4 opacity-50" />
                  <p>No hay suficientes datos históricos para generar predicciones</p>
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>

        {/* Correlations Tab */}
        <TabsContent value="correlations" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Activity className="h-5 w-5" />
                Análisis de Correlaciones
              </CardTitle>
              <CardDescription>
                Identificación de patrones y relaciones entre diferentes tipos de problemas
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {advancedData?.correlations?.map((corr, index) => (
                  <Card key={index}>
                    <CardContent className="pt-4">
                      <div className="flex items-center justify-between mb-3">
                        <div className="flex items-center gap-2">
                          <Badge variant="outline">{corr.category1}</Badge>
                          <Activity className="h-4 w-4 text-muted-foreground" />
                          <Badge variant="outline">{corr.category2}</Badge>
                        </div>
                        <div className="flex items-center gap-2">
                          <span className="text-sm text-muted-foreground">Correlación:</span>
                          <span className="font-bold text-primary">
                            {(corr.correlation * 100).toFixed(0)}%
                          </span>
                        </div>
                      </div>
                      
                      <div className="space-y-2">
                        <Progress value={corr.correlation * 100} className="h-2" />
                        <div className="flex items-center justify-between text-sm">
                          <span className="text-muted-foreground">Significancia estadística:</span>
                          <span className="font-medium">
                            {(corr.significance * 100).toFixed(0)}%
                          </span>
                        </div>
                      </div>

                      <div className="mt-3 space-y-1">
                        {corr.patterns.map((pattern, i) => (
                          <p key={i} className="text-xs text-muted-foreground flex items-center gap-2">
                            <div className="w-1 h-1 bg-blue-500 rounded-full" />
                            {pattern}
                          </p>
                        ))}
                      </div>
                    </CardContent>
                  </Card>
                ))}
              </div>

              {(!advancedData?.correlations || advancedData.correlations.length === 0) && (
                <div className="text-center text-muted-foreground py-8">
                  <Activity className="h-12 w-12 mx-auto mb-4 opacity-50" />
                  <p>No se encontraron correlaciones significativas en los datos</p>
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>

        {/* Anomalies Tab */}
        <TabsContent value="anomalies" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <AlertTriangle className="h-5 w-5" />
                Detección de Anomalías
              </CardTitle>
              <CardDescription>
                Identificación automática de reportes con patrones inusuales
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                {advancedData?.anomalies?.map((anomaly, index) => (
                  <Card key={index} className="border-l-4 border-l-orange-500">
                    <CardContent className="pt-4">
                      <div className="flex items-center justify-between mb-2">
                        <div className="flex items-center gap-2">
                          <Badge variant="secondary">{anomaly.anomalyType}</Badge>
                          <span className="text-sm text-muted-foreground">
                            Score: {anomaly.score.toFixed(2)}
                          </span>
                        </div>
                        <div className="flex items-center gap-1 text-xs text-muted-foreground">
                          <Clock className="h-3 w-3" />
                          {format(new Date(anomaly.created_at), 'dd/MM/yyyy HH:mm')}
                        </div>
                      </div>
                      <p className="text-sm">{anomaly.description}</p>
                      <Dialog>
                        <DialogTrigger asChild>
                          <Button 
                            variant="link" 
                            size="sm" 
                            className="p-0 h-auto text-xs"
                            onClick={() => setSelectedAnomaly(anomaly)}
                          >
                            Ver detalles →
                          </Button>
                        </DialogTrigger>
                        <DialogContent className="max-w-2xl">
                          <DialogHeader>
                            <DialogTitle>Detalles de Anomalía</DialogTitle>
                          </DialogHeader>
                          {selectedAnomaly && (
                            <div className="space-y-4">
                              <div className="grid grid-cols-2 gap-4">
                                <div>
                                  <label className="text-sm font-medium text-muted-foreground">Tipo de Anomalía</label>
                                  <p className="text-sm">{selectedAnomaly.anomalyType}</p>
                                </div>
                                <div>
                                  <label className="text-sm font-medium text-muted-foreground">Score</label>
                                  <p className="text-sm font-bold">{selectedAnomaly.score.toFixed(2)}</p>
                                </div>
                              </div>
                              
                              <div>
                                <label className="text-sm font-medium text-muted-foreground">Descripción</label>
                                <p className="text-sm mt-1">{selectedAnomaly.description}</p>
                              </div>
                              
                              <div>
                                <label className="text-sm font-medium text-muted-foreground">Fecha de Detección</label>
                                <p className="text-sm mt-1">
                                  {format(new Date(selectedAnomaly.created_at), 'dd/MM/yyyy HH:mm')}
                                </p>
                              </div>
                              
                              <div className="mt-6 p-4 bg-muted/50 rounded-lg">
                                <h4 className="font-medium mb-2">Análisis Detallado</h4>
                                <div className="space-y-3 text-sm text-muted-foreground">
                                  <div>
                                    <strong>Tipo de Anomalía:</strong> {selectedAnomaly.anomalyType === 'timing' ? 'Temporal' : selectedAnomaly.anomalyType === 'location' ? 'Geográfica' : selectedAnomaly.anomalyType === 'frequency' ? 'Frecuencia' : 'Categoría'}
                                  </div>
                                  
                                  <div>
                                    <strong>Score de Anomalía:</strong> {selectedAnomaly.score.toFixed(2)}/100
                                    <div className="text-xs mt-1">
                                      {selectedAnomaly.score > 50 
                                        ? '🔴 Anomalía significativa - Requiere investigación inmediata' 
                                        : selectedAnomaly.score > 20 
                                        ? '🟡 Anomalía moderada - Monitoreo recomendado'
                                        : '🟢 Anomalía leve - Para revisión rutinaria'
                                      }
                                    </div>
                                  </div>

                                  <div>
                                    <strong>Explicación del Score:</strong>
                                    <div className="text-xs mt-1">
                                      {selectedAnomaly.anomalyType === 'timing' && 
                                        'Este reporte fue creado en una hora del día cuando típicamente hay muy pocos reportes. El score representa cuántas veces más reportes hay en esta hora comparado con el promedio.'
                                      }
                                      {selectedAnomaly.anomalyType === 'location' && 
                                        'Este reporte proviene de un área que históricamente tiene muy pocos reportes. El score indica qué tan inusual es la actividad en esta zona.'
                                      }
                                      {selectedAnomaly.anomalyType === 'frequency' && 
                                        'Se detectó un patrón inusual en la frecuencia de reportes para esta categoría o área.'
                                      }
                                      {selectedAnomaly.anomalyType === 'category' && 
                                        'Esta combinación de categoría y ubicación es estadísticamente inusual según los patrones históricos.'
                                      }
                                    </div>
                                  </div>

                                  <div>
                                    <strong>¿Por qué es importante?</strong>
                                    <div className="text-xs mt-1">
                                      Las anomalías pueden indicar: eventos emergentes que requieren atención, posibles errores en el reporte, cambios en los patrones de la comunidad, o nuevos problemas que están surgiendo en áreas específicas.
                                    </div>
                                  </div>
                                </div>
                              </div>
                              
                              <div className="bg-blue-50 p-4 rounded-lg">
                                <h4 className="font-medium mb-2 text-blue-800">Recomendaciones</h4>
                                <ul className="text-sm text-blue-700 space-y-1">
                                  <li>• Verificar la validez del reporte original</li>
                                  <li>• Investigar posibles causas subyacentes</li>
                                  <li>• Monitorear patrones similares en la zona</li>
                                  <li>• Considerar ajustes en los protocolos de respuesta</li>
                                </ul>
                              </div>
                            </div>
                          )}
                        </DialogContent>
                      </Dialog>
                    </CardContent>
                  </Card>
                ))}
              </div>

              {(!advancedData?.anomalies || advancedData.anomalies.length === 0) && (
                <div className="text-center text-muted-foreground py-8">
                  <AlertTriangle className="h-12 w-12 mx-auto mb-4 opacity-50" />
                  <p>No se detectaron anomalías significativas en los datos</p>
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>

        {/* Trends Tab */}
        <TabsContent value="trends" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <TrendingUp className="h-5 w-5" />
                Análisis de Tendencias
              </CardTitle>
              <CardDescription>
                Análisis temporal y proyecciones futuras por categoría
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                {advancedData?.trends?.map((trend, index) => (
                  <Card key={index}>
                    <CardHeader className="pb-3">
                      <div className="flex items-center justify-between">
                        <CardTitle className="text-sm capitalize">{trend.category}</CardTitle>
                        <div className="flex items-center gap-2">
                          {getTrendIcon(trend.trend)}
                          <span className="text-xs text-muted-foreground capitalize">
                            {trend.trend}
                          </span>
                        </div>
                      </div>
                    </CardHeader>
                    <CardContent className="space-y-4">
                      <div className="flex items-center justify-between text-sm">
                        <span className="text-muted-foreground">Tasa de cambio:</span>
                        <span className={`font-medium ${
                          trend.changeRate > 0 ? 'text-red-500' : 
                          trend.changeRate < 0 ? 'text-green-500' : 'text-gray-500'
                        }`}>
                          {trend.changeRate > 0 ? '+' : ''}{(trend.changeRate * 100).toFixed(1)}%
                        </span>
                      </div>

                      <div className="flex items-center justify-between text-sm">
                        <span className="text-muted-foreground">Estacionalidad:</span>
                        <span className="font-medium">
                          {(trend.seasonality * 100).toFixed(1)}%
                        </span>
                      </div>

                      <div className="space-y-2">
                        <span className="text-sm font-medium">Pronóstico (próximos 3 meses):</span>
                        <div className="flex items-center gap-2">
                          {trend.forecast.map((value, i) => (
                            <div key={i} className="flex-1 text-center">
                              <div className="text-lg font-bold text-primary">{value}</div>
                              <div className="text-xs text-muted-foreground">Mes {i + 1}</div>
                            </div>
                          ))}
                        </div>
                      </div>

                      {trend.trend === 'increasing' && trend.changeRate > 0.3 && (
                        <Alert>
                          <AlertTriangle className="h-4 w-4" />
                          <AlertDescription className="text-xs">
                            Tendencia creciente significativa - Considerar intervención preventiva
                          </AlertDescription>
                        </Alert>
                      )}
                    </CardContent>
                  </Card>
                ))}
              </div>

              {(!advancedData?.trends || advancedData.trends.length === 0) && (
                <div className="text-center text-muted-foreground py-8">
                  <TrendingUp className="h-12 w-12 mx-auto mb-4 opacity-50" />
                  <p>No hay suficientes datos históricos para análisis de tendencias</p>
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>

      {/* Summary Stats */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <BarChart3 className="h-5 w-5" />
            Resumen del Análisis
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            <div className="text-center">
              <div className="text-2xl font-bold text-primary">{clusters?.length || 0}</div>
              <div className="text-sm text-muted-foreground">Clusters Identificados</div>
            </div>
            <div className="text-center">
              <div className="text-2xl font-bold text-primary">{predictions?.length || 0}</div>
              <div className="text-sm text-muted-foreground">Áreas Analizadas</div>
            </div>
            <div className="text-center">
              <div className="text-2xl font-bold text-primary">{advancedData?.anomalies?.length || 0}</div>
              <div className="text-sm text-muted-foreground">Anomalías Detectadas</div>
            </div>
            <div className="text-center">
              <div className="text-2xl font-bold text-primary">{advancedData?.totalReports || 0}</div>
              <div className="text-sm text-muted-foreground">Reportes Analizados</div>
            </div>
          </div>
          
          {advancedData?.processedAt && (
            <div className="mt-4 pt-4 border-t text-center text-xs text-muted-foreground">
              Última actualización: {format(new Date(advancedData.processedAt), 'dd/MM/yyyy HH:mm:ss')} 
              <span className="ml-2 text-green-600">
                {advancedData.processingLocation === 'server' ? '⚡ Servidor' : '🔄 Cliente'}
              </span>
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
};

export default DataMiningDashboard;