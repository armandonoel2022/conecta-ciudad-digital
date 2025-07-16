
import React, { useState, useEffect } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { toast } from 'sonner';
import { Trash2, Plus, RefreshCw, CreditCard, History, CheckCircle, XCircle, ArrowLeft } from "lucide-react";
import { useGarbageBills } from '@/hooks/useGarbageBills';
import { supabase } from '@/integrations/supabase/client';
import BillCard from '@/components/BillCard';
import PaymentHistory from '@/components/PaymentHistory';
import SubscriptionPlans from '@/components/SubscriptionPlans';
import { Link } from 'react-router-dom';
import { useAutoBilling } from '@/hooks/useAutoBilling';

const GarbagePayment = () => {
  const { bills, payments, loading, generateBills, fetchBills, fetchPayments } = useGarbageBills();
  const [generatingBills, setGeneratingBills] = useState(false);
  const { isProcessing: isAutoProcessing } = useAutoBilling();

  // Check for payment success/failure on page load
  useEffect(() => {
    const urlParams = new URLSearchParams(window.location.search);
    const sessionId = urlParams.get('session_id');
    const paymentStatus = urlParams.get('payment');
    const subscriptionStatus = urlParams.get('subscription');

    if (sessionId && paymentStatus === 'success') {
      verifyPayment(sessionId);
    } else if (paymentStatus === 'cancelled') {
      toast.error('Pago cancelado');
    } else if (subscriptionStatus === 'success') {
      toast.success('¡Suscripción creada exitosamente!');
      fetchBills();
      fetchPayments();
    } else if (subscriptionStatus === 'cancelled') {
      toast.error('Suscripción cancelada');
    }

    // Clean up URL parameters
    if (sessionId || paymentStatus || subscriptionStatus) {
      window.history.replaceState({}, '', '/pago-basura');
    }
  }, []);

  const verifyPayment = async (sessionId: string) => {
    try {
      const { data, error } = await supabase.functions.invoke('verify-payment', {
        body: { sessionId }
      });

      if (error) throw error;

      if (data?.success) {
        toast.success('¡Pago completado exitosamente!');
        // Refresh bills and payments immediately
        await fetchBills();
        await fetchPayments();
        // Also refresh after a short delay to ensure backend processing is complete
        setTimeout(async () => {
          await fetchBills();
          await fetchPayments();
        }, 2000);
      } else {
        toast.error('El pago no se pudo completar');
      }
    } catch (error) {
      console.error('Error verifying payment:', error);
      toast.error('Error al verificar el pago');
    }
  };

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

  const handleCreateTestBill = async () => {
    setGeneratingBills(true);
    try {
      const { data, error } = await supabase.functions.invoke('create-test-bill');
      
      if (error) throw error;
      
      if (data?.success) {
        toast.success('¡Factura de prueba creada exitosamente!');
        // Refresh bills to show the new test bill
        fetchBills();
      } else {
        toast.error('Error al crear la factura de prueba');
      }
    } catch (error) {
      console.error('Error creating test bill:', error);
      toast.error('Error al crear la factura de prueba');
    } finally {
      setGeneratingBills(false);
    }
  };

  const pendingBills = bills.filter(bill => bill.status === 'pending' && new Date(bill.due_date) >= new Date());
  const paidBills = bills.filter(bill => bill.status === 'paid');
  const overdueBills = bills.filter(bill => bill.status === 'overdue' || (bill.status === 'pending' && new Date(bill.due_date) < new Date()));

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
          <Link to="/" className="p-2 hover:bg-white/20 rounded-xl transition-colors">
            <ArrowLeft className="h-6 w-6" />
          </Link>
          <div className="bg-green-100 p-3 rounded-full">
            <Trash2 className="h-8 w-8 text-green-600" />
          </div>
          <div>
            <h1 className="text-3xl font-bold text-white">Pago de Basura</h1>
            <p className="text-white/80">Gestiona tus facturas y pagos de basura</p>
          </div>
        </div>
        
        <div className="flex gap-4">
          <Button 
            onClick={handleGenerateBills}
            disabled={generatingBills || isAutoProcessing}
            className="bg-blue-600 hover:bg-blue-700"
          >
            {generatingBills || isAutoProcessing ? (
              <RefreshCw className="h-4 w-4 animate-spin mr-2" />
            ) : (
              <Plus className="h-4 w-4 mr-2" />
            )}
            Generar Facturas
          </Button>
          
          <Button 
            onClick={handleCreateTestBill}
            disabled={generatingBills || isAutoProcessing}
            variant="outline"
            className="bg-green-600 hover:bg-green-700 text-white border-green-600"
          >
            {generatingBills || isAutoProcessing ? (
              <RefreshCw className="h-4 w-4 animate-spin mr-2" />
            ) : (
              <Plus className="h-4 w-4 mr-2" />
            )}
            Crear Factura de Prueba
          </Button>
        </div>
      </div>

      <Tabs defaultValue="bills" className="space-y-6">
        <TabsList className="grid w-full grid-cols-4">
          <TabsTrigger value="bills" className="flex items-center gap-2">
            <CreditCard className="h-4 w-4" />
            Pendientes ({pendingBills.length})
          </TabsTrigger>
          <TabsTrigger value="overdue" className="flex items-center gap-2">
            <XCircle className="h-4 w-4" />
            Vencidas ({overdueBills.length})
          </TabsTrigger>
          <TabsTrigger value="paid" className="flex items-center gap-2">
            <CheckCircle className="h-4 w-4" />
            Pagadas ({paidBills.length})
          </TabsTrigger>
          <TabsTrigger value="history" className="flex items-center gap-2">
            <History className="h-4 w-4" />
            Historial
          </TabsTrigger>
        </TabsList>

        <TabsContent value="bills" className="space-y-6">
          <SubscriptionPlans />
          
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
                />
              ))}
            </div>
          )}
        </TabsContent>

        <TabsContent value="overdue" className="space-y-6">
          {overdueBills.length === 0 ? (
            <Card>
              <CardHeader className="text-center">
                <div className="mx-auto bg-green-100 p-3 rounded-full w-fit mb-4">
                  <CheckCircle className="h-10 w-10 text-green-600" />
                </div>
                <CardTitle>No tienes facturas vencidas</CardTitle>
                <CardDescription>
                  ¡Excelente! No tienes facturas vencidas.
                </CardDescription>
              </CardHeader>
            </Card>
          ) : (
            <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
              {overdueBills.map((bill) => (
                <BillCard 
                  key={bill.id} 
                  bill={bill} 
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
