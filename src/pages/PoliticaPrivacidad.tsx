import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { ArrowLeft } from "lucide-react";
import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";

const PoliticaPrivacidad = () => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4">
      <div className="max-w-4xl mx-auto">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-6">
          <Link to="/auth" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold">CiudadConecta</h1>
            <p className="text-white/80">Política de Privacidad</p>
          </div>
        </div>

        <Card className="backdrop-blur-sm bg-white/95 shadow-xl">
          <CardHeader className="text-center">
            <CardTitle className="text-3xl font-bold text-gray-800">
              Política de Privacidad y Uso de Datos Personales
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-8 text-gray-700 leading-relaxed">
            
            {/* Objetivo */}
            <section>
              <h2 className="text-2xl font-semibold text-primary mb-4">Objetivo</h2>
              <p className="text-lg">
                En CiudadConecta, nos comprometemos a proteger la privacidad y los datos personales de nuestros usuarios. 
                Esta política establece cómo recopilamos, utilizamos, almacenamos y protegemos su información personal 
                cuando utiliza nuestra plataforma digital para conectar ciudadanos y mejorar la gestión municipal.
              </p>
            </section>

            {/* Finalidad */}
            <section>
              <h2 className="text-2xl font-semibold text-primary mb-4">Finalidad</h2>
              <p className="text-lg">
                Los datos personales que recopilamos tienen como finalidad principal facilitar la comunicación entre 
                ciudadanos y autoridades municipales, permitir el reporte de incidencias urbanas, gestionar alertas 
                de seguridad, y mejorar continuamente los servicios públicos de su comunidad.
              </p>
            </section>

            {/* Uso de información personal */}
            <section>
              <h2 className="text-2xl font-semibold text-primary mb-4">Cómo Usamos tu Información Personal en Línea</h2>
              <p className="text-lg mb-4">
                Su información personal se utiliza exclusivamente para los fines descritos en esta política. 
                <strong className="text-red-600"> Garantizamos que su información NO será vendida para fines publicitarios.</strong>
              </p>
              <p className="text-lg">
                Sin embargo, debido a la naturaleza de seguridad pública de CiudadConecta, su información puede ser 
                compartida con autoridades competentes cuando sea requerida para fines policiales, de investigación 
                criminal, o en situaciones de emergencia que requieran intervención de seguridad pública.
              </p>
            </section>

            {/* Seguridad */}
            <section>
              <h2 className="text-2xl font-semibold text-primary mb-4">Seguridad</h2>
              <p className="text-lg mb-4">
                Implementamos medidas de seguridad técnicas y organizativas para proteger su información personal 
                contra acceso no autorizado, alteración, divulgación o destrucción.
              </p>
              <p className="text-lg">
                Cuando comparte su ubicación, esta información se utiliza específicamente para fines de seguridad 
                (como en el botón de pánico o alertas Amber) o para mejorar nuestros servicios (como en los reportes 
                de incidencias urbanas). Su ubicación se procesa de manera segura y se mantiene confidencial.
              </p>
            </section>

            {/* Responsabilidades del usuario */}
            <section>
              <h2 className="text-2xl font-semibold text-primary mb-4">Responsabilidades del Usuario</h2>
              <p className="text-lg">
                Como usuario de CiudadConecta, usted es responsable de mantener la confidencialidad de sus credenciales 
                de acceso, proporcionar información veraz y actualizada, y utilizar la plataforma de manera responsable 
                y conforme a las leyes aplicables. Debe notificarnos inmediatamente si sospecha de cualquier uso no 
                autorizado de su cuenta.
              </p>
            </section>

            {/* Seguridad de la información */}
            <section>
              <h2 className="text-2xl font-semibold text-primary mb-4">Seguridad de la Información</h2>
              <p className="text-lg">
                Utilizamos protocolos de encriptación estándar de la industria para proteger la transmisión de datos. 
                Nuestros servidores están protegidos por firewalls y sistemas de monitoreo continuo. Solo el personal 
                autorizado tiene acceso a su información personal, y todo acceso es registrado y auditado regularmente.
              </p>
            </section>

            {/* Información sobre ubicación */}
            <section>
              <h2 className="text-2xl font-semibold text-primary mb-4">Información sobre su Ubicación</h2>
              <p className="text-lg">
                La recopilación de datos de ubicación es opcional y solo se activa cuando usted lo autoriza expresamente. 
                Esta información se utiliza para geolocalizar reportes de incidencias, proporcionar servicios de emergencia 
                más eficientes, y generar estadísticas agregadas para mejorar los servicios municipales. Puede desactivar 
                el acceso a su ubicación en cualquier momento desde la configuración de su dispositivo.
              </p>
            </section>

            {/* Tratamiento y transferencia de datos */}
            <section>
              <h2 className="text-2xl font-semibold text-primary mb-4">Tratamiento y Transferencia de Datos</h2>
              <p className="text-lg">
                Sus datos personales son tratados conforme a las leyes de protección de datos aplicables. La transferencia 
                de datos se realiza únicamente a terceros autorizados que cumplen con nuestros estándares de seguridad y 
                privacidad, incluyendo autoridades gubernamentales cuando sea legalmente requerido, proveedores de servicios 
                técnicos bajo acuerdos de confidencialidad, y organismos de investigación para estudios estadísticos 
                agregados y anónimos.
              </p>
            </section>

            {/* Términos y Condiciones */}
            <section className="border-t pt-8">
              <h2 className="text-2xl font-semibold text-primary mb-4">Términos y Condiciones</h2>
              <p className="text-lg">
                Al utilizar CiudadConecta, usted acepta cumplir con estos términos y condiciones. El uso indebido de la 
                plataforma, incluyendo el envío de información falsa, el acoso a otros usuarios, o cualquier actividad 
                que comprometa la seguridad del sistema, resultará en la suspensión o cancelación de su cuenta. Nos 
                reservamos el derecho de modificar estos términos en cualquier momento, notificándole con anticipación 
                sobre cualquier cambio significativo.
              </p>
            </section>

            <div className="text-center pt-8 border-t">
              <p className="text-sm text-gray-500 mb-4">
                Última actualización: {new Date().toLocaleDateString('es-ES')}
              </p>
              <Button asChild>
                <Link to="/auth">
                  Volver al Registro
                </Link>
              </Button>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default PoliticaPrivacidad;