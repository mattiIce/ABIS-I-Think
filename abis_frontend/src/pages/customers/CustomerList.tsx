import { useQuery } from '@tanstack/react-query'
import api from '@/lib/api'
import { Customer, PaginatedResponse } from '@/types'
import { Plus, Search, Mail, Phone, MapPin } from 'lucide-react'
import { useState } from 'react'

export default function CustomerList() {
  const [search, setSearch] = useState('')
  const [activeFilter, setActiveFilter] = useState('true')

  const { data, isLoading } = useQuery<PaginatedResponse<Customer>>({
    queryKey: ['customers', search, activeFilter],
    queryFn: async () => {
      const params = new URLSearchParams()
      if (search) params.append('search', search)
      if (activeFilter) params.append('is_active', activeFilter)
      const response = await api.get(`/customers/customers/?${params}`)
      return response.data
    },
  })

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-3xl font-bold text-gray-900">Customers</h1>
        <button className="btn btn-primary flex items-center gap-2">
          <Plus className="h-4 w-4" />
          Add Customer
        </button>
      </div>

      <div className="card p-6 mb-6">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="col-span-2">
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-5 w-5 text-gray-400" />
              <input
                type="text"
                placeholder="Search customers by name, code, or city..."
                value={search}
                onChange={e => setSearch(e.target.value)}
                className="input pl-10"
              />
            </div>
          </div>
          <div>
            <select
              value={activeFilter}
              onChange={e => setActiveFilter(e.target.value)}
              className="input"
            >
              <option value="">All Customers</option>
              <option value="true">Active Only</option>
              <option value="false">Inactive Only</option>
            </select>
          </div>
        </div>
      </div>

      {isLoading ? (
        <div className="card p-8 text-center text-gray-500">Loading...</div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {data?.results.map(customer => (
            <div key={customer.id} className="card p-6 hover:shadow-lg transition-shadow">
              <div className="flex justify-between items-start mb-4">
                <div>
                  <h3 className="text-lg font-semibold text-gray-900">{customer.company_name}</h3>
                  <p className="text-sm text-gray-500">{customer.customer_code}</p>
                </div>
                <span
                  className={`px-2 py-1 text-xs font-semibold rounded-full ${
                    customer.is_active
                      ? 'bg-green-100 text-green-800'
                      : 'bg-gray-100 text-gray-800'
                  }`}
                >
                  {customer.is_active ? 'Active' : 'Inactive'}
                </span>
              </div>

              <div className="space-y-3 text-sm">
                <div className="flex items-start gap-2 text-gray-600">
                  <MapPin className="h-4 w-4 mt-0.5 flex-shrink-0" />
                  <div>
                    <div>{customer.address_line1}</div>
                    {customer.address_line2 && <div>{customer.address_line2}</div>}
                    <div>
                      {customer.city}, {customer.state} {customer.zip_code}
                    </div>
                  </div>
                </div>

                {customer.phone && (
                  <div className="flex items-center gap-2 text-gray-600">
                    <Phone className="h-4 w-4" />
                    <span>{customer.phone}</span>
                  </div>
                )}

                {customer.email && (
                  <div className="flex items-center gap-2 text-gray-600">
                    <Mail className="h-4 w-4" />
                    <a href={`mailto:${customer.email}`} className="text-primary-600 hover:text-primary-900">
                      {customer.email}
                    </a>
                  </div>
                )}
              </div>

              <div className="mt-4 pt-4 border-t border-gray-200">
                <button className="text-sm text-primary-600 hover:text-primary-900 font-medium">
                  View Details →
                </button>
              </div>
            </div>
          ))}
        </div>
      )}

      {data && (
        <div className="mt-6 card p-4 flex items-center justify-between">
          <div className="text-sm text-gray-700">
            Showing {data.results.length} of {data.count} customers
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
  )
}
