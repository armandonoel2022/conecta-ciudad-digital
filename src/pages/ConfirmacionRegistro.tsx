import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { CheckCircle, ArrowRight } from "lucide-react";
import { Link } from "react-router-dom";

const ConfirmacionRegistro = () => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 flex items-center justify-center">
      <div className="w-full max-w-md">
        {/* Confirmation Card */}
        <Card className="backdrop-blur-sm bg-white/95 shadow-xl text-center">
          <CardHeader>
            <div className="mx-auto mb-4">
              <CheckCircle className="h-20 w-20 text-green-500" />
            </div>
            <CardTitle className="text-3xl font-bold text-gray-800 mb-2">
              ¡Cuenta Confirmada!
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-6">
            <div className="space-y-4">
              <p className="text-xl font-semibold text-green-600">
                Tu cuenta ha sido verificada exitosamente
              </p>
              <p className="text-gray-600 leading-relaxed">
                ¡Bienvenido a CiudadConecta! Tu cuenta está lista para usar. 
                Ahora puedes acceder a todas las funcionalidades de nuestra plataforma 
                para conectar con tu comunidad y mejorar tu ciudad.
              </p>
            </div>

            <div className="bg-blue-50 p-4 rounded-lg border border-blue-200">
              <p className="text-blue-800 font-medium mb-2">
                Recordatorio sobre tu privacidad:
              </p>
              <p className="text-blue-700 text-sm">
                Tu información está protegida según nuestra Política de Privacidad. 
                Solo utilizamos tus datos para mejorar los servicios municipales y 
                garantizar tu seguridad en la comunidad.
              </p>
            </div>

            <div className="space-y-4">
              <Button 
                asChild 
                className="w-full bg-gradient-to-r from-primary to-blue-600 hover:from-primary/90 hover:to-blue-700 rounded-xl py-6 font-bold text-lg"
              >
                <Link to="/auth" className="flex items-center justify-center gap-2">
                  Iniciar Sesión Ahora
                  <ArrowRight className="h-5 w-5" />
                </Link>
              </Button>

              <Button 
                asChild 
                variant="outline"
                className="w-full rounded-xl py-4"
              >
                <Link to="/politica-privacidad">
                  Revisar Política de Privacidad
                </Link>
              </Button>
            </div>

            <div className="text-center">
              <p className="text-sm text-gray-500">
                ¿Tienes problemas para iniciar sesión?{" "}
                <Link to="/ayuda" className="text-primary hover:underline">
                  Contacta soporte
                </Link>
              </p>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default ConfirmacionRegistro;