import { useQuery } from '@tanstack/react-query'
import { Link } from 'react-router-dom'
import api from '@/lib/api'
import { Package, FileText, MapPin } from 'lucide-react'
import { format } from 'date-fns'
import toast from 'react-hot-toast'
import { useState } from 'react'

interface Skid {
  id: number
  skid_number: string
  shipment?: {
    id: number
    bol_number: string
    destination_address: string
  }
  gross_weight: number
  net_weight: number
  piece_count: number
  status: string
  created_at: string
  created_by: string
}

interface PaginatedResponse<T> {
  count: number
  next: string | null
  previous: string | null
  results: T[]
}

export default function SkidList() {
  const [page, setPage] = useState(1)
  const [search, setSearch] = useState('')
  const [statusFilter, setStatusFilter] = useState('')

  const { data, isLoading } = useQuery<PaginatedResponse<Skid>>({
    queryKey: ['skids', page, search, statusFilter],
    queryFn: async () => {
      const params = new URLSearchParams()
      params.append('page', page.toString())
      if (search) params.append('search', search)
      if (statusFilter) params.append('status', statusFilter)
      params.append('ordering', '-created_at')

      const response = await api.get(`/shipping/skids/?${params}`)
      return response.data
    },
  })

  const statusColors: Record<string, string> = {
    OPEN: 'bg-blue-100 text-blue-800',
    ASSIGNED: 'bg-yellow-100 text-yellow-800',
    SHIPPED: 'bg-green-100 text-green-800',
  }

  const downloadSkidLabel = async (skidId: number) => {
    try {
      const response = await api.get(`/reports/skid-label/${skidId}/`, {
        responseType: 'blob',
      })
      const blob = new Blob([response.data], { type: 'application/pdf' })
      const url = window.URL.createObjectURL(blob)
      const link = document.createElement('a')
      link.href = url
      link.download = `skid_label_${skidId}.pdf`
      link.click()
      window.URL.revokeObjectURL(url)
      toast.success('Skid label downloaded')
    } catch (error: any) {
      toast.error('Failed to download skid label')
    }
  }

  if (isLoading) {
    return <div className="p-8 text-center text-gray-500">Loading...</div>
  }

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Skids</h1>
          <p className="text-gray-600 mt-1">Manage shipping skids and labels</p>
        </div>
      </div>

      <div className="card p-6 mb-6">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Search Skid Number
            </label>
            <input
              type="text"
              placeholder="Search skids..."
              className="input"
              value={search}
              onChange={(e) => {
                setSearch(e.target.value)
                setPage(1)
              }}
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Status
            </label>
            <select
              className="input"
              value={statusFilter}
              onChange={(e) => {
                setStatusFilter(e.target.value)
                setPage(1)
              }}
            >
              <option value="">All Statuses</option>
              <option value="OPEN">Open</option>
              <option value="ASSIGNED">Assigned</option>
              <option value="SHIPPED">Shipped</option>
            </select>
          </div>
        </div>
      </div>

      <div className="card overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Skid Number
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Status
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Weight (lbs)
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Pieces
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Shipment
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Created
                </th>
                <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Actions
                </th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {data?.results.map((skid) => (
                <tr key={skid.id} className="hover:bg-gray-50">
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="flex items-center gap-2">
                      <Package className="h-4 w-4 text-gray-400" />
                      <span className="text-sm font-medium text-gray-900">
                        {skid.skid_number}
                      </span>
                    </div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <span
                      className={`px-2 py-1 text-xs font-semibold rounded-full ${
                        statusColors[skid.status]
                      }`}
                    >
                      {skid.status}
                    </span>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="text-sm text-gray-900">
                      <span className="font-medium">{skid.gross_weight.toLocaleString()}</span> gross
                    </div>
                    <div className="text-xs text-gray-500">
                      {skid.net_weight.toLocaleString()} net
                    </div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <span className="text-sm text-gray-900">{skid.piece_count}</span>
                  </td>
                  <td className="px-6 py-4">
                    {skid.shipment ? (
                      <div className="text-sm">
                        <Link
                          to={`/shipping/shipments/${skid.shipment.id}`}
                          className="text-primary-600 hover:text-primary-900 font-medium"
                        >
                          {skid.shipment.bol_number}
                        </Link>
                        <div className="flex items-center gap-1 text-xs text-gray-500 mt-1">
                          <MapPin className="h-3 w-3" />
                          {skid.shipment.destination_address.substring(0, 30)}...
                        </div>
                      </div>
                    ) : (
                      <span className="text-sm text-gray-500">Not assigned</span>
                    )}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="text-sm text-gray-900">
                      {format(new Date(skid.created_at), 'MM/dd/yyyy')}
                    </div>
                    <div className="text-xs text-gray-500">{skid.created_by}</div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                    <button
                      onClick={() => downloadSkidLabel(skid.id)}
                      className="text-primary-600 hover:text-primary-900 inline-flex items-center gap-1"
                      title="Download Skid Label"
                    >
                      <FileText className="h-4 w-4" />
                      Label
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {data && data.results.length === 0 && (
          <div className="text-center py-12">
            <Package className="mx-auto h-12 w-12 text-gray-400" />
            <h3 className="mt-2 text-sm font-medium text-gray-900">No skids found</h3>
            <p className="mt-1 text-sm text-gray-500">
              Try adjusting your search or filters
            </p>
          </div>
        )}

        {data && data.count > 10 && (
          <div className="px-6 py-4 border-t border-gray-200 flex items-center justify-between">
            <div className="text-sm text-gray-700">
              Showing {((page - 1) * 10) + 1} to {Math.min(page * 10, data.count)} of {data.count} skids
            </div>
            <div className="flex gap-2">
              <button
                onClick={() => setPage(page - 1)}
                disabled={!data.previous}
                className="btn btn-secondary disabled:opacity-50"
              >
                Previous
              </button>
              <button
                onClick={() => setPage(page + 1)}
                disabled={!data.next}
                className="btn btn-secondary disabled:opacity-50"
              >
                Next
              </button>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
