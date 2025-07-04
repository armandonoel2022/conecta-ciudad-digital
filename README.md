# 🏙️ CiudadConecta - Plataforma Digital de Participación Ciudadana

CiudadConecta es una plataforma web integral que facilita la participación ciudadana, mejora la comunicación entre ciudadanos y autoridades, y crea una ciudad más conectada y transparente.

## 📱 Funcionalidades Principales

### 🔐 Sistema de Autenticación y Perfiles
- **Registro e inicio de sesión** con Supabase Auth
- **Perfiles de usuario** con información personal completa
- **Sistema de roles** (Administrador, Líder Comunitario, Usuario)
- **Autenticación biométrica** y servicios de ubicación configurables

### 📢 Gestión de Reportes Ciudadanos
- **Reporte de incidencias** por categorías (basura, iluminación, baches, seguridad, otros)
- **Subida de imágenes** y geolocalización automática
- **Estados de seguimiento** (pendiente, en proceso, resuelto, rechazado)
- **Visualización de reportes propios** con historial completo

### 🚨 Sistema de Alertas de Emergencia
- **Botón de Pánico**: Alertas de emergencia con ubicación GPS automática
- **Alertas Amber**: Sistema para reportar menores desaparecidos
- **Notificaciones globales** en tiempo real
- **Expiración automática** de alertas

### 💰 Gestión de Pagos de Servicios
- **Facturas automáticas** de recolección de basura
- **Integración con Stripe** para pagos seguros
- **Historial de pagos** y estados de facturación
- **Generación automática** de números de factura

### 📊 Dashboard Analítico (Administradores)
- **Métricas Principales**: Total de reportes, alertas pánico/amber, usuarios activos
- **Análisis Temporal**: Tendencias mensuales con gráficos interactivos
- **Distribución Geográfica**: Mapa de calor de incidencias
- **Demografía**: Análisis por edad, género y ubicación
- **KPIs**: Tiempo promedio de resolución, tasa de resolución, barrios más activos

### 🎥 Antes y Después
- **Subida de videos** comparativos de mejoras urbanas
- **Almacenamiento** en Supabase Storage
- **Galería pública** de transformaciones comunitarias

### 🔧 Funcionalidades Administrativas
- **Gestión de Usuarios**: Asignación de roles y permisos
- **Reportes Programados**: Generación automática de análisis
- **Sistema de Ayuda**: Mensajes de soporte con prioridades
- **Postulaciones Laborales**: Formulario completo con carga de CV

### 🌍 Características Técnicas
- **Diseño responsive** con Tailwind CSS
- **Componentes reutilizables** con Shadcn/UI
- **Base de datos PostgreSQL** con Supabase
- **Almacenamiento de archivos** en la nube
- **Políticas de seguridad** RLS (Row Level Security)
- **Autenticación segura** y gestión de sesiones

## Project info

**URL**: https://lovable.dev/projects/3aae6aac-723c-4f19-8bc0-e936a90c7a7a

## How can I edit this code?

There are several ways of editing your application.

**Use Lovable**

Simply visit the [Lovable Project](https://lovable.dev/projects/3aae6aac-723c-4f19-8bc0-e936a90c7a7a) and start prompting.

Changes made via Lovable will be committed automatically to this repo.

**Use your preferred IDE**

If you want to work locally using your own IDE, you can clone this repo and push changes. Pushed changes will also be reflected in Lovable.

The only requirement is having Node.js & npm installed - [install with nvm](https://github.com/nvm-sh/nvm#installing-and-updating)

Follow these steps:

```sh
# Step 1: Clone the repository using the project's Git URL.
git clone <YOUR_GIT_URL>

# Step 2: Navigate to the project directory.
cd <YOUR_PROJECT_NAME>

# Step 3: Install the necessary dependencies.
npm i

# Step 4: Start the development server with auto-reloading and an instant preview.
npm run dev
```

**Edit a file directly in GitHub**

- Navigate to the desired file(s).
- Click the "Edit" button (pencil icon) at the top right of the file view.
- Make your changes and commit the changes.

**Use GitHub Codespaces**

- Navigate to the main page of your repository.
- Click on the "Code" button (green button) near the top right.
- Select the "Codespaces" tab.
- Click on "New codespace" to launch a new Codespace environment.
- Edit files directly within the Codespace and commit and push your changes once you're done.

## What technologies are used for this project?

This project is built with:

- Vite
- TypeScript
- React
- shadcn-ui
- Tailwind CSS

## How can I deploy this project?

Simply open [Lovable](https://lovable.dev/projects/3aae6aac-723c-4f19-8bc0-e936a90c7a7a) and click on Share -> Publish.

## Can I connect a custom domain to my Lovable project?

Yes, you can!

To connect a domain, navigate to Project > Settings > Domains and click Connect Domain.

Read more here: [Setting up a custom domain](https://docs.lovable.dev/tips-tricks/custom-domain#step-by-step-guide)
