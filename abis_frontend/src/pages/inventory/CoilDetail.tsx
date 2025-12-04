import { useQuery } from '@tanstack/react-query'
import { useParams, Link } from 'react-router-dom'
import api from '@/lib/api'
import { Coil, CoilHistory } from '@/types'
import { ArrowLeft, CheckCircle, XCircle } from 'lucide-react'
import { format } from 'date-fns'

export default function CoilDetail() {
  const { id } = useParams<{ id: string }>()

  const { data: coil } = useQuery<Coil>({
    queryKey: ['coil', id],
    queryFn: async () => {
      const response = await api.get(`/inventory/coils/${id}/`)
      return response.data
    },
  })

  const { data: history } = useQuery<CoilHistory[]>({
    queryKey: ['coil-history', id],
    queryFn: async () => {
      const response = await api.get(`/inventory/coils/${id}/history/`)
      return response.data
    },
  })

  if (!coil) return <div>Loading...</div>

  return (
    <div>
      <div className="mb-6">
        <Link to="/inventory/coils" className="flex items-center text-primary-600 hover:text-primary-900 mb-4">
          <ArrowLeft className="h-4 w-4 mr-2" />
          Back to Coils
        </Link>
        <h1 className="text-3xl font-bold text-gray-900">{coil.abc_coil_number}</h1>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div className="lg:col-span-2 space-y-6">
          <div className="card p-6">
            <h2 className="text-lg font-semibold text-gray-900 mb-4">Coil Information</h2>
            <dl className="grid grid-cols-2 gap-4">
              <div>
                <dt className="text-sm font-medium text-gray-500">ABC Coil Number</dt>
                <dd className="mt-1 text-sm text-gray-900">{coil.abc_coil_number}</dd>
              </div>
              <div>
                <dt className="text-sm font-medium text-gray-500">Original Coil Number</dt>
                <dd className="mt-1 text-sm text-gray-900">{coil.original_coil_number}</dd>
              </div>
              <div>
                <dt className="text-sm font-medium text-gray-500">Customer</dt>
                <dd className="mt-1 text-sm text-gray-900">{coil.customer_name}</dd>
              </div>
              <div>
                <dt className="text-sm font-medium text-gray-500">Alloy / Temper</dt>
                <dd className="mt-1 text-sm text-gray-900">{coil.alloy_code} / {coil.temper_code}</dd>
              </div>
              <div>
                <dt className="text-sm font-medium text-gray-500">Gauge</dt>
                <dd className="mt-1 text-sm text-gray-900">{coil.gauge}"</dd>
              </div>
              <div>
                <dt className="text-sm font-medium text-gray-500">Width</dt>
                <dd className="mt-1 text-sm text-gray-900">{coil.width}"</dd>
              </div>
              <div>
                <dt className="text-sm font-medium text-gray-500">Net Weight</dt>
                <dd className="mt-1 text-sm text-gray-900">{coil.net_weight.toLocaleString()} lbs</dd>
              </div>
              <div>
                <dt className="text-sm font-medium text-gray-500">Gross Weight</dt>
                <dd className="mt-1 text-sm text-gray-900">{coil.gross_weight.toLocaleString()} lbs</dd>
              </div>
              <div>
                <dt className="text-sm font-medium text-gray-500">Heat Number</dt>
                <dd className="mt-1 text-sm text-gray-900">{coil.heat_number || 'N/A'}</dd>
              </div>
              <div>
                <dt className="text-sm font-medium text-gray-500">PO Number</dt>
                <dd className="mt-1 text-sm text-gray-900">{coil.po_number || 'N/A'}</dd>
              </div>
              <div>
                <dt className="text-sm font-medium text-gray-500">Location</dt>
                <dd className="mt-1 text-sm text-gray-900">{coil.location || 'N/A'}</dd>
              </div>
              <div>
                <dt className="text-sm font-medium text-gray-500">Received Date</dt>
                <dd className="mt-1 text-sm text-gray-900">
                  {format(new Date(coil.received_date), 'MM/dd/yyyy')}
                </dd>
              </div>
            </dl>
            {coil.notes && (
              <div className="mt-4">
                <dt className="text-sm font-medium text-gray-500">Notes</dt>
                <dd className="mt-1 text-sm text-gray-900">{coil.notes}</dd>
              </div>
            )}
          </div>

          <div className="card p-6">
            <h2 className="text-lg font-semibold text-gray-900 mb-4">History</h2>
            <div className="space-y-4">
              {history?.map(item => (
                <div key={item.id} className="border-l-2 border-primary-500 pl-4">
                  <div className="text-sm font-medium text-gray-900">{item.action}</div>
                  <div className="text-xs text-gray-500">
                    {format(new Date(item.changed_at), 'MM/dd/yyyy HH:mm')}
                  </div>
                  {item.old_value && item.new_value && (
                    <div className="text-xs text-gray-600 mt-1">
                      {item.old_value} → {item.new_value}
                    </div>
                  )}
                </div>
              ))}
            </div>
          </div>
        </div>

        <div className="space-y-6">
          <div className="card p-6">
            <h2 className="text-lg font-semibold text-gray-900 mb-4">Actions</h2>
            <div className="space-y-2">
              {coil.status === 'QA_PENDING' && (
                <>
                  <button className="w-full btn btn-primary flex items-center justify-center gap-2">
                    <CheckCircle className="h-4 w-4" />
                    Approve QA
                  </button>
                  <button className="w-full btn btn-danger flex items-center justify-center gap-2">
                    <XCircle className="h-4 w-4" />
                    Reject QA
                  </button>
                </>
              )}
              <button className="w-full btn btn-secondary">Assign to Job</button>
              <button className="w-full btn btn-secondary">Print Label</button>
              <button className="w-full btn btn-secondary">Move Location</button>
            </div>
          </div>

          <div className="card p-6">
            <h2 className="text-lg font-semibold text-gray-900 mb-4">Status</h2>
            <div className="space-y-2">
              <div className="flex items-center justify-between">
                <span className="text-sm text-gray-600">Current Status</span>
                <span className="text-sm font-medium">{coil.status.replace('_', ' ')}</span>
              </div>
              <div className="flex items-center justify-between">
                <span className="text-sm text-gray-600">Created</span>
                <span className="text-sm">{format(new Date(coil.created_at), 'MM/dd/yyyy')}</span>
              </div>
              <div className="flex items-center justify-between">
                <span className="text-sm text-gray-600">Updated</span>
                <span className="text-sm">{format(new Date(coil.updated_at), 'MM/dd/yyyy')}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
