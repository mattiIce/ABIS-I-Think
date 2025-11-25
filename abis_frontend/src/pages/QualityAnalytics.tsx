import { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import {
  LineChart,
  Line,
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
import { CheckCircle, XCircle, AlertCircle, TrendingUp } from 'lucide-react';

const COLORS = ['#3b82f6', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6', '#ec4899'];

export default function QualityAnalytics() {
  const [days, setDays] = useState(30);

  const { data, isLoading, error } = useQuery({
    queryKey: ['quality-analytics', days],
    queryFn: () => analyticsApi.getQualityDashboard(days),
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
          <h1 className="text-3xl font-bold text-gray-900">Quality Analytics</h1>
          <p className="text-gray-500 mt-1">
            Monitor quality control metrics and defect trends
          </p>
        </div>
        <select
          value={days}
          onChange={(e) => setDays(Number(e.target.value))}
          className="rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500"
        >
          <option value={7}>Last 7 days</option>
          <option value={30}>Last 30 days</option>
          <option value={90}>Last 90 days</option>
        </select>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <div className="bg-white rounded-lg shadow p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500">Total Tests</p>
              <p className="text-2xl font-bold text-gray-900">
                {dashboardData?.metrics.total_tests || 0}
              </p>
            </div>
            <AlertCircle className="w-8 h-8 text-blue-500" />
          </div>
        </div>

        <div className="bg-white rounded-lg shadow p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500">Passed Tests</p>
              <p className="text-2xl font-bold text-green-600">
                {dashboardData?.metrics.passed_tests || 0}
              </p>
            </div>
            <CheckCircle className="w-8 h-8 text-green-500" />
          </div>
        </div>

        <div className="bg-white rounded-lg shadow p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500">Failed Tests</p>
              <p className="text-2xl font-bold text-red-600">
                {dashboardData?.metrics.failed_tests || 0}
              </p>
            </div>
            <XCircle className="w-8 h-8 text-red-500" />
          </div>
        </div>

        <div className="bg-white rounded-lg shadow p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500">Pass Rate</p>
              <p className="text-2xl font-bold text-green-600">
                {dashboardData?.metrics.pass_rate || 0}%
              </p>
            </div>
            <TrendingUp className="w-8 h-8 text-green-500" />
          </div>
        </div>
      </div>

      {/* Charts Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Quality Trends */}
        <div className="bg-white rounded-lg shadow p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">
            Quality Test Trends
          </h2>
          <ResponsiveContainer width="100%" height={300}>
            <LineChart data={dashboardData?.trends || []}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="date" />
              <YAxis />
              <Tooltip />
              <Legend />
              <Line
                type="monotone"
                dataKey="passed_tests"
                stroke="#10b981"
                name="Passed"
              />
              <Line
                type="monotone"
                dataKey="failed_tests"
                stroke="#ef4444"
                name="Failed"
              />
              <Line
                type="monotone"
                dataKey="total_tests"
                stroke="#3b82f6"
                name="Total"
              />
            </LineChart>
          </ResponsiveContainer>
        </div>

        {/* Defect Distribution */}
        <div className="bg-white rounded-lg shadow p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">
            Top Defect Types
          </h2>
          <ResponsiveContainer width="100%" height={300}>
            <PieChart>
              <Pie
                data={dashboardData?.defect_distribution || []}
                dataKey="count"
                nameKey="defect_type__name"
                cx="50%"
                cy="50%"
                outerRadius={100}
                label
              >
                {(dashboardData?.defect_distribution || []).map((_, index) => (
                  <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                ))}
              </Pie>
              <Tooltip />
              <Legend />
            </PieChart>
          </ResponsiveContainer>
        </div>

        {/* QA by Inspector */}
        <div className="bg-white rounded-lg shadow p-6 lg:col-span-2">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">
            Tests by Inspector
          </h2>
          <ResponsiveContainer width="100%" height={300}>
            <BarChart data={dashboardData?.by_inspector || []}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="inspector__username" />
              <YAxis />
              <Tooltip />
              <Legend />
              <Bar dataKey="passed_tests" fill="#10b981" name="Passed" stackId="a" />
              <Bar dataKey="failed_tests" fill="#ef4444" name="Failed" stackId="a" />
            </BarChart>
          </ResponsiveContainer>
        </div>
      </div>
    </div>
  );
}
