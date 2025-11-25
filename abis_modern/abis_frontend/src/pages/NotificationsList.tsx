import React, { useState } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { notificationsApi, Notification } from '../api/notifications';
import { Bell, Check, CheckCheck, Filter, Mail, MailOpen } from 'lucide-react';

const NotificationsList: React.FC = () => {
  const queryClient = useQueryClient();
  const [statusFilter, setStatusFilter] = useState<string>('');
  const [typeFilter, setTypeFilter] = useState<string>('');

  const { data: notifications, isLoading } = useQuery({
    queryKey: ['notifications', statusFilter, typeFilter],
    queryFn: () => notificationsApi.getNotifications({
      status: statusFilter || undefined,
      type: typeFilter || undefined,
    }),
  });

  const { data: summary } = useQuery({
    queryKey: ['notification-summary'],
    queryFn: () => notificationsApi.getSummary(),
  });

  const markAsReadMutation = useMutation({
    mutationFn: (id: number) => notificationsApi.markAsRead(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['notifications'] });
      queryClient.invalidateQueries({ queryKey: ['notification-summary'] });
    },
  });

  const markAllAsReadMutation = useMutation({
    mutationFn: () => notificationsApi.markAllAsRead(),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['notifications'] });
      queryClient.invalidateQueries({ queryKey: ['notification-summary'] });
    },
  });

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'SENT':
        return 'bg-blue-100 text-blue-800';
      case 'READ':
        return 'bg-gray-100 text-gray-800';
      case 'FAILED':
        return 'bg-red-100 text-red-800';
      default:
        return 'bg-yellow-100 text-yellow-800';
    }
  };

  const getNotificationIcon = (type: string) => {
    if (type.includes('QA')) return '🔬';
    if (type.includes('JOB')) return '⚙️';
    if (type.includes('SHIPMENT')) return '📦';
    if (type.includes('INVENTORY')) return '📊';
    return '📧';
  };

  if (isLoading) {
    return (
      <div className="flex justify-center items-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Notifications</h1>
          {summary && (
            <p className="text-gray-600 mt-1">
              {summary.unread} unread • {summary.total} total
            </p>
          )}
        </div>
        <button
          onClick={() => markAllAsReadMutation.mutate()}
          disabled={!summary?.unread}
          className="flex items-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:bg-gray-300 disabled:cursor-not-allowed transition"
        >
          <CheckCheck className="w-4 h-4" />
          Mark All as Read
        </button>
      </div>

      {/* Summary Cards */}
      {summary && (
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
            <div className="flex items-center gap-4">
              <div className="p-3 bg-blue-100 rounded-lg">
                <Bell className="w-6 h-6 text-blue-600" />
              </div>
              <div>
                <p className="text-sm text-gray-600">Total Notifications</p>
                <p className="text-2xl font-bold text-gray-900">{summary.total}</p>
              </div>
            </div>
          </div>

          <div className="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
            <div className="flex items-center gap-4">
              <div className="p-3 bg-yellow-100 rounded-lg">
                <Mail className="w-6 h-6 text-yellow-600" />
              </div>
              <div>
                <p className="text-sm text-gray-600">Unread</p>
                <p className="text-2xl font-bold text-gray-900">{summary.unread}</p>
              </div>
            </div>
          </div>

          <div className="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
            <div className="flex items-center gap-4">
              <div className="p-3 bg-green-100 rounded-lg">
                <MailOpen className="w-6 h-6 text-green-600" />
              </div>
              <div>
                <p className="text-sm text-gray-600">Recent (7 days)</p>
                <p className="text-2xl font-bold text-gray-900">{summary.recent}</p>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Filters */}
      <div className="bg-white p-4 rounded-lg shadow-sm border border-gray-200">
        <div className="flex items-center gap-4">
          <Filter className="w-5 h-5 text-gray-500" />
          <div className="flex gap-4 flex-1">
            <select
              value={statusFilter}
              onChange={(e) => setStatusFilter(e.target.value)}
              className="px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              <option value="">All Status</option>
              <option value="SENT">Unread</option>
              <option value="READ">Read</option>
              <option value="FAILED">Failed</option>
            </select>

            <select
              value={typeFilter}
              onChange={(e) => setTypeFilter(e.target.value)}
              className="px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              <option value="">All Types</option>
              <option value="JOB_STARTED">Job Started</option>
              <option value="JOB_COMPLETED">Job Completed</option>
              <option value="SHIPMENT_CREATED">Shipment Created</option>
              <option value="SHIPMENT_SHIPPED">Shipment Shipped</option>
              <option value="QA_FAILED">QA Failed</option>
              <option value="QA_PASSED">QA Passed</option>
              <option value="INVENTORY_LOW">Inventory Low</option>
            </select>
          </div>
        </div>
      </div>

      {/* Notifications List */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 divide-y divide-gray-200">
        {notifications && notifications.length > 0 ? (
          notifications.map((notification) => (
            <div
              key={notification.id}
              className={`p-4 hover:bg-gray-50 transition ${
                notification.status === 'SENT' ? 'bg-blue-50' : ''
              }`}
            >
              <div className="flex items-start gap-4">
                <div className="text-2xl">{getNotificationIcon(notification.notification_type)}</div>
                <div className="flex-1">
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <h3 className="font-semibold text-gray-900">
                        {notification.subject}
                      </h3>
                      <p className="text-sm text-gray-600 mt-1">
                        {notification.message}
                      </p>
                      <div className="flex items-center gap-3 mt-2 text-xs text-gray-500">
                        <span>{notification.notification_type_display}</span>
                        <span>•</span>
                        <span>{new Date(notification.created_at).toLocaleString()}</span>
                        {notification.job_id && (
                          <>
                            <span>•</span>
                            <span>Job: {notification.job_id}</span>
                          </>
                        )}
                      </div>
                    </div>
                    <div className="flex items-center gap-2 ml-4">
                      <span className={`px-2 py-1 rounded text-xs font-medium ${getStatusColor(notification.status)}`}>
                        {notification.status_display}
                      </span>
                      {notification.status === 'SENT' && (
                        <button
                          onClick={() => markAsReadMutation.mutate(notification.id)}
                          className="p-1 hover:bg-gray-200 rounded transition"
                          title="Mark as read"
                        >
                          <Check className="w-4 h-4 text-gray-600" />
                        </button>
                      )}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          ))
        ) : (
          <div className="p-8 text-center text-gray-500">
            <Bell className="w-12 h-12 mx-auto mb-3 text-gray-400" />
            <p>No notifications found</p>
          </div>
        )}
      </div>
    </div>
  );
};

export default NotificationsList;
