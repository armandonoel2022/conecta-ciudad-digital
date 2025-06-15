
import React, { useState } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { toast } from 'sonner';
import { Trash2, Plus, RefreshCw, CreditCard, History } from "lucide-react";
import { useGarbageBills } from '@/hooks/useGarbageBills';
import BillCard from '@/components/BillCard';
import PaymentHistory from '@/components/PaymentHistory';
import type { GarbageBill } from '@/hooks/useGarbageBills';

const GarbagePayment = () => {
  const { bills, payments, loading, generateBills } = useGarbageBills();
  const [generatingBills, setGeneratingBills] = useState(false);

  const handleGenerateBills = async () => {
    setGeneratingBills(true);
    try {
      const count = await generateBills();
      if (count > 0) {
        toast.success(`Se generaron ${count} nuevas facturas`);
      } else {
        toast.info('No hay facturas nuevas por generar este mes');
      }
    } catch (error) {
      toast.error('Error al generar facturas');
    } finally {
      setGeneratingBills(false);
    }
  };

  const handlePayBill = async (bill: GarbageBill) => {
    // Simulate payment process
    toast.info(`Procesando pago para factura ${bill.bill_number}...`);
    
    // In a real implementation, you would integrate with Stripe here
    setTimeout(() => {
      toast.success('¡Pago procesado exitosamente!');
    }, 2000);
  };

  const pendingBills = bills.filter(bill => bill.status === 'pending');
  const paidBills = bills.filter(bill => bill.status === 'paid');

  if (loading) {
    return (
      <div className="flex items-center justify-center h-full">
        <div className="text-center">
          <RefreshCw className="h-8 w-8 animate-spin mx-auto mb-4" />
          <p>Cargando información de facturación...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="container mx-auto p-6 max-w-6xl">
      <div className="flex items-center justify-between mb-6">
        <div className="flex items-center gap-3">
          <div className="bg-green-100 p-3 rounded-full">
            <Trash2 className="h-8 w-8 text-green-600" />
          </div>
          <div>
            <h1 className="text-3xl font-bold text-gray-900">Pago de Basura</h1>
            <p className="text-gray-600">Gestiona tus facturas y pagos de basura</p>
          </div>
        </div>
        
        <Button 
          onClick={handleGenerateBills}
          disabled={generatingBills}
          className="bg-blue-600 hover:bg-blue-700"
        >
          {generatingBills ? (
            <RefreshCw className="h-4 w-4 animate-spin mr-2" />
          ) : (
            <Plus className="h-4 w-4 mr-2" />
          )}
          Generar Facturas
        </Button>
      </div>

      <Tabs defaultValue="bills" className="space-y-6">
        <TabsList className="grid w-full grid-cols-3">
          <TabsTrigger value="bills" className="flex items-center gap-2">
            <CreditCard className="h-4 w-4" />
            Facturas Pendientes
          </TabsTrigger>
          <TabsTrigger value="paid" className="flex items-center gap-2">
            <CreditCard className="h-4 w-4" />
            Facturas Pagadas
          </TabsTrigger>
          <TabsTrigger value="history" className="flex items-center gap-2">
            <History className="h-4 w-4" />
            Historial de Pagos
          </TabsTrigger>
        </TabsList>

        <TabsContent value="bills" className="space-y-6">
          {pendingBills.length === 0 ? (
            <Card>
              <CardHeader className="text-center">
                <div className="mx-auto bg-green-100 p-3 rounded-full w-fit mb-4">
                  <Trash2 className="h-10 w-10 text-green-600" />
                </div>
                <CardTitle>No tienes facturas pendientes</CardTitle>
                <CardDescription>
                  ¡Excelente! Estás al día con tus pagos de basura.
                </CardDescription>
              </CardHeader>
              <CardContent className="text-center">
                <Button 
                  onClick={handleGenerateBills}
                  disabled={generatingBills}
                  variant="outline"
                >
                  {generatingBills ? (
                    <RefreshCw className="h-4 w-4 animate-spin mr-2" />
                  ) : (
                    <Plus className="h-4 w-4 mr-2" />
                  )}
                  Generar Facturas del Mes
                </Button>
              </CardContent>
            </Card>
          ) : (
            <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
              {pendingBills.map((bill) => (
                <BillCard 
                  key={bill.id} 
                  bill={bill} 
                  onPay={handlePayBill}
                />
              ))}
            </div>
          )}
        </TabsContent>

        <TabsContent value="paid" className="space-y-6">
          {paidBills.length === 0 ? (
            <Card>
              <CardHeader className="text-center">
                <CardTitle>No tienes facturas pagadas</CardTitle>
                <CardDescription>
                  Las facturas pagadas aparecerán aquí.
                </CardDescription>
              </CardHeader>
            </Card>
          ) : (
            <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
              {paidBills.map((bill) => (
                <BillCard 
                  key={bill.id} 
                  bill={bill} 
                  onPay={handlePayBill}
                />
              ))}
            </div>
          )}
        </TabsContent>

        <TabsContent value="history">
          <PaymentHistory payments={payments} />
        </TabsContent>
      </Tabs>
    </div>
  );
};

export default GarbagePayment;
