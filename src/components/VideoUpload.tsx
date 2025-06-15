
import { useState, useRef } from 'react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Upload, X, Video } from 'lucide-react';
import { useBeforeAfterVideos } from '@/hooks/useBeforeAfterVideos';

const VideoUpload = () => {
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');
  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [showUploadForm, setShowUploadForm] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const { uploading, uploadVideo } = useBeforeAfterVideos();

  const handleFileSelect = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file && file.type.startsWith('video/')) {
      setSelectedFile(file);
    } else {
      alert('Por favor seleccione un archivo de video válido');
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!selectedFile || !title.trim()) {
      alert('Por favor complete todos los campos requeridos');
      return;
    }

    const result = await uploadVideo(selectedFile, title, description);
    
    if (result) {
      // Reset form
      setTitle('');
      setDescription('');
      setSelectedFile(null);
      setShowUploadForm(false);
      if (fileInputRef.current) {
        fileInputRef.current.value = '';
      }
    }
  };

  const resetForm = () => {
    setTitle('');
    setDescription('');
    setSelectedFile(null);
    setShowUploadForm(false);
    if (fileInputRef.current) {
      fileInputRef.current.value = '';
    }
  };

  if (!showUploadForm) {
    return (
      <Button 
        onClick={() => setShowUploadForm(true)}
        className="w-full bg-purple-600 hover:bg-purple-700 text-white"
      >
        <Upload className="h-4 w-4 mr-2" />
        Subir Video
      </Button>
    );
  }

  return (
    <Card className="w-full">
      <CardHeader className="flex flex-row items-center justify-between">
        <CardTitle className="text-lg">Subir Video</CardTitle>
        <Button
          variant="ghost"
          size="sm"
          onClick={resetForm}
          disabled={uploading}
        >
          <X className="h-4 w-4" />
        </Button>
      </CardHeader>
      <CardContent>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Título *
            </label>
            <Input
              type="text"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              placeholder="Título del video"
              required
              disabled={uploading}
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Descripción
            </label>
            <Textarea
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              placeholder="Describe el contenido del video..."
              rows={3}
              disabled={uploading}
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Archivo de Video *
            </label>
            <input
              ref={fileInputRef}
              type="file"
              accept="video/*"
              onChange={handleFileSelect}
              className="w-full p-2 border border-gray-300 rounded-md"
              required
              disabled={uploading}
            />
            {selectedFile && (
              <div className="mt-2 flex items-center gap-2 text-sm text-gray-600">
                <Video className="h-4 w-4" />
                <span>{selectedFile.name}</span>
                <span>({(selectedFile.size / 1024 / 1024).toFixed(2)} MB)</span>
              </div>
            )}
          </div>

          <div className="flex gap-2">
            <Button
              type="submit"
              disabled={uploading || !selectedFile || !title.trim()}
              className="flex-1 bg-purple-600 hover:bg-purple-700"
            >
              {uploading ? 'Subiendo...' : 'Subir Video'}
            </Button>
            <Button
              type="button"
              variant="outline"
              onClick={resetForm}
              disabled={uploading}
            >
              Cancelar
            </Button>
          </div>
        </form>
      </CardContent>
    </Card>
  );
};

export default VideoUpload;
