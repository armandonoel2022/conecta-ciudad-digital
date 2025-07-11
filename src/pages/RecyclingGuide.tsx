
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { CheckCircle2, ArrowLeft, XCircle, AlertTriangle } from "lucide-react";
import { Link } from "react-router-dom";

const recyclingItems = [
  { 
    title: "Papel y Cartón", 
    items: ["Periódicos, revistas", "Cajas de cartón", "Folios, sobres", "Libros viejos"],
    color: "blue"
  },
  { 
    title: "Plásticos y Envases", 
    items: ["Botellas de plástico (agua, refrescos)", "Envases de yogurt", "Latas de aluminio", "Tetrabriks"],
    color: "yellow" 
  },
  { 
    title: "Vidrio", 
    items: ["Botellas de vidrio", "Frascos de conservas", "Tarros de cosmética"],
    color: "green"
  },
  { 
    title: "Orgánico", 
    items: ["Restos de fruta y verdura", "Cáscaras de huevo", "Posos de café", "Restos de comida"],
    color: "brown"
  },
];

const nonRecyclableItems = [
  { 
    title: "NO Reciclables", 
    items: ["Bolsas de plástico", "Pañales", "Chicles", "Espejos", "Bombillas", "Cerámicas rotas"],
    color: "red"
  },
  { 
    title: "Puntos Especiales", 
    items: ["Pilas (puntos específicos)", "Medicamentos (farmacias)", "Aceite usado (puntos limpios)", "Electrónicos (tiendas especializadas)"],
    color: "purple"
  }
];

const RecyclingGuide = () => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700 p-4 animate-fade-in">
      <div className="max-w-md mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4 text-white mb-4">
          <Link to="/" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold">GUÍA DE RECICLAJE</h1>
            <p className="text-white/80">Aprende a separar correctamente</p>
          </div>
        </div>

        {/* Content Card */}
        <div className="bg-white rounded-[2rem] p-6 shadow-xl">
          <div className="mb-6 text-center">
            <h2 className="text-xl font-bold text-gray-800 mb-2">Guía de Reciclaje</h2>
            <p className="text-gray-600 text-sm">Aprende a separar correctamente tus residuos.</p>
          </div>
          
          {/* Reciclables */}
          <div className="mb-6">
            <h3 className="text-lg font-semibold text-green-600 mb-3 flex items-center">
              <CheckCircle2 className="h-5 w-5 mr-2" />
              SÍ se Recicla
            </h3>
            <div className="grid gap-4">
              {recyclingItems.map((category) => (
                <Card key={category.title} className="border-2 border-green-100">
                  <CardHeader className="pb-3">
                    <CardTitle className="text-primary text-lg">{category.title}</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <ul className="space-y-2">
                      {category.items.map((item) => (
                        <li key={item} className="flex items-center">
                          <CheckCircle2 className="h-4 w-4 text-green-500 mr-3 flex-shrink-0" />
                          <span className="text-sm text-gray-700">{item}</span>
                        </li>
                      ))}
                    </ul>
                  </CardContent>
                </Card>
              ))}
            </div>
          </div>

          {/* NO Reciclables */}
          <div>
            <h3 className="text-lg font-semibold text-red-600 mb-3 flex items-center">
              <XCircle className="h-5 w-5 mr-2" />
              NO se Recicla / Casos Especiales
            </h3>
            <div className="grid gap-4">
              {nonRecyclableItems.map((category) => (
                <Card key={category.title} className={`border-2 ${category.color === 'red' ? 'border-red-100' : 'border-purple-100'}`}>
                  <CardHeader className="pb-3">
                    <CardTitle className={`text-lg ${category.color === 'red' ? 'text-red-600' : 'text-purple-600'}`}>
                      {category.title}
                    </CardTitle>
                  </CardHeader>
                  <CardContent>
                    <ul className="space-y-2">
                      {category.items.map((item) => (
                        <li key={item} className="flex items-center">
                          {category.color === 'red' ? (
                            <XCircle className="h-4 w-4 text-red-500 mr-3 flex-shrink-0" />
                          ) : (
                            <AlertTriangle className="h-4 w-4 text-purple-500 mr-3 flex-shrink-0" />
                          )}
                          <span className="text-sm text-gray-700">{item}</span>
                        </li>
                      ))}
                    </ul>
                  </CardContent>
                </Card>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default RecyclingGuide;
