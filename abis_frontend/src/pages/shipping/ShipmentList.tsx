import { useQuery } from '@tanstack/react-query'
import { Link } from 'react-router-dom'
import api from '@/lib/api'
import { Shipment, PaginatedResponse } from '@/types'
import { Plus, Search, FileText, Truck } from 'lucide-react'
import { useState } from 'react'
import { format } from 'date-fns'
import toast from 'react-hot-toast'

export default function ShipmentList() {
  const [search, setSearch] = useState('')
  const [status, setStatus] = useState('')

  const { data, isLoading } = useQuery<PaginatedResponse<Shipment>>({
    queryKey: ['shipments', search, status],
    queryFn: async () => {
      const params = new URLSearchParams()
      if (search) params.append('search', search)
      if (status) params.append('status', status)
      const response = await api.get(`/shipping/shipments/?${params}`)
      return response.data
    },
  })

  const statusColors: Record<string, string> = {
    OPEN: 'bg-blue-100 text-blue-800',
    READY: 'bg-green-100 text-green-800',
    SHIPPED: 'bg-purple-100 text-purple-800',
    CANCELLED: 'bg-gray-100 text-gray-800',
  }

  const downloadBOL = async (shipmentId: number, bolNumber: string) => {
    try {
      const response = await api.get(`/reports/bol/${shipmentId}/`, {
        responseType: 'blob',
      })
      const url = window.URL.createObjectURL(response.data)
      const a = document.createElement('a')
      a.href = url
      a.download = `BOL_${bolNumber}.pdf`
      document.body.appendChild(a)
      a.click()
      window.URL.revokeObjectURL(url)
      document.body.removeChild(a)
      toast.success('BOL downloaded')
    } catch (error: any) {
      toast.error('Failed to download BOL')
    }
  }

  const downloadPackingList = async (shipmentId: number, bolNumber: string) => {
    try {
      const response = await api.get(`/reports/packing-list/${shipmentId}/`, {
        responseType: 'blob',
      })
      const url = window.URL.createObjectURL(response.data)
      const a = document.createElement('a')
      a.href = url
      a.download = `PackingList_${bolNumber}.pdf`
      document.body.appendChild(a)
      a.click()
      window.URL.revokeObjectURL(url)
      document.body.removeChild(a)
      toast.success('Packing list downloaded')
    } catch (error: any) {
      toast.error('Failed to download packing list')
    }
  }

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-3xl font-bold text-gray-900">Shipments</h1>
        <button className="btn btn-primary flex items-center gap-2">
          <Plus className="h-4 w-4" />
          New Shipment
        </button>
      </div>

      <div className="card p-6 mb-6">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="col-span-2">
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-5 w-5 text-gray-400" />
              <input
                type="text"
                placeholder="Search shipments by BOL number or customer..."
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
              <option value="OPEN">Open</option>
              <option value="READY">Ready to Ship</option>
              <option value="SHIPPED">Shipped</option>
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
                    BOL Number
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Customer
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Carrier
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Destination
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Weight/Pieces
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Status
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Ship Date
                  </th>
                  <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">
                    Actions
                  </th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {data?.results.map(shipment => (
                  <tr key={shipment.id} className="hover:bg-gray-50">
                    <td className="px-6 py-4 whitespace-nowrap">
                      <Link
                        to={`/shipping/shipments/${shipment.id}`}
                        className="text-primary-600 hover:text-primary-900 font-medium"
                      >
                        {shipment.bol_number}
                      </Link>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      {shipment.customer_name}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      {shipment.carrier_name}
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-900">
                      <div className="font-medium">{shipment.ship_to_name}</div>
                      <div className="text-xs text-gray-500">
                        {shipment.ship_to_city}, {shipment.ship_to_state}
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      {shipment.total_weight.toLocaleString()} lbs
                      <div className="text-xs text-gray-500">{shipment.total_pieces} pieces</div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className={`px-2 py-1 text-xs font-semibold rounded-full ${statusColors[shipment.status]}`}>
                        {shipment.status}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      {format(new Date(shipment.ship_date), 'MM/dd/yyyy')}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                      <button
                        onClick={() => downloadBOL(shipment.id, shipment.bol_number)}
                        className="text-blue-600 hover:text-blue-900 mr-3"
                        title="Download BOL"
                      >
                        <FileText className="h-4 w-4" />
                      </button>
                      <button
                        onClick={() => downloadPackingList(shipment.id, shipment.bol_number)}
                        className="text-green-600 hover:text-green-900"
                        title="Download Packing List"
                      >
                        <Truck className="h-4 w-4" />
                      </button>
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
              Showing {data.results.length} of {data.count} shipments
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
