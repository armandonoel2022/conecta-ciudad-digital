import React from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { ArrowLeft, Shield, FileText, Users, Lock } from 'lucide-react';
import { Link } from 'react-router-dom';

const TerminosCondiciones = () => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4">
      <div className="max-w-4xl mx-auto space-y-6">
        {/* Header */}
        <div className="bg-white/10 backdrop-blur-sm p-6 rounded-2xl shadow-xl text-white">
          <div className="flex items-center gap-3 mb-4">
            <Link to="/auth" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
              <ArrowLeft className="h-6 w-6" />
            </Link>
            <FileText className="h-8 w-8" />
            <h1 className="text-3xl font-bold">Términos y Condiciones</h1>
          </div>
          <p className="text-white/90">
            CiudadConecta - Plataforma de Participación Ciudadana
          </p>
        </div>

        {/* Términos y Condiciones */}
        <Card className="bg-white/95 backdrop-blur-sm">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Shield className="h-5 w-5" />
              Términos y Condiciones de Uso
            </CardTitle>
            <CardDescription>
              Última actualización: Julio 2025
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-6">
            <section>
              <h3 className="text-lg font-semibold mb-3">1. Aceptación de los Términos</h3>
              <p className="text-gray-700 leading-relaxed">
                Al acceder y utilizar CiudadConecta, usted acepta cumplir con estos términos y condiciones. 
                Si no está de acuerdo con alguno de estos términos, no debe utilizar nuestros servicios.
              </p>
            </section>

            <section>
              <h3 className="text-lg font-semibold mb-3">2. Descripción del Servicio</h3>
              <p className="text-gray-700 leading-relaxed">
                CiudadConecta es una plataforma digital que facilita la participación ciudadana permitiendo 
                a los usuarios reportar incidencias urbanas, acceder a servicios municipales, y participar 
                en la mejora de su comunidad.
              </p>
            </section>

            <section>
              <h3 className="text-lg font-semibold mb-3">3. Registro y Cuenta de Usuario</h3>
              <ul className="list-disc list-inside text-gray-700 space-y-2">
                <li>Debe proporcionar información veraz y actualizada durante el registro</li>
                <li>Es responsable de mantener la confidencialidad de su contraseña</li>
                <li>Notificar inmediatamente cualquier uso no autorizado de su cuenta</li>
                <li>Una persona solo puede tener una cuenta activa</li>
              </ul>
            </section>

            <section>
              <h3 className="text-lg font-semibold mb-3">4. Uso Apropiado de la Plataforma</h3>
              <p className="text-gray-700 leading-relaxed mb-2">Está prohibido:</p>
              <ul className="list-disc list-inside text-gray-700 space-y-2">
                <li>Enviar reportes falsos o información errónea deliberadamente</li>
                <li>Usar lenguaje ofensivo, discriminatorio o inapropiado</li>
                <li>Intentar acceder a cuentas de otros usuarios</li>
                <li>Usar la plataforma para actividades ilegales</li>
                <li>Subir contenido que viole derechos de terceros</li>
              </ul>
            </section>

            <section>
              <h3 className="text-lg font-semibold mb-3">5. Privacidad y Protección de Datos</h3>
              <p className="text-gray-700 leading-relaxed">
                Su privacidad es importante para nosotros. Los datos personales se procesan conforme a 
                nuestra Política de Privacidad y la legislación vigente en materia de protección de datos.
              </p>
            </section>

            <section>
              <h3 className="text-lg font-semibold mb-3">6. Reportes y Contenido</h3>
              <ul className="list-disc list-inside text-gray-700 space-y-2">
                <li>Los reportes deben ser veraces y corresponder a situaciones reales</li>
                <li>Las imágenes subidas deben ser propias o tener autorización para su uso</li>
                <li>Nos reservamos el derecho de verificar y moderar el contenido</li>
                <li>El contenido ofensivo o inapropiado será removido</li>
              </ul>
            </section>

            <section>
              <h3 className="text-lg font-semibold mb-3">7. Servicios de Pago</h3>
              <p className="text-gray-700 leading-relaxed">
                Los pagos de servicios municipales se procesan de forma segura. Los usuarios son 
                responsables de la exactitud de la información de pago proporcionada.
              </p>
            </section>

            <section>
              <h3 className="text-lg font-semibold mb-3">8. Limitación de Responsabilidad</h3>
              <p className="text-gray-700 leading-relaxed">
                CiudadConecta actúa como intermediario entre ciudadanos y autoridades municipales. 
                No garantizamos la resolución inmediata de reportes ni somos responsables por 
                las acciones de terceros.
              </p>
            </section>

            <section>
              <h3 className="text-lg font-semibold mb-3">9. Modificaciones</h3>
              <p className="text-gray-700 leading-relaxed">
                Nos reservamos el derecho de modificar estos términos en cualquier momento. 
                Los cambios serán notificados a través de la plataforma y entrarán en vigor 
                una vez publicados.
              </p>
            </section>

            <section>
              <h3 className="text-lg font-semibold mb-3">10. Contacto</h3>
              <p className="text-gray-700 leading-relaxed">
                Para consultas sobre estos términos, puede contactarnos a través de la 
                sección de Ayuda y Soporte dentro de la aplicación.
              </p>
            </section>
          </CardContent>
        </Card>

        {/* Política de Privacidad */}
        <Card className="bg-white/95 backdrop-blur-sm">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Lock className="h-5 w-5" />
              Política de Privacidad
            </CardTitle>
            <CardDescription>
              Información sobre el tratamiento de sus datos personales
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-6">
            <section>
              <h3 className="text-lg font-semibold mb-3">Recopilación de Información</h3>
              <p className="text-gray-700 leading-relaxed">
                Recopilamos información que usted nos proporciona directamente, como nombre, 
                email, teléfono, y ubicación cuando crea reportes. También recopilamos 
                información técnica como dirección IP y datos de uso de la aplicación.
              </p>
            </section>

            <section>
              <h3 className="text-lg font-semibold mb-3">Uso de la Información</h3>
              <ul className="list-disc list-inside text-gray-700 space-y-2">
                <li>Procesar y gestionar sus reportes de incidencias</li>
                <li>Facilitar el pago de servicios municipales</li>
                <li>Mejorar nuestros servicios y la experiencia del usuario</li>
                <li>Comunicar actualizaciones sobre sus reportes</li>
                <li>Cumplir con obligaciones legales</li>
              </ul>
            </section>

            <section>
              <h3 className="text-lg font-semibold mb-3">Compartir Información</h3>
              <p className="text-gray-700 leading-relaxed">
                Su información puede ser compartida con las autoridades municipales competentes 
                para la resolución de reportes. No vendemos ni alquilamos su información personal 
                a terceros con fines comerciales.
              </p>
            </section>

            <section>
              <h3 className="text-lg font-semibold mb-3">Seguridad</h3>
              <p className="text-gray-700 leading-relaxed">
                Implementamos medidas de seguridad técnicas y organizativas para proteger 
                su información personal contra acceso no autorizado, alteración, divulgación 
                o destrucción.
              </p>
            </section>

            <section>
              <h3 className="text-lg font-semibold mb-3">Sus Derechos</h3>
              <ul className="list-disc list-inside text-gray-700 space-y-2">
                <li>Acceder a sus datos personales</li>
                <li>Rectificar información incorrecta</li>
                <li>Solicitar la eliminación de sus datos</li>
                <li>Limitar el procesamiento de sus datos</li>
                <li>Retirar el consentimiento en cualquier momento</li>
              </ul>
            </section>

            <section>
              <h3 className="text-lg font-semibold mb-3">Retención de Datos</h3>
              <p className="text-gray-700 leading-relaxed">
                Conservamos su información personal solo durante el tiempo necesario para 
                cumplir con los propósitos descritos en esta política, a menos que la ley 
                requiera un período de retención más largo.
              </p>
            </section>

            <section>
              <h3 className="text-lg font-semibold mb-3">Cookies y Tecnologías Similares</h3>
              <p className="text-gray-700 leading-relaxed">
                Utilizamos cookies y tecnologías similares para mejorar la funcionalidad 
                de la plataforma, recordar sus preferencias y analizar el uso del servicio.
              </p>
            </section>
          </CardContent>
        </Card>

        {/* Footer con botón de regreso */}
        <div className="text-center">
          <Link
            to="/auth"
            className="inline-flex items-center gap-2 bg-white/10 hover:bg-white/20 text-white px-6 py-3 rounded-xl transition-colors"
          >
            <ArrowLeft className="h-4 w-4" />
            Regresar al registro
          </Link>
        </div>
      </div>
    </div>
  );
};

export default TerminosCondiciones;