// Common types
export interface TimeStamped {
  created_at: string
  created_by?: number
  updated_at: string
  updated_by?: number
}

export interface PaginatedResponse<T> {
  count: number
  next: string | null
  previous: string | null
  results: T[]
}

// Auth types
export interface LoginCredentials {
  username: string
  password: string
}

export interface TokenResponse {
  access: string
  refresh: string
}

export interface User {
  id: number
  username: string
  email: string
  first_name: string
  last_name: string
}

// Customer types
export interface Customer {
  id: number
  customer_code: string
  company_name: string
  address_line1: string
  address_line2?: string
  city: string
  state: string
  zip_code: string
  country: string
  phone?: string
  email?: string
  is_active: boolean
}

export interface CustomerContact {
  id: number
  customer: number
  name: string
  email?: string
  phone?: string
  position?: string
  is_primary: boolean
}

// Coil types
export interface Coil extends TimeStamped {
  id: number
  original_coil_number: string
  abc_coil_number: string
  customer: number
  customer_name?: string
  alloy: number
  alloy_code?: string
  temper: number
  temper_code?: string
  gauge: number
  width: number
  gross_weight: number
  net_weight: number
  metal_weight: number
  tare_weight: number
  received_date: string
  heat_number?: string
  po_number?: string
  location?: string
  status: 'RECEIVED' | 'QA_PENDING' | 'QA_APPROVED' | 'QA_REJECTED' | 'IN_PRODUCTION' | 'SCRAPPED'
  notes?: string
}

export interface CoilHistory {
  id: number
  coil: number
  action: string
  old_value?: string
  new_value?: string
  changed_by: number
  changed_at: string
}

// Skid types
export interface Skid extends TimeStamped {
  id: number
  skid_number: string
  job: number
  job_number?: string
  customer: number
  customer_name?: string
  part_number: string
  part_description: string
  quantity: number
  gross_weight: number
  net_weight: number
  location?: string
  status: 'PENDING_QA' | 'QA_APPROVED' | 'QA_REJECTED' | 'READY_TO_SHIP' | 'SHIPPED'
  qa_approved_date?: string
  qa_approved_by?: number
  notes?: string
}

// Job types
export interface Job extends TimeStamped {
  id: number
  job_number: string
  customer: number
  customer_name?: string
  line: number
  line_name?: string
  part_number: string
  part_description: string
  ordered_quantity: number
  produced_quantity: number
  target_gauge: number
  target_width: number
  status: 'SCHEDULED' | 'IN_PROGRESS' | 'COMPLETED' | 'ON_HOLD' | 'CANCELLED'
  scheduled_date?: string
  start_date?: string
  completion_date?: string
  notes?: string
}

export interface JobCoil {
  id: number
  job: number
  coil: number
  coil_number?: string
  sequence: number
  assigned_date: string
  used: boolean
  yield_percentage?: number
}

// Shipment types
export interface Shipment extends TimeStamped {
  id: number
  bol_number: string
  customer: number
  customer_name?: string
  carrier: number
  carrier_name?: string
  ship_to_name: string
  ship_to_address1: string
  ship_to_address2?: string
  ship_to_city: string
  ship_to_state: string
  ship_to_zip: string
  ship_date: string
  status: 'OPEN' | 'READY' | 'SHIPPED' | 'CANCELLED'
  total_weight: number
  total_pieces: number
  notes?: string
}

// Production types
export interface DailyProduction {
  id: number
  production_date: string
  line: number
  line_name?: string
  shift: number
  shift_name?: string
  job: number
  job_number?: string
  coils_processed: number
  feet_processed: number
  pounds_processed: number
  downtime_minutes: number
  scrap_pounds: number
  notes?: string
}

export interface Downtime {
  id: number
  line: number
  line_name?: string
  downtime_date: string
  start_time: string
  end_time: string
  duration_minutes: number
  category: string
  reason: string
  notes?: string
}

// Dashboard/Stats types
export interface DashboardStats {
  total_coils: number
  coils_in_qa: number
  active_jobs: number
  open_shipments: number
  daily_production: number
  monthly_production: number
}
