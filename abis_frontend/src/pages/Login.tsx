import { useState, FormEvent } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAuthStore } from '@/stores/authStore'
import api from '@/lib/api'
import toast from 'react-hot-toast'
import { LogIn } from 'lucide-react'

export default function Login() {
  const [username, setUsername] = useState('')
  const [password, setPassword] = useState('')
  const [loading, setLoading] = useState(false)
  const navigate = useNavigate()
  const login = useAuthStore(state => state.login)

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault()
    setLoading(true)

    try {
      const response = await api.post('/auth/token/', { username, password })
      const { access, refresh } = response.data

      // Get user info
      const userResponse = await api.get('/auth/user/', {
        headers: { Authorization: `Bearer ${access}` },
      })

      login(access, refresh, userResponse.data)
      toast.success('Login successful!')
      navigate('/')
    } catch (error: any) {
      toast.error(error.response?.data?.detail || 'Login failed')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary-50 to-primary-100 flex items-center justify-center p-4">
      <div className="w-full max-w-md">
        <div className="card p-8">
          <div className="text-center mb-8">
            <h1 className="text-3xl font-bold text-primary-600 mb-2">ABIS Modern</h1>
            <p className="text-gray-600">Aluminum Business Information System</p>
          </div>

          <form onSubmit={handleSubmit} className="space-y-6">
            <div>
              <label htmlFor="username" className="label">
                Username
              </label>
              <input
                id="username"
                type="text"
                value={username}
                onChange={e => setUsername(e.target.value)}
                className="input"
                required
                autoFocus
              />
            </div>

            <div>
              <label htmlFor="password" className="label">
                Password
              </label>
              <input
                id="password"
                type="password"
                value={password}
                onChange={e => setPassword(e.target.value)}
                className="input"
                required
              />
            </div>

            <button
              type="submit"
              disabled={loading}
              className="w-full btn btn-primary flex items-center justify-center gap-2"
            >
              {loading ? (
                <>Loading...</>
              ) : (
                <>
                  <LogIn className="h-4 w-4" />
                  Sign In
                </>
              )}
            </button>
          </form>

          <div className="mt-6 text-center text-sm text-gray-600">
            <p>Demo credentials:</p>
            <p className="font-mono text-xs mt-1">admin / your_password</p>
          </div>
        </div>
      </div>
    </div>
  )
}
