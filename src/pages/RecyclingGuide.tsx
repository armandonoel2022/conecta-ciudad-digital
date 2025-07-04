
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { CheckCircle2, ArrowLeft } from "lucide-react";
import { Link } from "react-router-dom";

const recyclingItems = [
  { title: "Papel y Cartón", items: ["Periódicos, revistas", "Cajas de cartón", "Folios, sobres"] },
  { title: "Plásticos y Envases", items: ["Botellas de plástico (agua, refrescos)", "Envases de yogurt", "Bolsas de plástico"] },
  { title: "Vidrio", items: ["Botellas de vidrio", "Frascos de conservas", "Tarros de cosmética"] },
  { title: "Orgánico", items: ["Restos de fruta y verdura", "Cáscaras de huevo", "Posos de café"] },
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
          <div className="grid gap-4">
            {recyclingItems.map((category) => (
              <Card key={category.title} className="border-2 border-gray-100">
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
      </div>
    </div>
  );
};

export default RecyclingGuide;
