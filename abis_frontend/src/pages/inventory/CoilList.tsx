import { useQuery } from '@tanstack/react-query'
import { Link } from 'react-router-dom'
import api from '@/lib/api'
import { Coil, PaginatedResponse } from '@/types'
import { Plus, Search } from 'lucide-react'
import { useState } from 'react'
import { format } from 'date-fns'

export default function CoilList() {
  const [search, setSearch] = useState('')
  const [status, setStatus] = useState('')

  const { data, isLoading } = useQuery<PaginatedResponse<Coil>>({
    queryKey: ['coils', search, status],
    queryFn: async () => {
      const params = new URLSearchParams()
      if (search) params.append('search', search)
      if (status) params.append('status', status)
      const response = await api.get(`/inventory/coils/?${params}`)
      return response.data
    },
  })

  const statusColors: Record<string, string> = {
    RECEIVED: 'bg-blue-100 text-blue-800',
    QA_PENDING: 'bg-yellow-100 text-yellow-800',
    QA_APPROVED: 'bg-green-100 text-green-800',
    QA_REJECTED: 'bg-red-100 text-red-800',
    IN_PRODUCTION: 'bg-purple-100 text-purple-800',
    SCRAPPED: 'bg-gray-100 text-gray-800',
  }

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-3xl font-bold text-gray-900">Coil Inventory</h1>
        <button className="btn btn-primary flex items-center gap-2">
          <Plus className="h-4 w-4" />
          Receive Coil
        </button>
      </div>

      <div className="card p-6 mb-6">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="col-span-2">
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-5 w-5 text-gray-400" />
              <input
                type="text"
                placeholder="Search coils..."
                value={search}
                onChange={e => setSearch(e.target.value)}
                className="input pl-10"
              />
            </div>
          </div>
          <div>
            <select
              value={status}
              onChange={e => setStatus(e.target.value)}
              className="input"
            >
              <option value="">All Status</option>
              <option value="RECEIVED">Received</option>
              <option value="QA_PENDING">QA Pending</option>
              <option value="QA_APPROVED">QA Approved</option>
              <option value="IN_PRODUCTION">In Production</option>
            </select>
          </div>
        </div>
      </div>

      <div className="card overflow-hidden">
        {isLoading ? (
          <div className="p-8 text-center text-gray-500">Loading...</div>
        ) : (
          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Coil Number
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Customer
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Alloy/Temper
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Dimensions
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Weight
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Status
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Received
                  </th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {data?.results.map(coil => (
                  <tr key={coil.id} className="hover:bg-gray-50">
                    <td className="px-6 py-4 whitespace-nowrap">
                      <Link
                        to={`/inventory/coils/${coil.id}`}
                        className="text-primary-600 hover:text-primary-900 font-medium"
                      >
                        {coil.abc_coil_number}
                      </Link>
                      <div className="text-xs text-gray-500">{coil.original_coil_number}</div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      {coil.customer_name}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      {coil.alloy_code} / {coil.temper_code}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      {coil.gauge}" × {coil.width}"
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      {coil.net_weight.toLocaleString()} lbs
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className={`px-2 py-1 text-xs font-semibold rounded-full ${statusColors[coil.status]}`}>
                        {coil.status.replace('_', ' ')}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      {format(new Date(coil.received_date), 'MM/dd/yyyy')}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}

        {data && (
          <div className="px-6 py-4 border-t border-gray-200 flex items-center justify-between">
            <div className="text-sm text-gray-700">
              Showing {data.results.length} of {data.count} coils
            </div>
            <div className="flex gap-2">
              <button disabled={!data.previous} className="btn btn-secondary text-sm">
                Previous
              </button>
              <button disabled={!data.next} className="btn btn-secondary text-sm">
                Next
              </button>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
