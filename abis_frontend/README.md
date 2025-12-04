# ABIS Modern - React Frontend

Modern React/TypeScript frontend for the ABIS (Aluminum Business Information System).

## 🚀 Features

- **React 18** with TypeScript
- **Vite** for blazing fast development
- **TailwindCSS** for modern UI styling
- **React Query** for data fetching and caching
- **Zustand** for state management
- **React Router** for navigation
- **Axios** for API communication with JWT auth
- **Lucide Icons** for beautiful icons
- **React Hot Toast** for notifications

## 📦 Installation

```bash
cd /workspaces/ABIS-I-Think/abis_frontend

# Install dependencies
npm install

# Copy environment file
cp .env.example .env

# Start development server
npm run dev
```

The app will be available at **http://localhost:3000**

## 🏗️ Project Structure

```
src/
├── components/          # Reusable UI components
│   └── Layout.tsx      # Main layout with sidebar
├── lib/                # Utilities and configurations
│   └── api.ts          # Axios instance with auth interceptors
├── pages/              # Page components
│   ├── Dashboard.tsx
│   ├── Login.tsx
│   ├── inventory/      # Inventory management pages
│   ├── production/     # Production pages
│   ├── shipping/       # Shipping pages
│   └── customers/      # Customer management pages
├── stores/             # Zustand stores
│   └── authStore.ts    # Authentication state
├── types/              # TypeScript type definitions
│   └── index.ts
├── App.tsx             # Main app component with routes
├── main.tsx            # App entry point
└── index.css           # Global styles and Tailwind
```

## 🔐 Authentication

The app uses JWT token authentication with automatic token refresh:

1. Login with credentials
2. Access and refresh tokens stored in localStorage
3. Automatic token refresh on 401 responses
4. Auto-redirect to login on auth failure

## 📱 Pages Implemented

### ✅ Completed
- **Login** - JWT authentication
- **Dashboard** - Stats overview
- **Coil List** - Browse inventory with search/filter
- **Coil Detail** - View coil information and history

### 🚧 In Progress (Placeholders)
- Skid Management
- Job List & Details
- Shipment Management
- Customer Management

## 🎨 UI Components

All pages use consistent components:
- `.card` - White card with shadow
- `.btn` - Button styles (primary, secondary, danger)
- `.input` - Consistent form inputs
- `.label` - Form labels

## 🔄 API Integration

API calls use React Query for:
- Automatic caching
- Background refetching
- Loading states
- Error handling

Example:
```typescript
const { data, isLoading } = useQuery({
  queryKey: ['coils'],
  queryFn: async () => {
    const response = await api.get('/inventory/coils/')
    return response.data
  },
})
```

## 🛠️ Development

```bash
# Start dev server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview

# Lint code
npm run lint

# Format code
npm run format
```

## 🐳 Docker (Future)

```dockerfile
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build
EXPOSE 3000
CMD ["npm", "run", "preview"]
```

## 🔗 Backend Integration

Connects to Django REST API at `http://localhost:8000/api`:
- `/auth/token/` - Login
- `/auth/token/refresh/` - Refresh token
- `/inventory/coils/` - Coil management
- `/production/jobs/` - Job management
- `/shipping/shipments/` - Shipment management

## 📝 Environment Variables

```env
VITE_API_URL=http://localhost:8000/api
VITE_APP_NAME=ABIS Modern
```

## 🚀 Next Steps

1. Complete remaining pages (Jobs, Shipments, Customers)
2. Add forms for creating/editing records
3. Implement real-time updates with WebSockets
4. Add barcode scanning integration
5. Implement print functionality for labels
6. Add advanced filtering and reporting
7. Mobile responsive improvements

## 📚 Technologies

- [React](https://react.dev/) - UI framework
- [TypeScript](https://www.typescriptlang.org/) - Type safety
- [Vite](https://vitejs.dev/) - Build tool
- [TailwindCSS](https://tailwindcss.com/) - Styling
- [React Query](https://tanstack.com/query) - Data fetching
- [Zustand](https://github.com/pmndrs/zustand) - State management
- [React Router](https://reactrouter.com/) - Routing
- [Axios](https://axios-http.com/) - HTTP client

---

**Status:** 🟡 In Development  
**Version:** 1.0.0  
**Last Updated:** November 25, 2025
