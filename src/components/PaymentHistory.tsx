
import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { CheckCircle, XCircle, Clock, RotateCcw } from 'lucide-react';
import { GarbagePayment } from '@/hooks/useGarbageBills';

interface PaymentHistoryProps {
  payments: GarbagePayment[];
}

const PaymentHistory = ({ payments }: PaymentHistoryProps) => {
  const formatAmount = (amount: number) => {
    return new Intl.NumberFormat('es-DO', {
      style: 'currency',
      currency: 'DOP'
    }).format(amount / 100);
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('es-DO', {
      year: 'numeric',
      month: 'short',
      day: 'numeric'
    });
  };

  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'completed':
        return <CheckCircle className="h-4 w-4 text-accent-foreground" />;
      case 'failed':
        return <XCircle className="h-4 w-4 text-destructive" />;
      case 'pending':
        return <Clock className="h-4 w-4 text-secondary-foreground" />;
      case 'refunded':
        return <RotateCcw className="h-4 w-4 text-primary" />;
      default:
        return <Clock className="h-4 w-4 text-muted-foreground" />;
    }
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'completed':
        return 'bg-accent text-accent-foreground';
      case 'failed':
        return 'bg-destructive/10 text-destructive';
      case 'pending':
        return 'bg-secondary text-secondary-foreground';
      case 'refunded':
        return 'bg-muted text-muted-foreground';
      default:
        return 'bg-muted text-muted-foreground';
    }
  };

  const getStatusText = (status: string) => {
    switch (status) {
      case 'completed':
        return 'Completado';
      case 'failed':
        return 'Fallido';
      case 'pending':
        return 'Pendiente';
      case 'refunded':
        return 'Reembolsado';
      default:
        return status;
    }
  };

  if (payments.length === 0) {
    return (
      <Card>
        <CardHeader>
          <CardTitle>Historial de Pagos</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-center text-muted-foreground py-8">
            No tienes pagos registrados aún.
          </p>
        </CardContent>
      </Card>
    );
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle>Historial de Pagos</CardTitle>
      </CardHeader>
      <CardContent>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Factura</TableHead>
              <TableHead>Fecha</TableHead>
              <TableHead>Monto</TableHead>
              <TableHead>Método</TableHead>
              <TableHead>Estado</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {payments.map((payment) => (
              <TableRow key={payment.id}>
                <TableCell className="font-medium">
                  {payment.garbage_bills?.bill_number || 'N/A'}
                </TableCell>
                <TableCell>
                  {payment.payment_date ? formatDate(payment.payment_date) : formatDate(payment.created_at)}
                </TableCell>
                <TableCell className="font-semibold text-accent-foreground">
                  {formatAmount(payment.amount_paid)}
                </TableCell>
                <TableCell className="capitalize">
                  {payment.payment_method || 'Stripe'}
                </TableCell>
                <TableCell>
                  <div className="flex items-center gap-2">
                    {getStatusIcon(payment.payment_status)}
                    <Badge className={getStatusColor(payment.payment_status)}>
                      {getStatusText(payment.payment_status)}
                    </Badge>
                  </div>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </CardContent>
    </Card>
  );
};

export default PaymentHistory;
