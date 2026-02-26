#!/bin/bash

# Build script for frontend - use this if Docker build fails
# This builds the frontend locally and creates a simpler Docker image

echo "🔨 Building Next.js Frontend locally..."

cd frontend

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js not found. Please install Node.js 18+"
    echo "Download from: https://nodejs.org/"
    exit 1
fi

# Check Node version
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo "❌ Node.js version 18 or higher is required"
    echo "Current version: $(node -v)"
    exit 1
fi

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf node_modules/ .next/ out/

# Install dependencies
echo "📦 Installing npm packages..."
npm install
if [ $? -ne 0 ]; then
    echo "❌ Failed to install packages"
    exit 1
fi

# Build Next.js
echo "🏗️  Building Next.js application..."
npm run build
if [ $? -ne 0 ]; then
    echo "❌ Failed to build"
    exit 1
fi

# Create simplified Dockerfile
echo "📝 Creating simplified Dockerfile..."
cat > Dockerfile.local <<'EOF'
FROM node:18-alpine
WORKDIR /app

ENV NODE_ENV production

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY public ./public
COPY .next/standalone ./
COPY .next/static ./.next/static

USER nextjs

EXPOSE 3000

ENV PORT 3000
ENV HOSTNAME "0.0.0.0"

CMD ["node", "server.js"]
EOF

echo "✅ Frontend built successfully!"
echo ""
echo "📋 Next steps:"
echo "1. Update docker-compose.yml frontend service to use 'dockerfile: Dockerfile.local'"
echo "2. Run: docker-compose up --build frontend"
echo ""
echo "Or run locally without Docker:"
echo "cd frontend && npm run dev"
