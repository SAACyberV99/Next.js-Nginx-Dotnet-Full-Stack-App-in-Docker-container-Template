/** @type {import('next').NextConfig} */
const nextConfig = {
  // Enable standalone output for Docker
  output: 'standalone',
  
  // Optional: Configure API rewrites if needed
  async rewrites() {
    return [
      {
        source: '/api/:path*',
        destination: 'http://nginx/api/:path*', // Proxy to Backend via nginx
      },
    ];
  },
}

module.exports = nextConfig
