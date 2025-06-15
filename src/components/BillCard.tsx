
import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Calendar, DollarSign, Receipt } from 'lucide-react';
import { GarbageBill } from '@/hooks/useGarbageBills';

interface BillCardProps {
  bill: GarbageBill;
  onPay: (bill: GarbageBill) => void;
}

const BillCard = ({ bill, onPay }: BillCardProps) => {
  const formatAmount = (amount: number) => {
    return new Intl.NumberFormat('es-CO', {
      style: 'currency',
      currency: 'COP'
    }).format(amount / 100);
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('es-CO', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'paid':
        return 'bg-green-100 text-green-800';
      case 'overdue':
        return 'bg-red-100 text-red-800';
      case 'pending':
        return 'bg-yellow-100 text-yellow-800';
      default:
        return 'bg-gray-100 text-gray-800';
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
            <p className="text-sm font-medium text-gray-600">Período de Facturación</p>
            <p className="text-sm">
              {formatDate(bill.billing_period_start)} - {formatDate(bill.billing_period_end)}
            </p>
          </div>
          <div className="space-y-2">
            <p className="text-sm font-medium text-gray-600">Fecha de Vencimiento</p>
            <div className="flex items-center gap-1">
              <Calendar className="h-4 w-4" />
              <p className="text-sm">{formatDate(bill.due_date)}</p>
            </div>
          </div>
        </div>
        
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <DollarSign className="h-5 w-5 text-green-600" />
            <span className="text-xl font-bold text-green-600">
              {formatAmount(bill.amount_due)}
            </span>
          </div>
          
          {bill.status === 'pending' && (
            <Button 
              onClick={() => onPay(bill)}
              className="bg-green-600 hover:bg-green-700"
            >
              Pagar Ahora
            </Button>
          )}
        </div>
      </CardContent>
    </Card>
  );
};

export default BillCard;
