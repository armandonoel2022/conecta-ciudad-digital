
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Play, Trash2, Calendar, User } from 'lucide-react';
import { useBeforeAfterVideos } from '@/hooks/useBeforeAfterVideos';
import { useAuth } from '@/hooks/useAuth';
import { format } from 'date-fns';
import { es } from 'date-fns/locale';

const VideoList = () => {
  const { videos, loading, deleteVideo } = useBeforeAfterVideos();
  const { user } = useAuth();

  const handleDelete = async (videoId: string, fileName: string) => {
    if (confirm('¿Estás seguro de que quieres eliminar este video?')) {
      await deleteVideo(videoId, fileName);
    }
  };

  const formatFileSize = (bytes: number | null) => {
    if (!bytes) return 'N/A';
    const mb = bytes / 1024 / 1024;
    return `${mb.toFixed(2)} MB`;
  };

  if (loading) {
    return (
      <div className="space-y-4">
        {[1, 2, 3].map((i) => (
          <Card key={i} className="animate-pulse">
            <CardContent className="h-24"></CardContent>
          </Card>
        ))}
      </div>
    );
  }

  if (videos.length === 0) {
    return (
      <Card>
        <CardContent className="py-8 text-center">
          <Play className="h-12 w-12 text-gray-400 mx-auto mb-4" />
          <p className="text-gray-600">No hay videos disponibles</p>
          <p className="text-sm text-gray-500 mt-1">
            Sé el primero en subir un video del antes y después
          </p>
        </CardContent>
      </Card>
    );
  }

  return (
    <div className="space-y-4">
      {videos.map((video) => (
        <Card key={video.id} className="hover:shadow-md transition-shadow">
          <CardHeader>
            <div className="flex items-start justify-between">
              <div className="flex-1">
                <CardTitle className="text-lg text-gray-800 mb-1">
                  {video.title}
                </CardTitle>
                <div className="flex items-center gap-4 text-sm text-gray-500">
                  <div className="flex items-center gap-1">
                    <Calendar className="h-4 w-4" />
                    {format(new Date(video.created_at), 'dd/MM/yyyy', { locale: es })}
                  </div>
                  <div className="flex items-center gap-1">
                    <User className="h-4 w-4" />
                    Usuario
                  </div>
                </div>
              </div>
              {user?.id === video.user_id && (
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={() => handleDelete(video.id, video.file_name)}
                  className="text-red-600 hover:text-red-700 hover:bg-red-50"
                >
                  <Trash2 className="h-4 w-4" />
                </Button>
              )}
            </div>
          </CardHeader>
          <CardContent>
            {video.description && (
              <p className="text-gray-700 mb-4 text-sm leading-relaxed">
                {video.description}
              </p>
            )}
            
            <div className="aspect-video bg-black rounded-lg overflow-hidden mb-4">
              <video
                controls
                className="w-full h-full object-contain"
                preload="metadata"
              >
                <source src={video.video_url} type="video/mp4" />
                <source src={video.video_url} type="video/webm" />
                <source src={video.video_url} type="video/ogg" />
                Tu navegador no soporta la reproducción de videos.
              </video>
            </div>

            <div className="flex items-center justify-between">
              <div className="flex gap-2">
                <Badge variant="secondary" className="text-xs">
                  {video.file_name}
                </Badge>
                <Badge variant="outline" className="text-xs">
                  {formatFileSize(video.file_size)}
                </Badge>
              </div>
              <Button
                size="sm"
                onClick={() => window.open(video.video_url, '_blank')}
                className="bg-purple-600 hover:bg-purple-700 text-white"
              >
                <Play className="h-4 w-4 mr-1" />
                Ver completo
              </Button>
            </div>
          </CardContent>
        </Card>
      ))}
    </div>
  );
};

export default VideoList;
