import api from '../lib/api';

export interface Notification {
  id: number;
  user: number;
  user_username: string;
  notification_type: string;
  notification_type_display: string;
  subject: string;
  message: string;
  html_message?: string;
  job_id?: string;
  shipment_id?: string;
  coil_id?: string;
  customer_id?: string;
  status: string;
  status_display: string;
  sent_at?: string;
  read_at?: string;
  error_message?: string;
  created_at: string;
  updated_at: string;
}

export interface NotificationPreferences {
  id: number;
  user: number;
  email_enabled: boolean;
  email_job_started: boolean;
  email_job_completed: boolean;
  email_job_on_hold: boolean;
  email_shipment_created: boolean;
  email_shipment_shipped: boolean;
  email_qa_failed: boolean;
  email_qa_passed: boolean;
  email_inventory_low: boolean;
  email_inventory_received: boolean;
  email_customer_order: boolean;
  email_maintenance_due: boolean;
  email_downtime_alert: boolean;
  app_enabled: boolean;
  app_job_started: boolean;
  app_job_completed: boolean;
  app_job_on_hold: boolean;
  app_shipment_created: boolean;
  app_shipment_shipped: boolean;
  app_qa_failed: boolean;
  app_qa_passed: boolean;
  app_inventory_low: boolean;
  app_inventory_received: boolean;
  app_customer_order: boolean;
  app_maintenance_due: boolean;
  app_downtime_alert: boolean;
  daily_digest: boolean;
  weekly_digest: boolean;
  created_at: string;
  updated_at: string;
}

export interface NotificationSummary {
  total: number;
  unread: number;
  recent: number;
  by_type: Array<{ notification_type: string; count: number }>;
}

export const notificationsApi = {
  // Get notifications list
  getNotifications: (params?: {
    status?: string;
    type?: string;
    days?: number;
  }) => api.get<Notification[]>('/notifications/notifications/', { params }),

  // Mark notification as read
  markAsRead: (id: number) =>
    api.post(`/notifications/notifications/${id}/mark_read/`),

  // Mark all notifications as read
  markAllAsRead: () =>
    api.post('/notifications/notifications/mark_all_read/'),

  // Get unread count
  getUnreadCount: () =>
    api.get<{ unread_count: number }>('/notifications/notifications/unread_count/'),

  // Get notification summary
  getSummary: () =>
    api.get<NotificationSummary>('/notifications/notifications/summary/'),

  // Get user preferences
  getPreferences: () =>
    api.get<NotificationPreferences>('/notifications/preferences/my_preferences/'),

  // Update user preferences
  updatePreferences: (data: Partial<NotificationPreferences>) =>
    api.post<NotificationPreferences>('/notifications/preferences/update_preferences/', data),

  // Send test notification (admin only)
  sendTestNotification: (notification_type: string) =>
    api.post('/notifications/test/', { notification_type }),
};
