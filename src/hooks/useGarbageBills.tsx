
import { useState, useEffect } from 'react';
import { useAuth } from '@/hooks/useAuth';
import { supabase } from '@/integrations/supabase/client';

export interface GarbageBill {
  id: string;
  bill_number: string;
  billing_period_start: string;
  billing_period_end: string;
  amount_due: number;
  due_date: string;
  status: 'pending' | 'paid' | 'overdue' | 'cancelled';
  created_at: string;
}

export interface GarbagePayment {
  id: string;
  bill_id: string;
  amount_paid: number;
  payment_method: string;
  payment_status: 'pending' | 'completed' | 'failed' | 'refunded';
  payment_date: string;
  created_at: string;
  garbage_bills?: GarbageBill;
}

export const useGarbageBills = () => {
  const { user } = useAuth();
  const [bills, setBills] = useState<GarbageBill[]>([]);
  const [payments, setPayments] = useState<GarbagePayment[]>([]);
  const [loading, setLoading] = useState(true);

  const fetchBills = async () => {
    if (!user) return;

    try {
      const { data, error } = await supabase
        .from('garbage_bills')
        .select('*')
        .eq('user_id', user.id)
        .order('created_at', { ascending: false });

      if (error) throw error;
      
      // Type assertion to ensure the status field matches our interface
      const typedBills: GarbageBill[] = (data || []).map(bill => {
        // Auto-detect overdue status if not already marked
        let status = bill.status as 'pending' | 'paid' | 'overdue' | 'cancelled';
        if (status === 'pending' && new Date(bill.due_date) < new Date()) {
          status = 'overdue';
        }
        return {
          ...bill,
          status
        };
      });
      
      setBills(typedBills);
    } catch (error) {
      console.error('Error fetching bills:', error);
    }
  };

  const fetchPayments = async () => {
    if (!user) return;

    try {
      const { data, error } = await supabase
        .from('garbage_payments')
        .select(`
          *,
          garbage_bills (*)
        `)
        .eq('user_id', user.id)
        .order('created_at', { ascending: false });

      if (error) throw error;
      
      // Type assertion to ensure the payment_status field matches our interface
      const typedPayments: GarbagePayment[] = (data || []).map(payment => ({
        ...payment,
        payment_status: payment.payment_status as 'pending' | 'completed' | 'failed' | 'refunded',
        garbage_bills: payment.garbage_bills ? {
          ...payment.garbage_bills,
          status: payment.garbage_bills.status as 'pending' | 'paid' | 'overdue' | 'cancelled'
        } : undefined
      }));
      
      setPayments(typedPayments);
    } catch (error) {
      console.error('Error fetching payments:', error);
    }
  };

  const generateBills = async () => {
    try {
      const { data, error } = await supabase
        .rpc('generate_monthly_bills');

      if (error) throw error;
      console.log(`Generated ${data} bills`);
      await fetchBills();
      return data;
    } catch (error) {
      console.error('Error generating bills:', error);
      throw error;
    }
  };

  useEffect(() => {
    const loadData = async () => {
      if (user) {
        setLoading(true);
        await Promise.all([fetchBills(), fetchPayments()]);
        setLoading(false);
      }
    };

    loadData();
  }, [user]);

  // Refresh data every 30 seconds to catch status updates
  useEffect(() => {
    if (!user) return;
    
    const interval = setInterval(async () => {
      await Promise.all([fetchBills(), fetchPayments()]);
    }, 30000);

    return () => clearInterval(interval);
  }, [user]);

  return {
    bills,
    payments,
    loading,
    fetchBills,
    fetchPayments,
    generateBills
  };
};
