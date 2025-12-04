import { useState } from 'react'
import api from '@/lib/api'

interface ReportButtonProps {
  label: string
  onClick: () => Promise<void>
  icon?: string
  variant?: 'primary' | 'secondary' | 'success'
}

function ReportButton({ label, onClick, icon, variant = 'primary' }: ReportButtonProps) {
  const [loading, setLoading] = useState(false)

  const handleClick = async () => {
    setLoading(true)
    try {
      await onClick()
    } finally {
      setLoading(false)
    }
  }

  const variantClasses = {
    primary: 'bg-blue-600 hover:bg-blue-700 text-white',
    secondary: 'bg-gray-600 hover:bg-gray-700 text-white',
    success: 'bg-green-600 hover:bg-green-700 text-white',
  }

  return (
    <button
      onClick={handleClick}
      disabled={loading}
      className={`px-4 py-2 rounded-lg font-medium transition-colors disabled:opacity-50 disabled:cursor-not-allowed ${variantClasses[variant]}`}
    >
      {loading ? (
        <span className="flex items-center gap-2">
          <svg className="animate-spin h-5 w-5" viewBox="0 0 24 24">
            <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" fill="none" />
            <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" />
          </svg>
          Generating...
        </span>
      ) : (
        <span className="flex items-center gap-2">
          {icon && <span>{icon}</span>}
          {label}
        </span>
      )}
    </button>
  )
}

