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
      </Route>
    </Routes>
  )
}

export default App
