import { Outlet, Link, useNavigate, useLocation } from 'react-router-dom'
import { useAuthStore } from '@/stores/authStore'
import {
  Package,
  Factory,
  Truck,
  Users,
  LayoutDashboard,
  LogOut,
  Menu,
  X,
  FileText,
  BarChart3,
  ChevronDown,
  ChevronRight,
  Bell,
} from 'lucide-react'
import { useState } from 'react'

const navigation = [
  { name: 'Dashboard', href: '/', icon: LayoutDashboard },
  { name: 'Inventory', href: '/inventory/coils', icon: Package },
  { name: 'Production', href: '/production/jobs', icon: Factory },
  { name: 'Shipping', href: '/shipping/shipments', icon: Truck },
  { name: 'Customers', href: '/customers', icon: Users },
  { 
    name: 'Analytics', 
    icon: BarChart3,
    children: [
      { name: 'Production', href: '/analytics/production' },
      { name: 'Quality', href: '/analytics/quality' },
      { name: 'Inventory', href: '/analytics/inventory' },
      { name: 'Customer', href: '/analytics/customer' },
    ]
  },
  { 
    name: 'Notifications', 
    icon: Bell,
    children: [
      { name: 'All Notifications', href: '/notifications' },
      { name: 'Preferences', href: '/notifications/preferences' },
    ]
  },
  { name: 'Reports', href: '/reports', icon: FileText },
]

export default function Layout() {
  const [sidebarOpen, setSidebarOpen] = useState(false)
  const [expandedMenus, setExpandedMenus] = useState<string[]>([])
  const { user, logout } = useAuthStore()
  const navigate = useNavigate()
  const location = useLocation()

  const handleLogout = () => {
    logout()
    navigate('/login')
  }

  const toggleMenu = (menuName: string) => {
    setExpandedMenus(prev =>
      prev.includes(menuName)
        ? prev.filter(name => name !== menuName)
        : [...prev, menuName]
    )
  }

  const renderNavItem = (item: typeof navigation[0], isMobile: boolean = false) => {
    const Icon = item.icon
    
    if ('children' in item && item.children) {
      const isActive = item.children.some(child => location.pathname === child.href)
      const isOpen = expandedMenus.includes(item.name) || isActive
      
      return (
        <div key={item.name}>
          <button
            onClick={() => toggleMenu(item.name)}
            className={`w-full flex items-center justify-between px-4 py-3 text-sm font-medium rounded-md ${
              isActive
                ? 'bg-primary-100 text-primary-700'
                : 'text-gray-700 hover:bg-gray-100'
            }`}
          >
            <div className="flex items-center">
              <Icon className="mr-3 h-5 w-5" />
              {item.name}
            </div>
            {isOpen ? <ChevronDown className="h-4 w-4" /> : <ChevronRight className="h-4 w-4" />}
          </button>
          {isOpen && (
            <div className="ml-4 mt-1 space-y-1">
              {item.children.map(child => (
                <Link
                  key={child.name}
                  to={child.href}
                  className={`flex items-center px-4 py-2 text-sm rounded-md ${
                    location.pathname === child.href
                      ? 'bg-primary-50 text-primary-700'
                      : 'text-gray-600 hover:bg-gray-50'
                  }`}
                  onClick={() => isMobile && setSidebarOpen(false)}
                >
                  {child.name}
                </Link>
              ))}
            </div>
          )}
        </div>
      )
    }

    const isActive = location.pathname === item.href ||
                    (item.href !== '/' && location.pathname.startsWith(item.href + '/'))
    
    return (
      <Link
        key={item.name}
        to={item.href}
        className={`flex items-center px-4 py-3 text-sm font-medium rounded-md ${
          isActive
            ? 'bg-primary-100 text-primary-700'
            : 'text-gray-700 hover:bg-gray-100'
        }`}
        onClick={() => isMobile && setSidebarOpen(false)}
      >
        <Icon className="mr-3 h-5 w-5" />
        {item.name}
      </Link>
    )
  }

  return (
    <div className="min-h-screen bg-gray-100">
      {/* Mobile sidebar */}
      <div
        className={`fixed inset-0 z-40 lg:hidden ${sidebarOpen ? 'block' : 'hidden'}`}
        onClick={() => setSidebarOpen(false)}
      >
        <div className="fixed inset-0 bg-gray-600 bg-opacity-75" />
        <div className="fixed inset-y-0 left-0 flex w-64 flex-col bg-white">
          <div className="flex h-16 items-center justify-between px-4 border-b">
            <h1 className="text-xl font-bold text-primary-600">ABIS Modern</h1>
            <button onClick={() => setSidebarOpen(false)}>
              <X className="h-6 w-6" />
            </button>
          </div>
          <nav className="flex-1 space-y-1 px-2 py-4">
            {navigation.map(item => renderNavItem(item, true))}
          </nav>
        </div>
      </div>

      {/* Desktop sidebar */}
      <div className="hidden lg:fixed lg:inset-y-0 lg:flex lg:w-64 lg:flex-col">
        <div className="flex flex-col flex-grow bg-white border-r">
          <div className="flex h-16 items-center px-6 border-b">
            <h1 className="text-xl font-bold text-primary-600">ABIS Modern</h1>
          </div>
          <nav className="flex-1 space-y-1 px-3 py-4">
            {navigation.map(item => renderNavItem(item))}
          </nav>
        </div>
      </div>

      {/* Main content */}
      <div className="lg:pl-64">
        {/* Top bar */}
        <div className="sticky top-0 z-10 flex h-16 bg-white border-b shadow-sm">
          <button
            className="px-4 text-gray-500 lg:hidden"
            onClick={() => setSidebarOpen(true)}
          >
            <Menu className="h-6 w-6" />
          </button>
          <div className="flex flex-1 justify-end items-center px-4 sm:px-6 lg:px-8">
            <div className="flex items-center gap-4">
              <span className="text-sm text-gray-700">
                {user?.first_name || user?.username}
              </span>
              <button
                onClick={handleLogout}
                className="flex items-center gap-2 px-3 py-2 text-sm text-gray-700 hover:bg-gray-100 rounded-md"
              >
                <LogOut className="h-4 w-4" />
                Logout
              </button>
            </div>
          </div>
        </div>

        {/* Page content */}
        <main className="p-6">
          <Outlet />
        </main>
      </div>
    </div>
  )
}
