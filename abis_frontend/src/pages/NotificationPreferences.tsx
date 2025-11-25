import React, { useState } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { notificationsApi, NotificationPreferences } from '../api/notifications';
import { Save, Mail, Bell, Send } from 'lucide-react';

const NotificationPreferencesPage: React.FC = () => {
  const queryClient = useQueryClient();
  const [isTesting, setIsTesting] = useState(false);

  const { data: preferences, isLoading } = useQuery({
    queryKey: ['notification-preferences'],
    queryFn: () => notificationsApi.getPreferences(),
  });

  const updateMutation = useMutation({
    mutationFn: (data: Partial<NotificationPreferences>) =>
      notificationsApi.updatePreferences(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['notification-preferences'] });
      alert('Preferences updated successfully!');
    },
  });

  const testNotificationMutation = useMutation({
    mutationFn: (type: string) => notificationsApi.sendTestNotification(type),
    onSuccess: () => {
      alert('Test notification sent! Check your email.');
      setIsTesting(false);
    },
    onError: () => {
      alert('Failed to send test notification. You may not have admin permissions.');
      setIsTesting(false);
    },
  });

  const [formData, setFormData] = useState<Partial<NotificationPreferences>>(
    preferences || {}
  );

  React.useEffect(() => {
    if (preferences) {
      setFormData(preferences);
    }
  }, [preferences]);

  const handleChange = (field: keyof NotificationPreferences, value: boolean) => {
    setFormData((prev) => ({ ...prev, [field]: value }));
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    updateMutation.mutate(formData);
  };

  const handleTestNotification = () => {
    setIsTesting(true);
    testNotificationMutation.mutate('JOB_STARTED');
  };

  if (isLoading) {
    return (
      <div className="flex justify-center items-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  const notificationTypes = [
    { key: 'job_started', label: 'Job Started', icon: '⚙️' },
    { key: 'job_completed', label: 'Job Completed', icon: '✅' },
    { key: 'job_on_hold', label: 'Job On Hold', icon: '⏸️' },
    { key: 'shipment_created', label: 'Shipment Created', icon: '📦' },
    { key: 'shipment_shipped', label: 'Shipment Shipped', icon: '🚚' },
    { key: 'qa_failed', label: 'QA Test Failed', icon: '❌' },
    { key: 'qa_passed', label: 'QA Test Passed', icon: '✓' },
    { key: 'inventory_low', label: 'Low Inventory', icon: '⚠️' },
    { key: 'inventory_received', label: 'Inventory Received', icon: '📥' },
    { key: 'customer_order', label: 'Customer Order', icon: '🛒' },
    { key: 'maintenance_due', label: 'Maintenance Due', icon: '🔧' },
    { key: 'downtime_alert', label: 'Downtime Alert', icon: '🚨' },
  ];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Notification Preferences</h1>
          <p className="text-gray-600 mt-1">
            Manage your email and in-app notification settings
          </p>
        </div>
        <button
          onClick={handleTestNotification}
          disabled={isTesting}
          className="flex items-center gap-2 px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 disabled:bg-gray-300 transition"
        >
          <Send className="w-4 h-4" />
          {isTesting ? 'Sending...' : 'Send Test Email'}
        </button>
      </div>

      <form onSubmit={handleSubmit} className="space-y-6">
        {/* Master Switches */}
        <div className="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
          <h2 className="text-xl font-semibold text-gray-900 mb-4">Master Settings</h2>
          <div className="space-y-4">
            <label className="flex items-center justify-between p-4 bg-blue-50 rounded-lg">
              <div className="flex items-center gap-3">
                <Mail className="w-5 h-5 text-blue-600" />
                <div>
                  <span className="font-medium text-gray-900">Email Notifications</span>
                  <p className="text-sm text-gray-600">
                    Receive notifications via email
                  </p>
                </div>
              </div>
              <input
                type="checkbox"
                checked={formData.email_enabled ?? true}
                onChange={(e) => handleChange('email_enabled', e.target.checked)}
                className="w-5 h-5 text-blue-600 rounded focus:ring-2 focus:ring-blue-500"
              />
            </label>

            <label className="flex items-center justify-between p-4 bg-green-50 rounded-lg">
              <div className="flex items-center gap-3">
                <Bell className="w-5 h-5 text-green-600" />
                <div>
                  <span className="font-medium text-gray-900">In-App Notifications</span>
                  <p className="text-sm text-gray-600">
                    Receive notifications in the application
                  </p>
                </div>
              </div>
              <input
                type="checkbox"
                checked={formData.app_enabled ?? true}
                onChange={(e) => handleChange('app_enabled', e.target.checked)}
                className="w-5 h-5 text-green-600 rounded focus:ring-2 focus:ring-green-500"
              />
            </label>
          </div>
        </div>

        {/* Email Preferences */}
        <div className="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
          <div className="flex items-center gap-2 mb-4">
            <Mail className="w-5 h-5 text-blue-600" />
            <h2 className="text-xl font-semibold text-gray-900">Email Preferences</h2>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {notificationTypes.map(({ key, label, icon }) => (
              <label
                key={key}
                className="flex items-center justify-between p-3 border border-gray-200 rounded-lg hover:bg-gray-50 transition"
              >
                <div className="flex items-center gap-2">
                  <span className="text-xl">{icon}</span>
                  <span className="text-gray-900">{label}</span>
                </div>
                <input
                  type="checkbox"
                  checked={formData[`email_${key}` as keyof NotificationPreferences] ?? false}
                  onChange={(e) =>
                    handleChange(`email_${key}` as keyof NotificationPreferences, e.target.checked)
                  }
                  disabled={!formData.email_enabled}
                  className="w-4 h-4 text-blue-600 rounded focus:ring-2 focus:ring-blue-500 disabled:opacity-50"
                />
              </label>
            ))}
          </div>
        </div>

        {/* In-App Preferences */}
        <div className="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
          <div className="flex items-center gap-2 mb-4">
            <Bell className="w-5 h-5 text-green-600" />
            <h2 className="text-xl font-semibold text-gray-900">In-App Preferences</h2>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {notificationTypes.map(({ key, label, icon }) => (
              <label
                key={key}
                className="flex items-center justify-between p-3 border border-gray-200 rounded-lg hover:bg-gray-50 transition"
              >
                <div className="flex items-center gap-2">
                  <span className="text-xl">{icon}</span>
                  <span className="text-gray-900">{label}</span>
                </div>
                <input
                  type="checkbox"
                  checked={formData[`app_${key}` as keyof NotificationPreferences] ?? false}
                  onChange={(e) =>
                    handleChange(`app_${key}` as keyof NotificationPreferences, e.target.checked)
                  }
                  disabled={!formData.app_enabled}
                  className="w-4 h-4 text-green-600 rounded focus:ring-2 focus:ring-green-500 disabled:opacity-50"
                />
              </label>
            ))}
          </div>
        </div>

        {/* Digest Settings */}
        <div className="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
          <h2 className="text-xl font-semibold text-gray-900 mb-4">Digest Settings</h2>
          <div className="space-y-3">
            <label className="flex items-center gap-3">
              <input
                type="checkbox"
                checked={formData.daily_digest ?? false}
                onChange={(e) => handleChange('daily_digest', e.target.checked)}
                className="w-4 h-4 text-blue-600 rounded focus:ring-2 focus:ring-blue-500"
              />
              <div>
                <span className="font-medium text-gray-900">Daily Digest</span>
                <p className="text-sm text-gray-600">
                  Receive a daily summary of all notifications
                </p>
              </div>
            </label>

            <label className="flex items-center gap-3">
              <input
                type="checkbox"
                checked={formData.weekly_digest ?? false}
                onChange={(e) => handleChange('weekly_digest', e.target.checked)}
                className="w-4 h-4 text-blue-600 rounded focus:ring-2 focus:ring-blue-500"
              />
              <div>
                <span className="font-medium text-gray-900">Weekly Digest</span>
                <p className="text-sm text-gray-600">
                  Receive a weekly summary of all notifications
                </p>
              </div>
            </label>
          </div>
        </div>

        {/* Save Button */}
        <div className="flex justify-end">
          <button
            type="submit"
            disabled={updateMutation.isPending}
            className="flex items-center gap-2 px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:bg-gray-300 transition font-medium"
          >
            <Save className="w-5 h-5" />
            {updateMutation.isPending ? 'Saving...' : 'Save Preferences'}
          </button>
        </div>
      </form>
    </div>
  );
};

export default NotificationPreferencesPage;
