export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  public: {
    Tables: {
      amber_alerts: {
        Row: {
          additional_details: string | null
          child_full_name: string
          child_nickname: string | null
          child_photo_url: string | null
          contact_number: string
          created_at: string | null
          disappearance_time: string
          id: string
          is_active: boolean | null
          last_seen_location: string
          medical_conditions: string | null
          resolved_at: string | null
          resolved_by: string | null
          user_id: string
        }
        Insert: {
          additional_details?: string | null
          child_full_name: string
          child_nickname?: string | null
          child_photo_url?: string | null
          contact_number: string
          created_at?: string | null
          disappearance_time: string
          id?: string
          is_active?: boolean | null
          last_seen_location: string
          medical_conditions?: string | null
          resolved_at?: string | null
          resolved_by?: string | null
          user_id: string
        }
        Update: {
          additional_details?: string | null
          child_full_name?: string
          child_nickname?: string | null
          child_photo_url?: string | null
          contact_number?: string
          created_at?: string | null
          disappearance_time?: string
          id?: string
          is_active?: boolean | null
          last_seen_location?: string
          medical_conditions?: string | null
          resolved_at?: string | null
          resolved_by?: string | null
          user_id?: string
        }
        Relationships: []
      }
      before_after_videos: {
        Row: {
          created_at: string
          description: string | null
          file_name: string
          file_size: number | null
          id: string
          title: string
          updated_at: string
          user_id: string
          video_url: string
        }
        Insert: {
          created_at?: string
          description?: string | null
          file_name: string
          file_size?: number | null
          id?: string
          title: string
          updated_at?: string
          user_id: string
          video_url: string
        }
        Update: {
          created_at?: string
          description?: string | null
          file_name?: string
          file_size?: number | null
          id?: string
          title?: string
          updated_at?: string
          user_id?: string
          video_url?: string
        }
        Relationships: []
      }
      garbage_bills: {
        Row: {
          amount_due: number
          bill_number: string
          billing_period_end: string
          billing_period_start: string
          created_at: string
          due_date: string
          id: string
          status: string
          updated_at: string
          user_id: string
        }
        Insert: {
          amount_due: number
          bill_number: string
          billing_period_end: string
          billing_period_start: string
          created_at?: string
          due_date: string
          id?: string
          status?: string
          updated_at?: string
          user_id: string
        }
        Update: {
          amount_due?: number
          bill_number?: string
          billing_period_end?: string
          billing_period_start?: string
          created_at?: string
          due_date?: string
          id?: string
          status?: string
          updated_at?: string
          user_id?: string
        }
        Relationships: []
      }
      garbage_payments: {
        Row: {
          amount_paid: number
          bill_id: string
          created_at: string
          id: string
          payment_date: string | null
          payment_method: string | null
          payment_status: string
          stripe_session_id: string | null
          updated_at: string
          user_id: string
        }
        Insert: {
          amount_paid: number
          bill_id: string
          created_at?: string
          id?: string
          payment_date?: string | null
          payment_method?: string | null
          payment_status?: string
          stripe_session_id?: string | null
          updated_at?: string
          user_id: string
        }
        Update: {
          amount_paid?: number
          bill_id?: string
          created_at?: string
          id?: string
          payment_date?: string | null
          payment_method?: string | null
          payment_status?: string
          stripe_session_id?: string | null
          updated_at?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "garbage_payments_bill_id_fkey"
            columns: ["bill_id"]
            isOneToOne: false
            referencedRelation: "garbage_bills"
            referencedColumns: ["id"]
          },
        ]
      }
      generated_reports: {
        Row: {
          created_at: string | null
          date_range_end: string | null
          date_range_start: string | null
          description: string | null
          filters: Json | null
          generated_by: string | null
          google_chart_url: string | null
          google_sheets_url: string | null
          id: string
          pdf_url: string | null
          report_type: string
          status: string | null
          title: string
          updated_at: string | null
        }
        Insert: {
          created_at?: string | null
          date_range_end?: string | null
          date_range_start?: string | null
          description?: string | null
          filters?: Json | null
          generated_by?: string | null
          google_chart_url?: string | null
          google_sheets_url?: string | null
          id?: string
          pdf_url?: string | null
          report_type: string
          status?: string | null
          title: string
          updated_at?: string | null
        }
        Update: {
          created_at?: string | null
          date_range_end?: string | null
          date_range_start?: string | null
          description?: string | null
          filters?: Json | null
          generated_by?: string | null
          google_chart_url?: string | null
          google_sheets_url?: string | null
          id?: string
          pdf_url?: string | null
          report_type?: string
          status?: string | null
          title?: string
          updated_at?: string | null
        }
        Relationships: []
      }
      help_messages: {
        Row: {
          admin_response: string | null
          created_at: string
          id: string
          message: string
          priority: string
          resolved_at: string | null
          status: string
          subject: string
          updated_at: string
          user_email: string
          user_full_name: string
          user_id: string
        }
        Insert: {
          admin_response?: string | null
          created_at?: string
          id?: string
          message: string
          priority?: string
          resolved_at?: string | null
          status?: string
          subject: string
          updated_at?: string
          user_email: string
          user_full_name: string
          user_id: string
        }
        Update: {
          admin_response?: string | null
          created_at?: string
          id?: string
          message?: string
          priority?: string
          resolved_at?: string | null
          status?: string
          subject?: string
          updated_at?: string
          user_email?: string
          user_full_name?: string
          user_id?: string
        }
        Relationships: []
      }
      job_applications: {
        Row: {
          additional_courses: string | null
          address: string | null
          availability: string | null
          birth_date: string | null
          career_field: string | null
          created_at: string
          cv_file_name: string | null
          cv_file_url: string | null
          document_number: string | null
          document_type: string | null
          education_level: string
          email: string
          expected_salary: string | null
          full_name: string
          graduation_year: number | null
          id: string
          institution_name: string | null
          notes: string | null
          phone: string
          skills: string | null
          status: string
          updated_at: string
          user_id: string
          work_experience: string | null
        }
        Insert: {
          additional_courses?: string | null
          address?: string | null
          availability?: string | null
          birth_date?: string | null
          career_field?: string | null
          created_at?: string
          cv_file_name?: string | null
          cv_file_url?: string | null
          document_number?: string | null
          document_type?: string | null
          education_level: string
          email: string
          expected_salary?: string | null
          full_name: string
          graduation_year?: number | null
          id?: string
          institution_name?: string | null
          notes?: string | null
          phone: string
          skills?: string | null
          status?: string
          updated_at?: string
          user_id: string
          work_experience?: string | null
        }
        Update: {
          additional_courses?: string | null
          address?: string | null
          availability?: string | null
          birth_date?: string | null
          career_field?: string | null
          created_at?: string
          cv_file_name?: string | null
          cv_file_url?: string | null
          document_number?: string | null
          document_type?: string | null
          education_level?: string
          email?: string
          expected_salary?: string | null
          full_name?: string
          graduation_year?: number | null
          id?: string
          institution_name?: string | null
          notes?: string | null
          phone?: string
          skills?: string | null
          status?: string
          updated_at?: string
          user_id?: string
          work_experience?: string | null
        }
        Relationships: []
      }
      panic_alerts: {
        Row: {
          address: string | null
          created_at: string
          expires_at: string
          id: string
          is_active: boolean
          latitude: number | null
          longitude: number | null
          user_full_name: string
          user_id: string
        }
        Insert: {
          address?: string | null
          created_at?: string
          expires_at?: string
          id?: string
          is_active?: boolean
          latitude?: number | null
          longitude?: number | null
          user_full_name: string
          user_id: string
        }
        Update: {
          address?: string | null
          created_at?: string
          expires_at?: string
          id?: string
          is_active?: boolean
          latitude?: number | null
          longitude?: number | null
          user_full_name?: string
          user_id?: string
        }
        Relationships: []
      }
      profiles: {
        Row: {
          address: string | null
          birth_date: string | null
          city: string | null
          created_at: string | null
          document_number: string | null
          document_type: string | null
          first_name: string | null
          full_name: string | null
          gender: string | null
          id: string
          last_name: string | null
          neighborhood: string | null
          phone: string | null
          updated_at: string | null
        }
        Insert: {
          address?: string | null
          birth_date?: string | null
          city?: string | null
          created_at?: string | null
          document_number?: string | null
          document_type?: string | null
          first_name?: string | null
          full_name?: string | null
          gender?: string | null
          id: string
          last_name?: string | null
          neighborhood?: string | null
          phone?: string | null
          updated_at?: string | null
        }
        Update: {
          address?: string | null
          birth_date?: string | null
          city?: string | null
          created_at?: string | null
          document_number?: string | null
          document_type?: string | null
          first_name?: string | null
          full_name?: string | null
          gender?: string | null
          id?: string
          last_name?: string | null
          neighborhood?: string | null
          phone?: string | null
          updated_at?: string | null
        }
        Relationships: []
      }
      report_metrics: {
        Row: {
          category: string | null
          created_at: string | null
          id: string
          metric_name: string
          metric_type: string | null
          metric_value: number | null
          report_id: string | null
        }
        Insert: {
          category?: string | null
          created_at?: string | null
          id?: string
          metric_name: string
          metric_type?: string | null
          metric_value?: number | null
          report_id?: string | null
        }
        Update: {
          category?: string | null
          created_at?: string | null
          id?: string
          metric_name?: string
          metric_type?: string | null
          metric_value?: number | null
          report_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "report_metrics_report_id_fkey"
            columns: ["report_id"]
            isOneToOne: false
            referencedRelation: "generated_reports"
            referencedColumns: ["id"]
          },
        ]
      }
      report_schedules: {
        Row: {
          created_at: string | null
          created_by: string | null
          filters: Json | null
          frequency: string
          id: string
          is_active: boolean | null
          last_generated_at: string | null
          name: string
          next_generation_at: string | null
          report_type: string
          updated_at: string | null
        }
        Insert: {
          created_at?: string | null
          created_by?: string | null
          filters?: Json | null
          frequency: string
          id?: string
          is_active?: boolean | null
          last_generated_at?: string | null
          name: string
          next_generation_at?: string | null
          report_type: string
          updated_at?: string | null
        }
        Update: {
          created_at?: string | null
          created_by?: string | null
          filters?: Json | null
          frequency?: string
          id?: string
          is_active?: boolean | null
          last_generated_at?: string | null
          name?: string
          next_generation_at?: string | null
          report_type?: string
          updated_at?: string | null
        }
        Relationships: []
      }
      reports: {
        Row: {
          address: string | null
          assigned_to: string | null
          category: Database["public"]["Enums"]["report_category"]
          citizen_satisfaction: number | null
          created_at: string | null
          description: string
          id: string
          image_url: string | null
          latitude: number | null
          longitude: number | null
          neighborhood: string | null
          priority: string | null
          resolution_notes: string | null
          resolved_at: string | null
          status: Database["public"]["Enums"]["report_status"] | null
          title: string
          updated_at: string | null
          user_id: string
        }
        Insert: {
          address?: string | null
          assigned_to?: string | null
          category: Database["public"]["Enums"]["report_category"]
          citizen_satisfaction?: number | null
          created_at?: string | null
          description: string
          id?: string
          image_url?: string | null
          latitude?: number | null
          longitude?: number | null
          neighborhood?: string | null
          priority?: string | null
          resolution_notes?: string | null
          resolved_at?: string | null
          status?: Database["public"]["Enums"]["report_status"] | null
          title: string
          updated_at?: string | null
          user_id: string
        }
        Update: {
          address?: string | null
          assigned_to?: string | null
          category?: Database["public"]["Enums"]["report_category"]
          citizen_satisfaction?: number | null
          created_at?: string | null
          description?: string
          id?: string
          image_url?: string | null
          latitude?: number | null
          longitude?: number | null
          neighborhood?: string | null
          priority?: string | null
          resolution_notes?: string | null
          resolved_at?: string | null
          status?: Database["public"]["Enums"]["report_status"] | null
          title?: string
          updated_at?: string | null
          user_id?: string
        }
        Relationships: []
      }
      user_roles: {
        Row: {
          assigned_at: string
          assigned_by: string | null
          id: string
          is_active: boolean
          role: Database["public"]["Enums"]["app_role"]
          user_id: string
        }
        Insert: {
          assigned_at?: string
          assigned_by?: string | null
          id?: string
          is_active?: boolean
          role: Database["public"]["Enums"]["app_role"]
          user_id: string
        }
        Update: {
          assigned_at?: string
          assigned_by?: string | null
          id?: string
          is_active?: boolean
          role?: Database["public"]["Enums"]["app_role"]
          user_id?: string
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      deactivate_expired_panic_alerts: {
        Args: Record<PropertyKey, never>
        Returns: undefined
      }
      generate_bill_number: {
        Args: Record<PropertyKey, never>
        Returns: string
      }
      generate_monthly_bills: {
        Args: Record<PropertyKey, never>
        Returns: number
      }
      generate_scheduled_reports: {
        Args: Record<PropertyKey, never>
        Returns: number
      }
      has_role: {
        Args: {
          _user_id: string
          _role: Database["public"]["Enums"]["app_role"]
        }
        Returns: boolean
      }
      is_admin: {
        Args: { _user_id: string }
        Returns: boolean
      }
    }
    Enums: {
      app_role: "admin" | "community_leader" | "community_user"
      report_category:
        | "basura"
        | "iluminacion"
        | "baches"
        | "seguridad"
        | "otros"
      report_status: "pendiente" | "en_proceso" | "resuelto" | "rechazado"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DefaultSchema = Database[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof (Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        Database[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? (Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      Database[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof Database },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof Database },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends { schema: keyof Database }
  ? Database[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof Database },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends { schema: keyof Database }
  ? Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {
      app_role: ["admin", "community_leader", "community_user"],
      report_category: [
        "basura",
        "iluminacion",
        "baches",
        "seguridad",
        "otros",
      ],
      report_status: ["pendiente", "en_proceso", "resuelto", "rechazado"],
    },
  },
} as const
