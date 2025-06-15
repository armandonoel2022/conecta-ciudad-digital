
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Play, Calendar } from 'lucide-react';
import { useBeforeAfterVideos } from '@/hooks/useBeforeAfterVideos';
import { format } from 'date-fns';
import { es } from 'date-fns/locale';

const VideoList = () => {
  const { videos, loading } = useBeforeAfterVideos();

  const formatFileSize = (bytes: number | null) => {
    if (!bytes) return 'N/A';
    const mb = bytes / 1024 / 1024;
    return `${mb.toFixed(2)} MB`;
  };

  if (loading) {
    return (
      <div className="flex justify-center items-center py-12">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
      </div>
    );
  }

  if (videos.length === 0) {
    return (
      <Card>
        <CardContent className="py-12 text-center">
          <Play className="h-16 w-16 text-gray-400 mx-auto mb-4" />
          <p className="text-gray-600 text-lg">No hay videos disponibles</p>
          <p className="text-sm text-gray-500 mt-2">
            Próximamente se compartirán videos de las transformaciones
          </p>
        </CardContent>
      </Card>
    );
  }

  return (
    <div className="space-y-8">
      {videos.map((video) => (
        <Card key={video.id} className="overflow-hidden shadow-lg hover:shadow-xl transition-shadow">
          <CardContent className="p-0">
            {/* Video Container - Optimized for vertical format */}
            <div className="relative bg-black">
              <video
                controls
                className="w-full max-h-[70vh] object-contain mx-auto"
                preload="metadata"
                poster=""
              >
                <source src={video.video_url} type="video/mp4" />
                <source src={video.video_url} type="video/webm" />
                <source src={video.video_url} type="video/ogg" />
                Tu navegador no soporta la reproducción de videos.
              </video>
            </div>

            {/* Video Info */}
            <div className="p-6 space-y-4">
              <div>
                <h3 className="text-2xl font-bold text-gray-800 mb-2">
                  {video.title}
                </h3>
                <div className="flex items-center gap-4 text-sm text-gray-500 mb-4">
                  <div className="flex items-center gap-2">
                    <Calendar className="h-4 w-4" />
                    {format(new Date(video.created_at), 'dd/MM/yyyy', { locale: es })}
                  </div>
                </div>
              </div>

              {video.description && (
                <div className="bg-gray-50 rounded-lg p-4">
                  <p className="text-gray-700 leading-relaxed whitespace-pre-wrap">
                    {video.description}
                  </p>
                </div>
              )}

              {/* File Info */}
              <div className="flex flex-wrap gap-2 pt-4 border-t border-gray-100">
                <Badge variant="secondary" className="text-xs">
                  {formatFileSize(video.file_size)}
                </Badge>
                <Badge variant="outline" className="text-xs">
                  Formato vertical
                </Badge>
              </div>
            </div>
          </CardContent>
        </Card>
      ))}
    </div>
  );
};

export default VideoList;
