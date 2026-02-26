#!/bin/bash

# Build script for backend - use this if Docker build fails
# This builds the backend locally and creates a simpler Docker image

echo "🔨 Building .NET Backend locally..."

cd backend

# Check if .NET SDK is installed
if ! command -v dotnet &> /dev/null; then
    echo "❌ .NET SDK not found. Please install .NET 8.0 SDK"
    echo "Download from: https://dotnet.microsoft.com/download/dotnet/8.0"
    exit 1
fi

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf bin/ obj/ publish/

# Restore dependencies
echo "📦 Restoring NuGet packages..."
dotnet restore
if [ $? -ne 0 ]; then
    echo "❌ Failed to restore packages"
    exit 1
fi

# Build and publish
echo "🏗️  Building and publishing..."
dotnet publish -c Release -o ./publish
if [ $? -ne 0 ]; then
    echo "❌ Failed to build"
    exit 1
fi

# Create simplified Dockerfile
echo "📝 Creating simplified Dockerfile..."
cat > Dockerfile.local <<'EOF'
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY ./publish .
EXPOSE 5000
ENTRYPOINT ["dotnet", "BackendApi.dll"]
EOF

echo "✅ Backend built successfully!"
echo ""
echo "📋 Next steps:"
echo "1. Update docker-compose.yml to use 'dockerfile: Dockerfile.local'"
echo "2. Run: docker-compose up --build"
echo ""
echo "Or run locally without Docker:"
echo "cd backend && dotnet run"
