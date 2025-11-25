import { Routes, Route, Navigate } from 'react-router-dom'
import { useAuthStore } from './stores/authStore'
import Layout from './components/Layout'
import Login from './pages/Login'
import Dashboard from './pages/Dashboard'
import CoilList from './pages/inventory/CoilList'
import CoilDetail from './pages/inventory/CoilDetail'
import SkidList from './pages/inventory/SkidList'
import JobList from './pages/production/JobList'
import JobDetail from './pages/production/JobDetail'
import ShipmentList from './pages/shipping/ShipmentList'
import CustomerList from './pages/customers/CustomerList'
import Reports from './pages/reports/Reports'
import ProductionAnalytics from './pages/ProductionAnalytics'
import QualityAnalytics from './pages/QualityAnalytics'
import InventoryAnalytics from './pages/InventoryAnalytics'
import CustomerAnalytics from './pages/CustomerAnalytics'
import NotificationsList from './pages/NotificationsList'
import NotificationPreferences from './pages/NotificationPreferences'

function PrivateRoute({ children }: { children: React.ReactNode }) {
  const isAuthenticated = useAuthStore(state => state.isAuthenticated)
  return isAuthenticated ? <>{children}</> : <Navigate to="/login" />
}

function App() {
  return (
    <Routes>
      <Route path="/login" element={<Login />} />
      <Route
        path="/"
        element={
          <PrivateRoute>
            <Layout />
          </PrivateRoute>
        }
      >
        <Route index element={<Dashboard />} />
        
        {/* Inventory Routes */}
        <Route path="inventory/coils" element={<CoilList />} />
        <Route path="inventory/coils/:id" element={<CoilDetail />} />
        <Route path="inventory/skids" element={<SkidList />} />
        
        {/* Production Routes */}
        <Route path="production/jobs" element={<JobList />} />
        <Route path="production/jobs/:id" element={<JobDetail />} />
        
        {/* Shipping Routes */}
        <Route path="shipping/shipments" element={<ShipmentList />} />
        
        {/* Customer Routes */}
        <Route path="customers" element={<CustomerList />} />
        
        {/* Reports Routes */}
        <Route path="reports" element={<Reports />} />
        
        {/* Analytics Routes */}
        <Route path="analytics/production" element={<ProductionAnalytics />} />
        <Route path="analytics/quality" element={<QualityAnalytics />} />
        <Route path="analytics/inventory" element={<InventoryAnalytics />} />
        <Route path="analytics/customer" element={<CustomerAnalytics />} />
        
        {/* Notification Routes */}
        <Route path="notifications" element={<NotificationsList />} />
        <Route path="notifications/preferences" element={<NotificationPreferences />} />
      </Route>
    </Routes>
  )
}

export default App
