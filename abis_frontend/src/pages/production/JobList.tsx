import { useQuery } from '@tanstack/react-query'
import { Link } from 'react-router-dom'
import api from '@/lib/api'
import { Job, PaginatedResponse } from '@/types'
import { Plus, Search, Play, CheckCircle } from 'lucide-react'
import { useState } from 'react'
import { format } from 'date-fns'
import toast from 'react-hot-toast'

export default function JobList() {
  const [search, setSearch] = useState('')
  const [status, setStatus] = useState('')

  const { data, isLoading, refetch } = useQuery<PaginatedResponse<Job>>({
    queryKey: ['jobs', search, status],
    queryFn: async () => {
      const params = new URLSearchParams()
      if (search) params.append('search', search)
      if (status) params.append('status', status)
      const response = await api.get(`/production/jobs/?${params}`)
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

  const handleStartJob = async (jobId: number) => {
    try {
      await api.post(`/production/jobs/${jobId}/start/`)
      toast.success('Job started successfully')
      refetch()
    } catch (error: any) {
      toast.error(error.response?.data?.detail || 'Failed to start job')
    }
  }

  const handleCompleteJob = async (jobId: number) => {
    try {
      await api.post(`/production/jobs/${jobId}/complete/`)
      toast.success('Job completed successfully')
      refetch()
    } catch (error: any) {
      toast.error(error.response?.data?.detail || 'Failed to complete job')
    }
  }

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-3xl font-bold text-gray-900">Production Jobs</h1>
        <button className="btn btn-primary flex items-center gap-2">
          <Plus className="h-4 w-4" />
          Create Job
        </button>
      </div>

      <div className="card p-6 mb-6">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="col-span-2">
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-5 w-5 text-gray-400" />
              <input
                type="text"
                placeholder="Search jobs by number, customer, or part..."
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
              <option value="SCHEDULED">Scheduled</option>
              <option value="IN_PROGRESS">In Progress</option>
              <option value="COMPLETED">Completed</option>
              <option value="ON_HOLD">On Hold</option>
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
                    Job Number
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Customer
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Part Number
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Line
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Quantity
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Status
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                    Scheduled
                  </th>
                  <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">
                    Actions
                  </th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {data?.results.map(job => (
                  <tr key={job.id} className="hover:bg-gray-50">
                    <td className="px-6 py-4 whitespace-nowrap">
                      <Link
                        to={`/production/jobs/${job.id}`}
                        className="text-primary-600 hover:text-primary-900 font-medium"
                      >
                        {job.job_number}
                      </Link>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      {job.customer_name}
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-900">
                      <div className="font-medium">{job.part_number}</div>
                      <div className="text-xs text-gray-500 truncate max-w-xs">
                        {job.part_description}
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      {job.line_name}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      {job.produced_quantity.toLocaleString()} / {job.ordered_quantity.toLocaleString()}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className={`px-2 py-1 text-xs font-semibold rounded-full ${statusColors[job.status]}`}>
                        {job.status.replace('_', ' ')}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      {job.scheduled_date && format(new Date(job.scheduled_date), 'MM/dd/yyyy')}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                      {job.status === 'SCHEDULED' && (
                        <button
                          onClick={() => handleStartJob(job.id)}
                          className="text-green-600 hover:text-green-900 mr-3"
                          title="Start Job"
                        >
                          <Play className="h-4 w-4" />
                        </button>
                      )}
                      {job.status === 'IN_PROGRESS' && (
                        <button
                          onClick={() => handleCompleteJob(job.id)}
                          className="text-blue-600 hover:text-blue-900"
                          title="Complete Job"
                        >
                          <CheckCircle className="h-4 w-4" />
                        </button>
                      )}
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
              Showing {data.results.length} of {data.count} jobs
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
