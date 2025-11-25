import { useQuery } from '@tanstack/react-query'
import { useParams, Link } from 'react-router-dom'
import api from '@/lib/api'
import { ArrowLeft, Package, Play, Pause, CheckCircle } from 'lucide-react'
import { format } from 'date-fns'
import toast from 'react-hot-toast'

interface Job {
  id: number
  job_number: string
  customer_name: string
  line_name: string
  part_number: string
  part_description: string
  ordered_quantity: number
  produced_quantity: number
  target_gauge: number
  target_width: number
  status: string
  scheduled_date?: string
  start_date?: string
  completion_date?: string
  notes?: string
  job_coils?: Array<{
    id: number
    coil_number: string
    sequence: number
    assigned_date: string
    used: boolean
  }>
}

export default function JobDetail() {
  const { id } = useParams()

  const { data: job, isLoading, refetch } = useQuery<Job>({
    queryKey: ['job', id],
    queryFn: async () => {
      const response = await api.get(`/production/jobs/${id}/`)
      return response.data
    },
  })

  const statusColors: Record<string, string> = {
    SCHEDULED: 'bg-blue-100 text-blue-800',
    IN_PROGRESS: 'bg-yellow-100 text-yellow-800',
    COMPLETED: 'bg-green-100 text-green-800',
    ON_HOLD: 'bg-orange-100 text-orange-800',
    CANCELLED: 'bg-gray-100 text-gray-800',
  }

  const handleStartJob = async () => {
    try {
      await api.post(`/production/jobs/${id}/start/`)
      toast.success('Job started successfully')
      refetch()
    } catch (error: any) {
      toast.error(error.response?.data?.detail || 'Failed to start job')
    }
  }

  const handleCompleteJob = async () => {
    try {
      await api.post(`/production/jobs/${id}/complete/`)
      toast.success('Job completed successfully')
      refetch()
    } catch (error: any) {
      toast.error(error.response?.data?.detail || 'Failed to complete job')
    }
  }

  if (isLoading) {
    return <div className="p-8 text-center text-gray-500">Loading...</div>
  }

  if (!job) {
    return <div className="p-8 text-center text-gray-500">Job not found</div>
  }

  const progress = job.ordered_quantity > 0
    ? Math.round((job.produced_quantity / job.ordered_quantity) * 100)
    : 0

  return (
    <div>
      <Link
        to="/production/jobs"
        className="inline-flex items-center gap-2 text-gray-600 hover:text-gray-900 mb-4"
      >
        <ArrowLeft className="h-4 w-4" />
        Back to Jobs
      </Link>

      <div className="flex justify-between items-start mb-6">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">{job.job_number}</h1>
          <p className="text-gray-600 mt-1">{job.part_description}</p>
        </div>
        <div className="flex gap-2">
          {job.status === 'SCHEDULED' && (
            <button onClick={handleStartJob} className="btn btn-primary flex items-center gap-2">
              <Play className="h-4 w-4" />
              Start Job
            </button>
          )}
          {job.status === 'IN_PROGRESS' && (
            <button onClick={handleCompleteJob} className="btn btn-success flex items-center gap-2">
              <CheckCircle className="h-4 w-4" />
              Complete Job
            </button>
          )}
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-6">
        <div className="card p-6">
          <div className="flex items-center gap-3 mb-4">
            <div className="p-2 bg-blue-100 rounded-lg">
              <Package className="h-6 w-6 text-blue-600" />
            </div>
            <div>
              <p className="text-sm text-gray-600">Status</p>
              <span className={`inline-block px-2 py-1 text-xs font-semibold rounded-full ${statusColors[job.status]}`}>
                {job.status.replace('_', ' ')}
              </span>
            </div>
          </div>
        </div>

        <div className="card p-6">
          <p className="text-sm text-gray-600 mb-1">Production Progress</p>
          <div className="flex items-baseline gap-2 mb-2">
            <span className="text-2xl font-bold">{progress}%</span>
            <span className="text-sm text-gray-500">
              {job.produced_quantity.toLocaleString()} / {job.ordered_quantity.toLocaleString()}
            </span>
          </div>
          <div className="w-full bg-gray-200 rounded-full h-2">
            <div
              className="bg-blue-600 h-2 rounded-full transition-all"
              style={{ width: `${progress}%` }}
            />
          </div>
        </div>

        <div className="card p-6">
          <p className="text-sm text-gray-600 mb-1">Line</p>
          <p className="text-2xl font-bold">{job.line_name}</p>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="card p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Job Information</h2>
          <dl className="space-y-3">
            <div>
              <dt className="text-sm font-medium text-gray-500">Customer</dt>
              <dd className="text-sm text-gray-900">{job.customer_name}</dd>
            </div>
            <div>
              <dt className="text-sm font-medium text-gray-500">Part Number</dt>
              <dd className="text-sm text-gray-900">{job.part_number}</dd>
            </div>
            <div>
              <dt className="text-sm font-medium text-gray-500">Target Dimensions</dt>
              <dd className="text-sm text-gray-900">
                {job.target_gauge}" gauge × {job.target_width}" width
              </dd>
            </div>
            {job.scheduled_date && (
              <div>
                <dt className="text-sm font-medium text-gray-500">Scheduled Date</dt>
                <dd className="text-sm text-gray-900">
                  {format(new Date(job.scheduled_date), 'MMM dd, yyyy')}
                </dd>
              </div>
            )}
            {job.start_date && (
              <div>
                <dt className="text-sm font-medium text-gray-500">Start Date</dt>
                <dd className="text-sm text-gray-900">
                  {format(new Date(job.start_date), 'MMM dd, yyyy HH:mm')}
                </dd>
              </div>
            )}
            {job.completion_date && (
              <div>
                <dt className="text-sm font-medium text-gray-500">Completion Date</dt>
                <dd className="text-sm text-gray-900">
                  {format(new Date(job.completion_date), 'MMM dd, yyyy HH:mm')}
                </dd>
              </div>
            )}
          </dl>
        </div>

        <div className="card p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Assigned Coils</h2>
          {job.job_coils && job.job_coils.length > 0 ? (
            <div className="space-y-2">
              {job.job_coils.map(jobCoil => (
                <div
                  key={jobCoil.id}
                  className="flex items-center justify-between p-3 bg-gray-50 rounded-lg"
                >
                  <div>
                    <Link
                      to={`/inventory/coils/${jobCoil.id}`}
                      className="text-sm font-medium text-primary-600 hover:text-primary-900"
                    >
                      {jobCoil.coil_number}
                    </Link>
                    <p className="text-xs text-gray-500">
                      Assigned: {format(new Date(jobCoil.assigned_date), 'MM/dd/yyyy')}
                    </p>
                  </div>
                  <span
                    className={`px-2 py-1 text-xs font-semibold rounded-full ${
                      jobCoil.used
                        ? 'bg-green-100 text-green-800'
                        : 'bg-blue-100 text-blue-800'
                    }`}
                  >
                    {jobCoil.used ? 'Used' : 'Assigned'}
                  </span>
                </div>
              ))}
            </div>
          ) : (
            <p className="text-sm text-gray-500">No coils assigned yet</p>
          )}
        </div>
      </div>

      {job.notes && (
        <div className="card p-6 mt-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Notes</h2>
          <p className="text-sm text-gray-700 whitespace-pre-wrap">{job.notes}</p>
        </div>
      )}
    </div>
  )
}
