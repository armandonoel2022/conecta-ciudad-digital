
import React, { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Calendar, DollarSign, Receipt, Loader2 } from 'lucide-react';
import { GarbageBill } from '@/hooks/useGarbageBills';
import { supabase } from '@/integrations/supabase/client';
import { useToast } from '@/hooks/use-toast';

interface BillCardProps {
  bill: GarbageBill;
  onPay?: (bill: GarbageBill) => void;
}

const BillCard = ({ bill, onPay }: BillCardProps) => {
  const [isProcessing, setIsProcessing] = useState(false);
  const { toast } = useToast();

  const formatAmount = (amount: number) => {
    return new Intl.NumberFormat('es-DO', {
      style: 'currency',
      currency: 'DOP'
    }).format(amount / 100);
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('es-DO', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  };

  const handlePayment = async () => {
    setIsProcessing(true);
    try {
      const { data, error } = await supabase.functions.invoke('create-bill-payment', {
        body: { billId: bill.id }
      });

      if (error) throw error;
      
      if (data?.url) {
        // Open Stripe checkout in a new tab
        window.open(data.url, '_blank');
        toast({
          title: "Redirigiendo a Stripe",
          description: "Se ha abierto una nueva pestaña para completar el pago",
        });
      }
    } catch (error) {
      console.error('Error creating payment:', error);
      toast({
        title: "Error al procesar el pago",
        description: "Hubo un problema al crear la sesión de pago. Por favor, intenta de nuevo.",
        variant: "destructive",
      });
    } finally {
      setIsProcessing(false);
    }
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'paid':
        return 'bg-accent text-accent-foreground';
      case 'overdue':
        return 'bg-destructive/10 text-destructive';
      case 'pending':
        return 'bg-secondary text-secondary-foreground';
      default:
        return 'bg-muted text-muted-foreground';
    }
  };

  const getStatusText = (status: string) => {
    switch (status) {
      case 'paid':
        return 'Pagada';
      case 'overdue':
        return 'Vencida';
      case 'pending':
        return 'Pendiente';
      case 'cancelled':
        return 'Cancelada';
      default:
        return status;
    }
  };

  const isOverdue = new Date(bill.due_date) < new Date() && bill.status === 'pending';

  return (
    <Card className="w-full">
      <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
        <CardTitle className="text-lg font-semibold flex items-center gap-2">
          <Receipt className="h-5 w-5" />
          {bill.bill_number}
        </CardTitle>
        <Badge className={getStatusColor(isOverdue ? 'overdue' : bill.status)}>
          {getStatusText(isOverdue ? 'overdue' : bill.status)}
        </Badge>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="grid grid-cols-2 gap-4">
          <div className="space-y-2">
            <p className="text-sm font-medium text-muted-foreground">Período de Facturación</p>
            <p className="text-sm">
              {formatDate(bill.billing_period_start)} - {formatDate(bill.billing_period_end)}
            </p>
          </div>
          <div className="space-y-2">
            <p className="text-sm font-medium text-muted-foreground">Fecha de Vencimiento</p>
            <div className="flex items-center gap-1">
              <Calendar className="h-4 w-4" />
              <p className="text-sm">{formatDate(bill.due_date)}</p>
            </div>
          </div>
        </div>
        
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <DollarSign className="h-5 w-5 text-accent-foreground" />
            <span className="text-xl font-bold text-accent-foreground">
              {formatAmount(bill.amount_due)}
            </span>
          </div>
          
          {bill.status === 'pending' && (
            <Button 
              onClick={handlePayment}
              disabled={isProcessing}
              className="bg-primary hover:bg-primary/90 text-primary-foreground"
            >
              {isProcessing ? (
                <>
                  <Loader2 className="h-4 w-4 animate-spin mr-2" />
                  Procesando...
                </>
              ) : (
                'Pagar Ahora'
              )}
            </Button>
          )}
        </div>
      </CardContent>
    </Card>
  );
};

export default BillCard;