export default function Reports() {
  const [selectedCoilId, setSelectedCoilId] = useState('')
  const [selectedSkidId, setSelectedSkidId] = useState('')
  const [selectedBolId, setSelectedBolId] = useState('')
  const [selectedShipmentId, setSelectedShipmentId] = useState('')
  const [barcodeText, setBarcodeText] = useState('')
  const [qrData, setQrData] = useState('')

  const downloadFile = (blob: Blob, filename: string) => {
    const url = window.URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = filename
    document.body.appendChild(a)
    a.click()
    window.URL.revokeObjectURL(url)
    document.body.removeChild(a)
  }

  const generateCoilCertificate = async () => {
    if (!selectedCoilId) {
      alert('Please enter a Coil ID')
      return
    }
    const response = await api.get(`/reports/certificate/coil/${selectedCoilId}/`, {
      responseType: 'blob',
    })
    downloadFile(response.data, `MTC_${selectedCoilId}.pdf`)
  }

  const generateCoilLabel = async () => {
    if (!selectedCoilId) {
      alert('Please enter a Coil ID')
      return
    }
    const response = await api.get(`/reports/label/coil/${selectedCoilId}/`, {
      responseType: 'blob',
    })
    downloadFile(response.data, `Label_Coil_${selectedCoilId}.pdf`)
  }

  const generateSkidLabel = async () => {
    if (!selectedSkidId) {
      alert('Please enter a Skid ID')
      return
    }
    const response = await api.get(`/reports/label/skid/${selectedSkidId}/`, {
      responseType: 'blob',
    })
    downloadFile(response.data, `Label_Skid_${selectedSkidId}.pdf`)
  }

  const generateBOL = async () => {
    if (!selectedBolId) {
      alert('Please enter a BOL ID')
      return
    }
    const response = await api.get(`/reports/bol/${selectedBolId}/`, {
      responseType: 'blob',
    })
    downloadFile(response.data, `BOL_${selectedBolId}.pdf`)
  }

  const generatePackingList = async () => {
    if (!selectedShipmentId) {
      alert('Please enter a Shipment ID')
      return
    }
    const response = await api.get(`/reports/packing-list/${selectedShipmentId}/`, {
      responseType: 'blob',
    })
    downloadFile(response.data, `PackingList_${selectedShipmentId}.pdf`)
  }

  const generateBarcode = async () => {
    if (!barcodeText) {
      alert('Please enter text for barcode')
      return
    }
    const response = await api.get(`/reports/barcode/`, {
      params: { code: barcodeText, type: 'code128' },
      responseType: 'blob',
    })
    downloadFile(response.data, `barcode_${barcodeText}.png`)
  }

  const generateQRCode = async () => {
    if (!qrData) {
      alert('Please enter data for QR code')
      return
    }
    const response = await api.get(`/reports/qrcode/`, {
      params: { data: qrData, size: 200 },
      responseType: 'blob',
    })
    downloadFile(response.data, 'qrcode.png')
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">Reports & Documents</h1>
        <p className="text-gray-600 mt-2">Generate certificates, labels, and shipping documents</p>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Certificates Section */}
        <div className="bg-white rounded-lg shadow p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">📄 Certificates</h2>
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Mill Test Certificate (MTC)
              </label>
              <div className="flex gap-2">
                <input
                  type="text"
                  placeholder="Enter Coil ID"
                  value={selectedCoilId}
                  onChange={(e) => setSelectedCoilId(e.target.value)}
                  className="flex-1 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                />
                <ReportButton
                  label="Generate"
                  onClick={generateCoilCertificate}
                  variant="primary"
                />
              </div>
              <p className="text-xs text-gray-500 mt-1">
                Generates a complete Mill Test Certificate with chemical and mechanical properties
              </p>
            </div>
          </div>
        </div>

        {/* Labels Section */}
        <div className="bg-white rounded-lg shadow p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">🏷️ Labels</h2>
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Coil Label
              </label>
              <div className="flex gap-2">
                <input
                  type="text"
                  placeholder="Enter Coil ID"
                  value={selectedCoilId}
                  onChange={(e) => setSelectedCoilId(e.target.value)}
                  className="flex-1 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                />
                <ReportButton
                  label="Generate"
                  onClick={generateCoilLabel}
                  variant="success"
                />
              </div>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Skid Label
              </label>
              <div className="flex gap-2">
                <input
                  type="text"
                  placeholder="Enter Skid ID"
                  value={selectedSkidId}
                  onChange={(e) => setSelectedSkidId(e.target.value)}
                  className="flex-1 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                />
                <ReportButton
                  label="Generate"
                  onClick={generateSkidLabel}
                  variant="success"
                />
              </div>
            </div>
          </div>
        </div>

        {/* Shipping Documents Section */}
        <div className="bg-white rounded-lg shadow p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">📦 Shipping Documents</h2>
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Bill of Lading (BOL)
              </label>
              <div className="flex gap-2">
                <input
                  type="text"
                  placeholder="Enter BOL ID"
                  value={selectedBolId}
                  onChange={(e) => setSelectedBolId(e.target.value)}
                  className="flex-1 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                />
                <ReportButton
                  label="Generate"
                  onClick={generateBOL}
                  variant="secondary"
                />
              </div>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Packing List
              </label>
              <div className="flex gap-2">
                <input
                  type="text"
                  placeholder="Enter Shipment ID"
                  value={selectedShipmentId}
                  onChange={(e) => setSelectedShipmentId(e.target.value)}
                  className="flex-1 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                />
                <ReportButton
                  label="Generate"
                  onClick={generatePackingList}
                  variant="secondary"
                />
              </div>
            </div>
          </div>
        </div>

        {/* Barcodes Section */}
        <div className="bg-white rounded-lg shadow p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">📊 Barcodes & QR Codes</h2>
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Generate Barcode
              </label>
              <div className="flex gap-2">
                <input
                  type="text"
                  placeholder="Enter text"
                  value={barcodeText}
                  onChange={(e) => setBarcodeText(e.target.value)}
                  className="flex-1 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                />
                <ReportButton
                  label="Generate"
                  onClick={generateBarcode}
                  variant="primary"
                />
              </div>
              <p className="text-xs text-gray-500 mt-1">
                Generates Code128 barcode image
              </p>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Generate QR Code
              </label>
              <div className="flex gap-2">
                <input
                  type="text"
                  placeholder="Enter data"
                  value={qrData}
                  onChange={(e) => setQrData(e.target.value)}
                  className="flex-1 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                />
                <ReportButton
                  label="Generate"
                  onClick={generateQRCode}
                  variant="primary"
                />
              </div>
              <p className="text-xs text-gray-500 mt-1">
                Generates QR code for tracking and identification
              </p>
            </div>
          </div>
        </div>
      </div>

      {/* Information Section */}
      <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
        <h3 className="font-semibold text-blue-900 mb-2">ℹ️ How to Use</h3>
        <ul className="text-sm text-blue-800 space-y-1 list-disc list-inside">
          <li>Enter the ID of the item you want to generate a report for</li>
          <li>Click the Generate button to create and download the PDF/image</li>
          <li>For batch labels, use the inventory or shipment pages to select multiple items</li>
          <li>All generated documents include barcodes for easy tracking</li>
        </ul>
      </div>
    </div>
  )
}
