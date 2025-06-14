
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Briefcase } from "lucide-react";

const Opportunities = () => {
  return (
    <div className="flex items-center justify-center h-full animate-fade-in">
      <Card className="w-full max-w-md text-center">
        <CardHeader>
          <div className="mx-auto bg-primary/10 p-3 rounded-full w-fit">
            <Briefcase className="h-10 w-10 text-primary" />
          </div>
          <CardTitle className="mt-4 text-2xl">Oportunidades</CardTitle>
          <CardDescription>
            ¡Estamos trabajando en esta sección! Aquí encontrarás oportunidades.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">Vuelve pronto para ver el contenido.</p>
        </CardContent>
      </Card>
    </div>
  );
};

export default Opportunities;
