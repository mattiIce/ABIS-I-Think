import { api } from '../lib/api';

export interface ProductionTrend {
  date: string;
  total_jobs: number;
  total_quantity: number;
}

export interface ProductionByLine {
  line__name: string;
  total_jobs: number;
  total_quantity: number;
  avg_quantity: number;
}

export interface EfficiencyMetrics {
  total_jobs: number;
  completed_jobs: number;
  in_progress_jobs: number;
  pending_jobs: number;
  completion_rate: number;
}

export interface DowntimeData {
  category: string;
  total_incidents: number;
  total_duration: number;
}

export interface ProductionDashboardData {
  trends: ProductionTrend[];
  by_line: ProductionByLine[];
  efficiency: EfficiencyMetrics;
  downtime: DowntimeData[];
  period: {
    days: number;
    start_date: string;
    end_date: string;
  };
}

export interface QualityTrend {
  date: string;
  total_tests: number;
  passed_tests: number;
  failed_tests: number;
}

export interface DefectDistribution {
  defect_type__name: string;
  count: number;
}

export interface QualityMetrics {
  total_tests: number;
  passed_tests: number;
  failed_tests: number;
  pass_rate: number;
}

export interface QAByInspector {
  inspector__username: string;
  total_tests: number;
  passed_tests: number;
  failed_tests: number;
}

export interface QualityDashboardData {
  trends: QualityTrend[];
  defect_distribution: DefectDistribution[];
  metrics: QualityMetrics;
  by_inspector: QAByInspector[];
  period: {
    days: number;
    start_date: string;
    end_date: string;
  };
}

export interface InventoryLevel {
  material__alloy__code: string;
  total_coils: number;
  total_weight: number;
}

export interface TurnoverData {
  coils_received: number;
  weight_received: number;
  total_shipments: number;
  period_days: number;
}

export interface InventoryValue {
  total_coils: number;
  total_weight: number;
}

export interface AgingData {
  '0-30_days': number;
  '31-60_days': number;
  '61-90_days': number;
  '90plus_days': number;
}

export interface InventoryDashboardData {
  levels: InventoryLevel[];
  turnover: TurnoverData;
  value: InventoryValue;
  aging: AgingData;
  period: {
    days: number;
    start_date: string;
    end_date: string;
  };
}

export interface TopCustomer {
  customer__company_name: string;
  total_shipments: number;
  total_value: number;
}

export interface OrderTrend {
  week: string;
  total_orders: number;
  total_quantity: number;
}

export interface ShipmentAnalysis {
  total_shipments: number;
  delivered: number;
  pending: number;
  on_time_rate: number;
}

export interface CustomerDistribution {
  state: string;
  count: number;
}

export interface CustomerDashboardData {
  top_customers: TopCustomer[];
  order_trends: OrderTrend[];
  shipment_analysis: ShipmentAnalysis;
  distribution: CustomerDistribution[];
  period: {
    days: number;
    start_date: string;
    end_date: string;
  };
}

export interface OverviewDashboardData {
  production: EfficiencyMetrics;
  quality: QualityMetrics;
  inventory: InventoryValue;
  shipments: ShipmentAnalysis;
  timestamp: string;
}

export const analyticsApi = {
  getProductionDashboard: (days: number = 30) =>
    api.get<ProductionDashboardData>(`/core/analytics/production/?days=${days}`),

  getQualityDashboard: (days: number = 30) =>
    api.get<QualityDashboardData>(`/core/analytics/quality/?days=${days}`),

  getInventoryDashboard: (days: number = 90) =>
    api.get<InventoryDashboardData>(`/core/analytics/inventory/?days=${days}`),

  getCustomerDashboard: (days: number = 90, limit: number = 10) =>
    api.get<CustomerDashboardData>(`/core/analytics/customer/?days=${days}&limit=${limit}`),

  getOverviewDashboard: () =>
    api.get<OverviewDashboardData>('/core/analytics/overview/'),
};
