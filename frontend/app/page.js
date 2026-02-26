'use client'

import { useState } from 'react'
import styles from './page.module.css'

export default function Home() {
  const [apiResponse, setApiResponse] = useState('')
  const [loading, setLoading] = useState(false)

  const testBackendAPI = async () => {
    setLoading(true)
    setApiResponse('')
    
    try {
      const response = await fetch('/api/hello')
      const data = await response.json()
      setApiResponse(JSON.stringify(data, null, 2))
    } catch (error) {
      setApiResponse(`Error: ${error.message}`)
    } finally {
      setLoading(false)
    }
  }

  return (
    <main className={styles.main}>
      <div className={styles.container}>
        <h1 className={styles.title}>
          🚀 Hello World!
        </h1>
        
        <p className={styles.description}>
          Next.js Frontend + Nginx Load Balancer + .NET Backend
        </p>

        <div className={styles.grid}>
          <div className={styles.card}>
            <h2>⚛️ Next.js</h2>
            <p>React framework for production</p>
          </div>

          <div className={styles.card}>
            <h2>🔄 Nginx</h2>
            <p>High-performance load balancer</p>
          </div>

          <div className={styles.card}>
            <h2>🟣 .NET</h2>
            <p>Backend API service</p>
          </div>
        </div>

        <div className={styles.apiTest}>
          <button 
            className={styles.button}
            onClick={testBackendAPI}
            disabled={loading}
          >
            {loading ? 'Testing...' : 'Test Backend API'}
          </button>
          
          {apiResponse && (
            <pre className={styles.response}>
              {apiResponse}
            </pre>
          )}
        </div>

        <div className={styles.footer}>
          <p>Running in Docker containers 🐳</p>
        </div>
      </div>
    </main>
  )
}
