
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { CheckCircle2 } from "lucide-react";

const recyclingItems = [
  { title: "Papel y Cartón", items: ["Periódicos, revistas", "Cajas de cartón", "Folios, sobres"] },
  { title: "Plásticos y Envases", items: ["Botellas de plástico (agua, refrescos)", "Envases de yogurt", "Bolsas de plástico"] },
  { title: "Vidrio", items: ["Botellas de vidrio", "Frascos de conservas", "Tarros de cosmética"] },
  { title: "Orgánico", items: ["Restos de fruta y verdura", "Cáscaras de huevo", "Posos de café"] },
];

const RecyclingGuide = () => {
  return (
    <div className="animate-fade-in">
      <div className="mb-8 text-center">
        <h1 className="text-3xl font-bold">Guía de Reciclaje</h1>
        <p className="text-muted-foreground mt-2">Aprende a separar correctamente tus residuos.</p>
      </div>
      <div className="grid gap-6 md:grid-cols-2">
        {recyclingItems.map((category) => (
          <Card key={category.title}>
            <CardHeader>
              <CardTitle className="text-primary">{category.title}</CardTitle>
            </CardHeader>
            <CardContent>
              <ul className="space-y-2">
                {category.items.map((item) => (
                  <li key={item} className="flex items-center">
                    <CheckCircle2 className="h-5 w-5 text-green-500 mr-3 flex-shrink-0" />
                    <span>{item}</span>
                  </li>
                ))}
              </ul>
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  );
};

export default RecyclingGuide;
