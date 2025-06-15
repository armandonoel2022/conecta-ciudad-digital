
import { useState } from 'react';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from '@/components/ui/form';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Upload, FileText, Loader2 } from 'lucide-react';
import { useJobApplications } from '@/hooks/useJobApplications';
import { toast } from 'sonner';

const formSchema = z.object({
  full_name: z.string().min(2, 'El nombre completo es requerido'),
  email: z.string().email('Email inválido'),
  phone: z.string().min(10, 'Teléfono debe tener al menos 10 dígitos'),
  address: z.string().optional(),
  birth_date: z.string().optional(),
  document_type: z.string().optional(),
  document_number: z.string().optional(),
  education_level: z.string().min(1, 'Nivel educativo es requerido'),
  institution_name: z.string().optional(),
  career_field: z.string().optional(),
  graduation_year: z.number().optional(),
  additional_courses: z.string().optional(),
  work_experience: z.string().optional(),
  skills: z.string().optional(),
  availability: z.string().optional(),
  expected_salary: z.string().optional(),
});

type FormData = z.infer<typeof formSchema>;

interface JobApplicationFormProps {
  onSuccess?: () => void;
}

const JobApplicationForm = ({ onSuccess }: JobApplicationFormProps) => {
  const { createApplication, uploadCV, isUploading } = useJobApplications();
  const [cvFile, setCvFile] = useState<File | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const form = useForm<FormData>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      full_name: '',
      email: '',
      phone: '',
      education_level: '',
    },
  });

  const onSubmit = async (data: FormData) => {
    setIsSubmitting(true);
    
    try {
      let cvData: { url: string; name: string } | undefined;
      
      if (cvFile) {
        cvData = await uploadCV(cvFile);
      }
      
      const applicationData = {
        full_name: data.full_name,
        email: data.email,
        phone: data.phone,
        address: data.address,
        birth_date: data.birth_date,
        document_type: data.document_type,
        document_number: data.document_number,
        education_level: data.education_level,
        institution_name: data.institution_name,
        career_field: data.career_field,
        graduation_year: data.graduation_year,
        additional_courses: data.additional_courses,
        work_experience: data.work_experience,
        skills: data.skills,
        availability: data.availability,
        expected_salary: data.expected_salary,
        cv_file_url: cvData?.url,
        cv_file_name: cvData?.name,
        status: 'pending' as const,
      };
      
      await createApplication.mutateAsync(applicationData);
      
      form.reset();
      setCvFile(null);
      toast.success('¡Aplicación enviada exitosamente!');
      onSuccess?.();
    } catch (error) {
      console.error('Error submitting application:', error);
      toast.error('Error al enviar la aplicación. Por favor intenta nuevamente.');
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleFileChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file && file.type === 'application/pdf') {
      setCvFile(file);
    } else {
      toast.error('Por favor selecciona un archivo PDF válido');
    }
  };

  return (
    <Card className="w-full max-w-4xl mx-auto">
      <CardHeader>
        <CardTitle className="text-2xl font-bold text-gray-800">Aplicación de Empleo</CardTitle>
        <CardDescription>
          Completa el formulario para aplicar a oportunidades de empleo
        </CardDescription>
      </CardHeader>
      <CardContent>
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
            {/* Personal Information */}
            <div className="space-y-4">
              <h3 className="text-lg font-semibold text-gray-700">Información Personal</h3>
              <div className="grid md:grid-cols-2 gap-4">
                <FormField
                  control={form.control}
                  name="full_name"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Nombre Completo *</FormLabel>
                      <FormControl>
                        <Input placeholder="Tu nombre completo" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                
                <FormField
                  control={form.control}
                  name="email"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Email *</FormLabel>
                      <FormControl>
                        <Input type="email" placeholder="tu@email.com" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                
                <FormField
                  control={form.control}
                  name="phone"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Teléfono *</FormLabel>
                      <FormControl>
                        <Input placeholder="(809) 123-4567" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                
                <FormField
                  control={form.control}
                  name="birth_date"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Fecha de Nacimiento</FormLabel>
                      <FormControl>
                        <Input type="date" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                
                <FormField
                  control={form.control}
                  name="document_type"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Tipo de Documento</FormLabel>
                      <Select onValueChange={field.onChange} defaultValue={field.value}>
                        <FormControl>
                          <SelectTrigger>
                            <SelectValue placeholder="Selecciona tipo" />
                          </SelectTrigger>
                        </FormControl>
                        <SelectContent>
                          <SelectItem value="cedula">Cédula</SelectItem>
                          <SelectItem value="pasaporte">Pasaporte</SelectItem>
                        </SelectContent>
                      </Select>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                
                <FormField
                  control={form.control}
                  name="document_number"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Número de Documento</FormLabel>
                      <FormControl>
                        <Input placeholder="123-4567890-1" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>
              
              <FormField
                control={form.control}
                name="address"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Dirección</FormLabel>
                    <FormControl>
                      <Textarea placeholder="Tu dirección completa" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
            </div>

            {/* Academic Information */}
            <div className="space-y-4">
              <h3 className="text-lg font-semibold text-gray-700">Información Académica</h3>
              <div className="grid md:grid-cols-2 gap-4">
                <FormField
                  control={form.control}
                  name="education_level"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Nivel Educativo *</FormLabel>
                      <Select onValueChange={field.onChange} defaultValue={field.value}>
                        <FormControl>
                          <SelectTrigger>
                            <SelectValue placeholder="Selecciona nivel" />
                          </SelectTrigger>
                        </FormControl>
                        <SelectContent>
                          <SelectItem value="primaria">Primaria</SelectItem>
                          <SelectItem value="secundaria">Secundaria</SelectItem>
                          <SelectItem value="tecnico">Técnico</SelectItem>
                          <SelectItem value="universitario">Universitario</SelectItem>
                          <SelectItem value="postgrado">Postgrado</SelectItem>
                        </SelectContent>
                      </Select>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                
                <FormField
                  control={form.control}
                  name="institution_name"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Institución Educativa</FormLabel>
                      <FormControl>
                        <Input placeholder="Nombre de la institución" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                
                <FormField
                  control={form.control}
                  name="career_field"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Área de Estudio</FormLabel>
                      <FormControl>
                        <Input placeholder="Ej: Ingeniería, Administración" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                
                <FormField
                  control={form.control}
                  name="graduation_year"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Año de Graduación</FormLabel>
                      <FormControl>
                        <Input 
                          type="number" 
                          placeholder="2023" 
                          {...field}
                          onChange={(e) => field.onChange(e.target.value ? parseInt(e.target.value) : undefined)}
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>
              
              <FormField
                control={form.control}
                name="additional_courses"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Cursos Adicionales</FormLabel>
                    <FormControl>
                      <Textarea placeholder="Cursos, certificaciones o entrenamientos adicionales" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
            </div>

            {/* Professional Information */}
            <div className="space-y-4">
              <h3 className="text-lg font-semibold text-gray-700">Información Profesional</h3>
              
              <FormField
                control={form.control}
                name="work_experience"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Experiencia Laboral</FormLabel>
                    <FormControl>
                      <Textarea placeholder="Describe tu experiencia laboral anterior" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              
              <FormField
                control={form.control}
                name="skills"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Habilidades</FormLabel>
                    <FormControl>
                      <Textarea placeholder="Lista tus habilidades relevantes" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              
              <div className="grid md:grid-cols-2 gap-4">
                <FormField
                  control={form.control}
                  name="availability"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Disponibilidad</FormLabel>
                      <Select onValueChange={field.onChange} defaultValue={field.value}>
                        <FormControl>
                          <SelectTrigger>
                            <SelectValue placeholder="Selecciona disponibilidad" />
                          </SelectTrigger>
                        </FormControl>
                        <SelectContent>
                          <SelectItem value="inmediata">Inmediata</SelectItem>
                          <SelectItem value="1_semana">1 semana</SelectItem>
                          <SelectItem value="2_semanas">2 semanas</SelectItem>
                          <SelectItem value="1_mes">1 mes</SelectItem>
                        </SelectContent>
                      </Select>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                
                <FormField
                  control={form.control}
                  name="expected_salary"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Salario Esperado</FormLabel>
                      <FormControl>
                        <Input placeholder="Ej: RD$30,000" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>
            </div>

            {/* CV Upload */}
            <div className="space-y-4">
              <h3 className="text-lg font-semibold text-gray-700">Curriculum Vitae</h3>
              <div className="border-2 border-dashed border-gray-300 rounded-lg p-6">
                <div className="text-center">
                  <Upload className="mx-auto h-12 w-12 text-gray-400 mb-4" />
                  <label htmlFor="cv-upload" className="cursor-pointer">
                    <span className="text-sm font-medium text-purple-600 hover:text-purple-500">
                      Subir CV (PDF)
                    </span>
                    <input
                      id="cv-upload"
                      type="file"
                      accept=".pdf"
                      onChange={handleFileChange}
                      className="hidden"
                    />
                  </label>
                  <p className="text-xs text-gray-500 mt-1">Solo archivos PDF</p>
                  
                  {cvFile && (
                    <div className="flex items-center justify-center mt-3 text-sm text-green-600">
                      <FileText className="h-4 w-4 mr-2" />
                      {cvFile.name}
                    </div>
                  )}
                </div>
              </div>
            </div>

            <Button 
              type="submit" 
              className="w-full bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-700 hover:to-blue-700"
              disabled={isSubmitting || isUploading}
            >
              {isSubmitting || isUploading ? (
                <>
                  <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                  {isUploading ? 'Subiendo CV...' : 'Enviando Aplicación...'}
                </>
              ) : (
                'Enviar Aplicación'
              )}
            </Button>
          </form>
        </Form>
      </CardContent>
    </Card>
  );
};

export default JobApplicationForm;
