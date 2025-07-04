import React, { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Building, Home, Factory, Loader2 } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';

const SUBSCRIPTION_PLANS = [
  {
    id: 'residential',
    name: 'Residencial',
    price: 325,
    icon: Home,
    color: 'from-blue-400 to-blue-600',
    description: 'Recogida de basura por una de nuestras unidades. Contrato fijo.'
  },
  {
    id: 'commercial', 
    name: 'Comercial',
    price: 541,
    icon: Building,
    color: 'from-slate-600 to-slate-800',
    description: 'Recogida de basura por una de nuestras unidades. Contrato fijo.'
  },
  {
    id: 'industrial',
    name: 'Industrial', 
    price: 1083,
    icon: Factory,
    color: 'from-amber-400 to-orange-500',
    description: 'Recogida de basura por una de nuestras unidades. Contrato fijo.'
  }
];

const SubscriptionPlans = () => {
  const [processingPlan, setProcessingPlan] = useState<string | null>(null);
  const { toast } = useToast();

  const handleSubscribe = async (planId: string) => {
    setProcessingPlan(planId);
    try {
      const { data, error } = await supabase.functions.invoke('create-subscription', {
        body: { subscriptionType: planId }
      });

      if (error) throw error;
      
      if (data?.url) {
        window.open(data.url, '_blank');
        toast({
          title: "Redirigiendo a Stripe",
          description: "Se ha abierto una nueva pestaña para configurar tu suscripción",
        });
      }
    } catch (error) {
      toast({
        title: "Error al crear suscripción",
        description: "Hubo un problema. Por favor, intenta de nuevo.",
        variant: "destructive",
      });
    } finally {
      setProcessingPlan(null);
    }
  };

  return (
    <div className="grid md:grid-cols-3 gap-6 mt-6">
      {SUBSCRIPTION_PLANS.map((plan) => {
        const Icon = plan.icon;
        const isProcessing = processingPlan === plan.id;
        
        return (
          <Card key={plan.id} className="relative overflow-hidden">
            <div className={`h-2 bg-gradient-to-r ${plan.color}`} />
            <CardHeader className="text-center">
              <div className={`mx-auto p-3 rounded-full bg-gradient-to-r ${plan.color} w-fit mb-2`}>
                <Icon className="h-8 w-8 text-primary-foreground" />
              </div>
              <CardTitle className="text-xl">{plan.name}</CardTitle>
              <div className="text-3xl font-bold text-accent-foreground">
                ${plan.price}<span className="text-lg text-muted-foreground">/mes</span>
              </div>
            </CardHeader>
            <CardContent className="text-center space-y-4">
              <p className="text-sm text-muted-foreground">{plan.description}</p>
              <Button 
                onClick={() => handleSubscribe(plan.id)}
                disabled={isProcessing}
                className="w-full bg-primary hover:bg-primary/90 text-primary-foreground"
              >
                {isProcessing ? (
                  <>
                    <Loader2 className="h-4 w-4 animate-spin mr-2" />
                    Procesando...
                  </>
                ) : (
                  'Suscribirse'
                )}
              </Button>
            </CardContent>
          </Card>
        );
      })}
    </div>
  );
};

export default SubscriptionPlans;