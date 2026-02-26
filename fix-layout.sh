#!/bin/bash

# Script to fix missing layout.js file

echo "🔧 Fixing Missing Layout.js..."
echo ""

cd frontend 2>/dev/null || {
    echo "❌ Error: 'frontend' directory not found"
    echo "   Run this script from the docker-setup directory"
    exit 1
}

# Create app directory if it doesn't exist
mkdir -p app

# Check if layout.js already exists
if [ -f "app/layout.js" ]; then
    echo "ℹ️  app/layout.js already exists"
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Skipping layout.js creation"
        exit 0
    fi
fi

# Create layout.js
echo "📝 Creating app/layout.js..."
cat > app/layout.js <<'EOF'
import './globals.css'

export const metadata = {
  title: 'Next.js + .NET Docker App',
  description: 'Hello World app with Next.js frontend and .NET backend',
}

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>
        {children}
      </body>
    </html>
  )
}
EOF

if [ -f "app/layout.js" ]; then
    echo "✅ app/layout.js created successfully!"
    echo ""
    echo "File contents:"
    cat app/layout.js
    echo ""
    echo "================================"
    echo "✅ Fix complete!"
    echo ""
    echo "Next steps:"
    echo "  1. Make sure app/globals.css exists"
    echo "  2. Run: npm install"
    echo "  3. Run: npm run dev"
    echo "  OR"
    echo "  4. Run: docker-compose up --build"
else
    echo "❌ Failed to create app/layout.js"
    exit 1
fi
