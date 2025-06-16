
import { useState } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Briefcase, ArrowLeft, Plus, FileText } from "lucide-react";
import { Link } from "react-router-dom";
import JobApplicationForm from "@/components/JobApplicationForm";
import { useJobApplications } from "@/hooks/useJobApplications";

const Opportunities = () => {
  const [showForm, setShowForm] = useState(false);
  const { applications, isLoading } = useJobApplications();

  const handleFormSuccess = () => {
    setShowForm(false);
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-600 via-blue-600 to-indigo-700 p-4 animate-fade-in">
      <div className="max-w-6xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-4">
          <Link to="/" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold">OPORTUNIDADES</h1>
            <p className="text-white/80">Encuentra y aplica a oportunidades de empleo</p>
          </div>
        </div>

        {/* Content Card */}
        <div className="bg-white rounded-[2rem] p-8 shadow-xl">
          {!showForm ? (
            <div className="space-y-8">
              {/* Welcome Section */}
              <div className="text-center">
                <div className="mx-auto bg-purple-100 p-4 rounded-full w-fit mb-4">
                  <Briefcase className="h-12 w-12 text-purple-600" />
                </div>
                <h2 className="text-3xl font-bold text-gray-800 mb-4">Oportunidades de Empleo</h2>
                <p className="text-lg text-gray-600 leading-relaxed max-w-3xl mx-auto mb-6">
                  Aplica a oportunidades de empleo en tu comunidad. Completa tu aplicación 
                  y conecta con Recursos Humanos locales que buscan talento como el tuyo.
                </p>
                
                <Button 
                  onClick={() => setShowForm(true)}
                  className="bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-700 hover:to-blue-700 text-white px-8 py-3 text-lg"
                >
                  <Plus className="mr-2 h-5 w-5" />
                  Nueva Aplicación
                </Button>
              </div>

              {/* Previous Applications */}
              {applications && applications.length > 0 && (
                <div className="space-y-4">
                  <h3 className="text-xl font-semibold text-gray-800">Mis Aplicaciones</h3>
                  <div className="grid gap-4">
                    {applications.map((application) => (
                      <Card key={application.id} className="border-l-4 border-l-purple-500">
                        <CardHeader className="pb-3">
                          <div className="flex items-center justify-between">
                            <CardTitle className="text-lg">{application.full_name}</CardTitle>
                            <span className={`px-3 py-1 rounded-full text-sm font-medium ${
                              application.status === 'pending' 
                                ? 'bg-yellow-100 text-yellow-800' 
                                : application.status === 'approved'
                                ? 'bg-green-100 text-green-800'
                                : 'bg-red-100 text-red-800'
                            }`}>
                              {application.status === 'pending' ? 'Pendiente' : 
                               application.status === 'approved' ? 'Aprobada' : 'Rechazada'}
                            </span>
                          </div>
                          <CardDescription>
                            {application.career_field} • {application.education_level}
                            {application.cv_file_name && (
                              <span className="flex items-center mt-1 text-purple-600">
                                <FileText className="h-4 w-4 mr-1" />
                                CV adjunto
                              </span>
                            )}
                          </CardDescription>
                        </CardHeader>
                        <CardContent>
                          <p className="text-sm text-gray-600">
                            Aplicación enviada el {new Date(application.created_at!).toLocaleDateString('es-DO')}
                          </p>
                          {application.notes && (
                            <p className="text-sm text-gray-700 mt-2 bg-gray-50 p-2 rounded">
                              <strong>Notas:</strong> {application.notes}
                            </p>
                          )}
                        </CardContent>
                      </Card>
                    ))}
                  </div>
                </div>
              )}

              {/* Information Section */}
              <div className="bg-gradient-to-r from-blue-50 to-purple-50 rounded-2xl p-6">
                <h3 className="text-xl font-semibold text-gray-800 mb-4">¿Cómo funciona?</h3>
                <div className="grid md:grid-cols-3 gap-4">
                  <div className="text-center">
                    <div className="bg-blue-100 p-3 rounded-full w-fit mx-auto mb-3">
                      <FileText className="h-6 w-6 text-blue-600" />
                    </div>
                    <h4 className="font-semibold text-gray-800">1. Completa tu perfil</h4>
                    <p className="text-sm text-gray-600">
                      Llena el formulario con tu información personal y profesional
                    </p>
                  </div>
                  
                  <div className="text-center">
                    <div className="bg-purple-100 p-3 rounded-full w-fit mx-auto mb-3">
                      <Briefcase className="h-6 w-6 text-purple-600" />
                    </div>
                    <h4 className="font-semibold text-gray-800">2. Sube tu CV</h4>
                    <p className="text-sm text-gray-600">
                      Adjunta tu curriculum vitae en formato PDF
                    </p>
                  </div>
                  
                  <div className="text-center">
                    <div className="bg-green-100 p-3 rounded-full w-fit mx-auto mb-3">
                      <Plus className="h-6 w-6 text-green-600" />
                    </div>
                    <h4 className="font-semibold text-gray-800">3. Espera respuesta</h4>
                    <p className="text-sm text-gray-600">
                      RR.HH revisará tu aplicación y te contactará
                    </p>
                  </div>
                </div>
              </div>
            </div>
          ) : (
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <h2 className="text-2xl font-bold text-gray-800">Nueva Aplicación de Empleo</h2>
                <Button 
                  variant="outline" 
                  onClick={() => setShowForm(false)}
                >
                  Cancelar
                </Button>
              </div>
              <JobApplicationForm onSuccess={handleFormSuccess} />
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default Opportunities;
