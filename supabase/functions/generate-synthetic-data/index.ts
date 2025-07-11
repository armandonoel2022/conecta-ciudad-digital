import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.50.0';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

// Sectores reales de Santo Domingo
const SANTO_DOMINGO_SECTORS = [
  'Gazcue', 'Piantini', 'Naco', 'Bella Vista', 'Villa Juana', 'Cristo Rey',
  'La Esperilla', 'Mirador Sur', 'Los Cacicazgos', 'Ensanche Julieta',
  'Villa Francisca', 'Gualey', 'San Carlos', 'Villa Consuelo', 'Los Ríos',
  'Ensanche Ozama', 'Villa Agrippina', 'Los Minas', 'Villa Duarte', 'Alma Rosa'
];

// Coordenadas base de Santo Domingo (18.4861° N, 69.9312° W)
const SANTO_DOMINGO_CENTER = {
  latitude: 18.4861,
  longitude: -69.9312
};

// Tipos de problemas comunes en Santo Domingo
const REPORT_CATEGORIES = [
  'basura', 'iluminacion', 'baches', 'seguridad', 'otros'
];

const REPORT_TEMPLATES = {
  basura: [
    'Acumulación de basura en la esquina de [STREET]',
    'Contenedores desbordados en [SECTOR]',
    'Basura dispersa después del día de recolección',
    'Falta de contenedores en la zona',
    'Vertedero improvisado en área verde'
  ],
  iluminacion: [
    'Postes de luz averiados en [STREET]',
    'Falta de iluminación en parque de [SECTOR]',
    'Bombillas fundidas en varias calles',
    'Cableado eléctrico en mal estado',
    'Zona muy oscura por las noches'
  ],
  baches: [
    'Baches profundos en [STREET]',
    'Deterioro del asfalto por lluvias',
    'Calle intransitable por hoyos',
    'Daños en pavimento cerca de [SECTOR]',
    'Urgente reparación de vía principal'
  ],
  seguridad: [
    'Falta de vigilancia en [SECTOR]',
    'Robos frecuentes en la zona',
    'Necesidad de más patrullaje policial',
    'Área insegura durante la noche',
    'Solicitud de cámaras de seguridad'
  ],
  otros: [
    'Problemas con el suministro de agua',
    'Ruido excesivo en las noches',
    'Animales callejeros en [SECTOR]',
    'Daños en aceras y bordillos',
    'Solicitud de mejoras en parque'
  ]
};

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response(null, { headers: corsHeaders });
  }

  try {
    console.log('Iniciando generación de datos sintéticos para Santo Domingo...');

    const supabaseUrl = Deno.env.get('SUPABASE_URL')!;
    const supabaseServiceRoleKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
    
    const supabase = createClient(supabaseUrl, supabaseServiceRoleKey);

    // Generar usuarios sintéticos
    console.log('Generando usuarios sintéticos...');
    const users: any[] = [];
    const profiles: any[] = [];

    for (let i = 0; i < 100; i++) {
      const userId = crypto.randomUUID();
      const firstName = getRandomFirstName();
      const lastName = getRandomLastName();
      const sector = SANTO_DOMINGO_SECTORS[Math.floor(Math.random() * SANTO_DOMINGO_SECTORS.length)];
      
      // Crear usuario en auth.users
      const user = {
        id: userId,
        email: `usuario${i + 1}@ciudadconecta.do`,
        encrypted_password: '$2a$10$dummy.encrypted.password.hash',
        email_confirmed_at: new Date().toISOString(),
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
        raw_user_meta_data: {
          full_name: `${firstName} ${lastName}`,
          first_name: firstName,
          last_name: lastName
        },
        aud: 'authenticated',
        role: 'authenticated'
      };

      // Crear perfil
      const profile = {
        id: userId,
        full_name: `${firstName} ${lastName}`,
        first_name: firstName,
        last_name: lastName,
        phone: `809${Math.floor(Math.random() * 9000000) + 1000000}`,
        address: `Calle ${Math.floor(Math.random() * 50) + 1}, ${sector}`,
        neighborhood: sector,
        city: 'Santo Domingo',
        gender: Math.random() > 0.5 ? 'masculino' : 'femenino',
        birth_date: getRandomBirthDate(),
        document_type: 'cedula',
        document_number: `${Math.floor(Math.random() * 90000000) + 10000000}`,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      };

      users.push(user);
      profiles.push(profile);
    }

    // Insertar usuarios usando SQL directo (porque auth.users no es accesible vía API)
    // Solo insertamos profiles ya que los usuarios auth se manejan por separado
    const { error: profilesError } = await supabase
      .from('profiles')
      .insert(profiles);

    if (profilesError) {
      console.error('Error insertando profiles:', profilesError);
      throw profilesError;
    }

    // Asignar roles a algunos usuarios
    const userRoles = [];
    // 2 administradores
    for (let i = 0; i < 2; i++) {
      userRoles.push({
        user_id: users[i].id,
        role: 'admin',
        assigned_by: users[0].id,
        is_active: true
      });
    }
    // 8 líderes comunitarios
    for (let i = 2; i < 10; i++) {
      userRoles.push({
        user_id: users[i].id,
        role: 'community_leader',
        assigned_by: users[0].id,
        is_active: true
      });
    }
    // El resto son usuarios comunitarios
    for (let i = 10; i < 100; i++) {
      userRoles.push({
        user_id: users[i].id,
        role: 'community_user',
        assigned_by: users[0].id,
        is_active: true
      });
    }

    const { error: rolesError } = await supabase
      .from('user_roles')
      .insert(userRoles);

    if (rolesError) {
      console.error('Error insertando roles:', rolesError);
    }

    // Generar reportes sintéticos
    console.log('Generando reportes sintéticos...');
    const reports: any[] = [];
    const reportCount = 800; // Suficientes para análisis robusto

    for (let i = 0; i < reportCount; i++) {
      const category = REPORT_CATEGORIES[Math.floor(Math.random() * REPORT_CATEGORIES.length)];
      const sector = SANTO_DOMINGO_SECTORS[Math.floor(Math.random() * SANTO_DOMINGO_SECTORS.length)];
      const user = users[Math.floor(Math.random() * users.length)];
      
      // Generar coordenadas realistas dentro de Santo Domingo
      const coordinates = generateSantoDomingoCoordinates();
      
      // Generar fecha realista (últimos 12 meses con patrones estacionales)
      const createdAt = generateRealisticDate(category);
      
      // Generar título y descripción basados en plantillas
      const template = REPORT_TEMPLATES[category as keyof typeof REPORT_TEMPLATES];
      const baseTitle = template[Math.floor(Math.random() * template.length)];
      const title = baseTitle.replace('[SECTOR]', sector).replace('[STREET]', `Calle ${Math.floor(Math.random() * 50) + 1}`);
      
      const report = {
        id: crypto.randomUUID(),
        user_id: user.id,
        category,
        title,
        description: generateReportDescription(category, sector),
        latitude: coordinates.latitude,
        longitude: coordinates.longitude,
        address: `${sector}, Santo Domingo`,
        neighborhood: sector,
        status: getWeightedStatus(),
        priority: getWeightedPriority(),
        created_at: createdAt,
        updated_at: createdAt,
        resolved_at: Math.random() > 0.4 ? new Date(new Date(createdAt).getTime() + Math.random() * 30 * 24 * 60 * 60 * 1000).toISOString() : null
      };

      reports.push(report);
    }

    // Insertar reportes
    const { error: reportsError } = await supabase
      .from('reports')
      .insert(reports);

    if (reportsError) {
      console.error('Error insertando reportes:', reportsError);
      throw reportsError;
    }

    // Generar algunas alertas de pánico sintéticas
    console.log('Generando alertas de pánico...');
    const panicAlerts = [];
    for (let i = 0; i < 25; i++) {
      const user = users[Math.floor(Math.random() * users.length)];
      const coordinates = generateSantoDomingoCoordinates();
      const createdAt = new Date(Date.now() - Math.random() * 90 * 24 * 60 * 60 * 1000).toISOString();
      
      panicAlerts.push({
        id: crypto.randomUUID(),
        user_id: user.id,
        user_full_name: user.raw_user_meta_data.full_name,
        latitude: coordinates.latitude,
        longitude: coordinates.longitude,
        address: `${SANTO_DOMINGO_SECTORS[Math.floor(Math.random() * SANTO_DOMINGO_SECTORS.length)]}, Santo Domingo`,
        created_at: createdAt,
        expires_at: new Date(new Date(createdAt).getTime() + 60 * 60 * 1000).toISOString(), // 1 hora después
        is_active: Math.random() > 0.8 // 20% activas
      });
    }

    const { error: panicError } = await supabase
      .from('panic_alerts')
      .insert(panicAlerts);

    if (panicError) {
      console.error('Error insertando alertas de pánico:', panicError);
    }

    // Generar alertas Amber sintéticas
    console.log('Generando alertas Amber...');
    const amberAlerts = [];
    for (let i = 0; i < 15; i++) {
      const user = users[Math.floor(Math.random() * users.length)];
      const createdAt = new Date(Date.now() - Math.random() * 180 * 24 * 60 * 60 * 1000).toISOString();
      
      amberAlerts.push({
        id: crypto.randomUUID(),
        user_id: user.id,
        child_full_name: `${getRandomFirstName()} ${user.raw_user_meta_data.last_name}`,
        child_nickname: Math.random() > 0.5 ? getRandomNickname() : null,
        last_seen_location: `${SANTO_DOMINGO_SECTORS[Math.floor(Math.random() * SANTO_DOMINGO_SECTORS.length)]}, Santo Domingo`,
        contact_number: `809${Math.floor(Math.random() * 9000000) + 1000000}`,
        disappearance_time: createdAt,
        medical_conditions: Math.random() > 0.7 ? getRandomMedicalCondition() : null,
        additional_details: `Menor desaparecido en zona de ${SANTO_DOMINGO_SECTORS[Math.floor(Math.random() * SANTO_DOMINGO_SECTORS.length)]}`,
        created_at: createdAt,
        is_active: Math.random() > 0.6, // 40% activas
        resolved_at: Math.random() > 0.6 ? new Date(new Date(createdAt).getTime() + Math.random() * 72 * 60 * 60 * 1000).toISOString() : null
      });
    }

    const { error: amberError } = await supabase
      .from('amber_alerts')
      .insert(amberAlerts);

    if (amberError) {
      console.error('Error insertando alertas Amber:', amberError);
    }

    console.log('✅ Datos sintéticos generados exitosamente');

    return new Response(JSON.stringify({
      success: true,
      message: 'Datos sintéticos generados exitosamente para Santo Domingo',
      data: {
        profiles_created: profiles.length,
        user_roles_created: userRoles.length,
        reports_created: reports.length,
        panic_alerts_created: panicAlerts.length,
        amber_alerts_created: amberAlerts.length,
        sectors_covered: SANTO_DOMINGO_SECTORS.length
      }
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });

  } catch (error) {
    console.error('Error generando datos sintéticos:', error);
    return new Response(JSON.stringify({ 
      error: 'Error generando datos sintéticos',
      details: error.message 
    }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});

// Funciones auxiliares
function getRandomFirstName(): string {
  const names = [
    'María', 'José', 'Ana', 'Luis', 'Carmen', 'Francisco', 'Rosa', 'Manuel',
    'Elena', 'Rafael', 'Luz', 'Carlos', 'Esperanza', 'Pedro', 'Lucía',
    'Juan', 'Mercedes', 'Antonio', 'Dolores', 'Ramón', 'Isabel', 'Miguel',
    'Concepción', 'Fernando', 'Teresa', 'Javier', 'Pilar', 'Jesús', 'Ángeles'
  ];
  return names[Math.floor(Math.random() * names.length)];
}

function getRandomLastName(): string {
  const surnames = [
    'García', 'Rodríguez', 'González', 'Fernández', 'López', 'Martínez',
    'Sánchez', 'Pérez', 'Gómez', 'Martín', 'Jiménez', 'Ruiz', 'Hernández',
    'Díaz', 'Moreno', 'Muñoz', 'Álvarez', 'Romero', 'Alonso', 'Gutiérrez',
    'Navarro', 'Torres', 'Domínguez', 'Vázquez', 'Ramos', 'Gil', 'Ramírez',
    'Serrano', 'Blanco', 'Suárez'
  ];
  return surnames[Math.floor(Math.random() * surnames.length)];
}

function getRandomNickname(): string {
  const nicknames = ['Chico', 'Bebe', 'Junior', 'Negrito', 'Flaco', 'Gordo', 'Pelao'];
  return nicknames[Math.floor(Math.random() * nicknames.length)];
}

function getRandomMedicalCondition(): string {
  const conditions = ['Asma', 'Diabetes', 'Epilepsia', 'Autismo', 'TDAH'];
  return conditions[Math.floor(Math.random() * conditions.length)];
}

function getRandomBirthDate(): string {
  const start = new Date('1970-01-01');
  const end = new Date('2005-12-31');
  const randomTime = start.getTime() + Math.random() * (end.getTime() - start.getTime());
  return new Date(randomTime).toISOString().split('T')[0];
}

function generateSantoDomingoCoordinates() {
  // Generar coordenadas dentro del área metropolitana de Santo Domingo
  const latVariation = (Math.random() - 0.5) * 0.15; // ~8km radius
  const lngVariation = (Math.random() - 0.5) * 0.15;
  
  return {
    latitude: SANTO_DOMINGO_CENTER.latitude + latVariation,
    longitude: SANTO_DOMINGO_CENTER.longitude + lngVariation
  };
}

function generateRealisticDate(category: string): string {
  const now = new Date();
  const yearAgo = new Date(now.getTime() - 365 * 24 * 60 * 60 * 1000);
  
  // Patrones estacionales para diferentes categorías
  let seasonalWeight = 1;
  const month = now.getMonth();
  
  if (category === 'baches') {
    // Más baches durante y después de la temporada lluviosa (mayo-octubre)
    seasonalWeight = (month >= 4 && month <= 9) ? 1.5 : 0.7;
  } else if (category === 'iluminacion') {
    // Más problemas de iluminación en época lluviosa
    seasonalWeight = (month >= 4 && month <= 9) ? 1.3 : 0.8;
  } else if (category === 'basura') {
    // Más problemas de basura los fines de semana y después de feriados
    seasonalWeight = 1 + (Math.random() * 0.3);
  }
  
  const randomTime = yearAgo.getTime() + Math.random() * (now.getTime() - yearAgo.getTime()) * seasonalWeight;
  return new Date(randomTime).toISOString();
}

function generateReportDescription(category: string, sector: string): string {
  const descriptions = {
    basura: `Se reporta acumulación de basura en el sector ${sector}. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.`,
    iluminacion: `Falta de iluminación pública en ${sector} crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.`,
    baches: `Deterioro significativo del pavimento en ${sector} debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.`,
    seguridad: `Situación de inseguridad reportada en ${sector}. Se requiere mayor presencia policial y medidas de seguridad preventivas.`,
    otros: `Problema general reportado en ${sector} que requiere atención de las autoridades municipales correspondientes.`
  };
  
  return descriptions[category as keyof typeof descriptions] || descriptions.otros;
}

function getWeightedStatus(): string {
  const random = Math.random();
  if (random < 0.4) return 'resuelto';
  if (random < 0.7) return 'en_proceso';
  if (random < 0.95) return 'pendiente';
  return 'rechazado';
}

function getWeightedPriority(): string {
  const random = Math.random();
  if (random < 0.6) return 'media';
  if (random < 0.85) return 'alta';
  return 'baja';
}