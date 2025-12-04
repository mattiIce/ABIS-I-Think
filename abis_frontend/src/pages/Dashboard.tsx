import { useQuery } from '@tanstack/react-query'
import api from '@/lib/api'
import { Package, Factory, Truck, TrendingUp } from 'lucide-react'

interface Stats {
  total_coils: number
  coils_in_qa: number
  active_jobs: number
  open_shipments: number
}

export default function Dashboard() {
  const { data: stats } = useQuery<Stats>({
    queryKey: ['dashboard-stats'],
    queryFn: async () => {
      const [coils, jobs, shipments] = await Promise.all([
        api.get('/inventory/coils/statistics/'),
        api.get('/production/jobs/?status=IN_PROGRESS'),
        api.get('/shipping/shipments/?status=OPEN'),
      ])
      return {
        total_coils: coils.data.total_count || 0,
        coils_in_qa: coils.data.qa_pending || 0,
        active_jobs: jobs.data.count || 0,
        open_shipments: shipments.data.count || 0,
      }
    },
  })

  const statCards = [
    {
      name: 'Total Coils',
      value: stats?.total_coils || 0,
      icon: Package,
      color: 'bg-blue-500',
    },
    {
      name: 'QA Pending',
      value: stats?.coils_in_qa || 0,
      icon: TrendingUp,
      color: 'bg-yellow-500',
    },
    {
      name: 'Active Jobs',
      value: stats?.active_jobs || 0,
      icon: Factory,
      color: 'bg-green-500',
    },
    {
      name: 'Open Shipments',
      value: stats?.open_shipments || 0,
      icon: Truck,
      color: 'bg-purple-500',
    },
  ]

  return (
    <div>
      <h1 className="text-3xl font-bold text-gray-900 mb-6">Dashboard</h1>

      <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4">
        {statCards.map(stat => {
          const Icon = stat.icon
          return (
            <div key={stat.name} className="card p-6">
              <div className="flex items-center">
                <div className={`${stat.color} p-3 rounded-lg`}>
                  <Icon className="h-6 w-6 text-white" />
                </div>
                <div className="ml-4">
                  <p className="text-sm font-medium text-gray-600">{stat.name}</p>
                  <p className="text-2xl font-semibold text-gray-900">{stat.value}</p>
                </div>
              </div>
            </div>
          )
        })}
      </div>

      <div className="mt-8 grid grid-cols-1 gap-6 lg:grid-cols-2">
        <div className="card p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Recent Activity</h2>
          <p className="text-gray-600">Activity feed will appear here...</p>
        </div>

        <div className="card p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Quick Actions</h2>
          <div className="space-y-2">
            <a href="/inventory/coils" className="block p-3 hover:bg-gray-50 rounded-md">
              Receive New Coil
            </a>
            <a href="/production/jobs" className="block p-3 hover:bg-gray-50 rounded-md">
              Create Job
            </a>
            <a href="/shipping/shipments" className="block p-3 hover:bg-gray-50 rounded-md">
              New Shipment
            </a>
          </div>
        </div>
      </div>
    </div>
  )
}
