import { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import {
  BarChart,
  Bar,
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
import { Package, TrendingUp, Clock, DollarSign } from 'lucide-react';

const COLORS = ['#3b82f6', '#10b981', '#f59e0b', '#ef4444'];

export default function InventoryAnalytics() {
  const [days, setDays] = useState(90);

  const { data, isLoading, error } = useQuery({
    queryKey: ['inventory-analytics', days],
    queryFn: () => analyticsApi.getInventoryDashboard(days),
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

  // Transform aging data for pie chart
  const agingData = dashboardData?.aging
    ? [
        { name: '0-30 days', value: dashboardData.aging['0-30_days'] },
        { name: '31-60 days', value: dashboardData.aging['31-60_days'] },
        { name: '61-90 days', value: dashboardData.aging['61-90_days'] },
        { name: '90+ days', value: dashboardData.aging['90plus_days'] },
      ]
    : [];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Inventory Analytics</h1>
          <p className="text-gray-500 mt-1">
            Monitor inventory levels and turnover metrics
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
        </select>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <div className="bg-white rounded-lg shadow p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500">Total Coils</p>
              <p className="text-2xl font-bold text-gray-900">
                {dashboardData?.value.total_coils || 0}
              </p>
            </div>
            <Package className="w-8 h-8 text-blue-500" />
          </div>
        </div>

        <div className="bg-white rounded-lg shadow p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500">Total Weight (lbs)</p>
              <p className="text-2xl font-bold text-gray-900">
                {dashboardData?.value.total_weight?.toLocaleString() || 0}
              </p>
            </div>
            <TrendingUp className="w-8 h-8 text-green-500" />
          </div>
        </div>

        <div className="bg-white rounded-lg shadow p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500">Received</p>
              <p className="text-2xl font-bold text-blue-600">
                {dashboardData?.turnover.coils_received || 0}
              </p>
            </div>
            <Package className="w-8 h-8 text-blue-500" />
          </div>
        </div>

        <div className="bg-white rounded-lg shadow p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500">Shipments</p>
              <p className="text-2xl font-bold text-green-600">
                {dashboardData?.turnover.total_shipments || 0}
              </p>
            </div>
            <TrendingUp className="w-8 h-8 text-green-500" />
          </div>
        </div>
      </div>

      {/* Charts Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Inventory by Material */}
        <div className="bg-white rounded-lg shadow p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">
            Inventory by Alloy
          </h2>
          <ResponsiveContainer width="100%" height={300}>
            <BarChart data={dashboardData?.levels || []}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="material__alloy__code" />
              <YAxis />
              <Tooltip />
              <Legend />
              <Bar dataKey="total_coils" fill="#3b82f6" name="Coils" />
            </BarChart>
          </ResponsiveContainer>
        </div>

        {/* Aging Analysis */}
        <div className="bg-white rounded-lg shadow p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">
            Inventory Age Distribution
          </h2>
          <ResponsiveContainer width="100%" height={300}>
            <PieChart>
              <Pie
                data={agingData}
                dataKey="value"
                nameKey="name"
                cx="50%"
                cy="50%"
                outerRadius={100}
                label
              >
                {agingData.map((_, index) => (
                  <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                ))}
              </Pie>
              <Tooltip />
              <Legend />
            </PieChart>
          </ResponsiveContainer>
        </div>

        {/* Weight by Material */}
        <div className="bg-white rounded-lg shadow p-6 lg:col-span-2">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">
            Weight Distribution by Alloy (lbs)
          </h2>
          <ResponsiveContainer width="100%" height={300}>
            <BarChart data={dashboardData?.levels || []}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="material__alloy__code" />
              <YAxis />
              <Tooltip />
              <Legend />
              <Bar dataKey="total_weight" fill="#10b981" name="Weight (lbs)" />
            </BarChart>
          </ResponsiveContainer>
        </div>
      </div>
    </div>
  );
}
