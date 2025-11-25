import { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import {
  BarChart,
  Bar,
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
  PieChart,
  Pie,
  Cell,
} from 'recharts';
import { analyticsApi } from '../api/analytics';
import { Users, TrendingUp, Package, CheckCircle } from 'lucide-react';

const COLORS = ['#3b82f6', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6', '#ec4899'];

export default function CustomerAnalytics() {
  const [days, setDays] = useState(90);

  const { data, isLoading, error } = useQuery({
    queryKey: ['customer-analytics', days],
    queryFn: () => analyticsApi.getCustomerDashboard(days, 10),
  });

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-96">
        <div className="text-gray-500">Loading analytics...</div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex items-center justify-center h-96">
        <div className="text-red-500">Error loading analytics data</div>
      </div>
    );
  }

  const dashboardData = data?.data;

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Customer Analytics</h1>
          <p className="text-gray-500 mt-1">
            Monitor customer orders and shipment performance
          </p>
        </div>
        <select
          value={days}
          onChange={(e) => setDays(Number(e.target.value))}
          className="rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500"
        >
          <option value={30}>Last 30 days</option>
          <option value={90}>Last 90 days</option>
          <option value={180}>Last 180 days</option>
          <option value={365}>Last year</option>
        </select>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <div className="bg-white rounded-lg shadow p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500">Total Shipments</p>
              <p className="text-2xl font-bold text-gray-900">
                {dashboardData?.shipment_analysis.total_shipments || 0}
              </p>
            </div>
            <Package className="w-8 h-8 text-blue-500" />
          </div>
        </div>

        <div className="bg-white rounded-lg shadow p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500">Delivered</p>
              <p className="text-2xl font-bold text-green-600">
                {dashboardData?.shipment_analysis.delivered || 0}
              </p>
            </div>
            <CheckCircle className="w-8 h-8 text-green-500" />
          </div>
        </div>

        <div className="bg-white rounded-lg shadow p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500">Pending</p>
              <p className="text-2xl font-bold text-yellow-600">
                {dashboardData?.shipment_analysis.pending || 0}
              </p>
            </div>
            <Package className="w-8 h-8 text-yellow-500" />
          </div>
        </div>

        <div className="bg-white rounded-lg shadow p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500">On-Time Rate</p>
              <p className="text-2xl font-bold text-green-600">
                {dashboardData?.shipment_analysis.on_time_rate || 0}%
              </p>
            </div>
            <TrendingUp className="w-8 h-8 text-green-500" />
          </div>
        </div>
      </div>

      {/* Charts Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Top Customers */}
        <div className="bg-white rounded-lg shadow p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">
            Top Customers by Shipments
          </h2>
          <ResponsiveContainer width="100%" height={300}>
            <BarChart data={dashboardData?.top_customers || []} layout="vertical">
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis type="number" />
              <YAxis dataKey="customer__company_name" type="category" width={150} />
              <Tooltip />
              <Legend />
              <Bar dataKey="total_shipments" fill="#3b82f6" name="Shipments" />
            </BarChart>
          </ResponsiveContainer>
        </div>

        {/* Customer Distribution by State */}
        <div className="bg-white rounded-lg shadow p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">
            Customer Distribution by State
          </h2>
          <ResponsiveContainer width="100%" height={300}>
            <PieChart>
              <Pie
                data={dashboardData?.distribution || []}
                dataKey="count"
                nameKey="state"
                cx="50%"
                cy="50%"
                outerRadius={100}
                label
              >
                {(dashboardData?.distribution || []).map((_, index) => (
                  <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                ))}
              </Pie>
              <Tooltip />
              <Legend />
            </PieChart>
          </ResponsiveContainer>
        </div>

        {/* Order Trends */}
        <div className="bg-white rounded-lg shadow p-6 lg:col-span-2">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">
            Weekly Order Trends
          </h2>
          <ResponsiveContainer width="100%" height={300}>
            <LineChart data={dashboardData?.order_trends || []}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="week" />
              <YAxis />
              <Tooltip />
              <Legend />
              <Line
                type="monotone"
                dataKey="total_orders"
                stroke="#3b82f6"
                name="Orders"
              />
              <Line
                type="monotone"
                dataKey="total_quantity"
                stroke="#10b981"
                name="Quantity"
              />
            </LineChart>
          </ResponsiveContainer>
        </div>
      </div>
    </div>
  );
}
