#!/bin/bash

# Script to verify Next.js frontend file structure

echo "🔍 Verifying Next.js Frontend Structure..."
echo ""

cd frontend 2>/dev/null || {
    echo "❌ Error: 'frontend' directory not found"
    echo "   Make sure you're in the docker-setup directory"
    exit 1
}

echo "Checking required files..."
echo ""

# Required files
REQUIRED_FILES=(
    "package.json"
    "next.config.js"
    "app/layout.js"
    "app/page.js"
    "app/page.module.css"
    "app/globals.css"
    "app/api/hello/route.js"
    "Dockerfile"
    ".dockerignore"
)

MISSING_FILES=0

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file - MISSING!"
        MISSING_FILES=$((MISSING_FILES + 1))
    fi
done

echo ""
echo "================================"

if [ $MISSING_FILES -eq 0 ]; then
    echo "✅ All required files present!"
    echo ""
    echo "Your directory structure should look like:"
    echo ""
    echo "frontend/"
    echo "├── app/"
    echo "│   ├── api/"
    echo "│   │   └── hello/"
    echo "│   │       └── route.js"
    echo "│   ├── globals.css"
    echo "│   ├── layout.js      ← ROOT LAYOUT (required!)"
    echo "│   ├── page.js"
    echo "│   └── page.module.css"
    echo "├── package.json"
    echo "├── next.config.js"
    echo "├── Dockerfile"
    echo "└── .dockerignore"
    echo ""
    echo "You can now run:"
    echo "  docker-compose up --build"
    echo "  OR"
    echo "  npm install && npm run dev"
else
    echo "❌ Missing $MISSING_FILES file(s)!"
    echo ""
    echo "Please make sure you copied ALL files from the docker-setup/frontend directory."
    echo ""
    echo "The app/layout.js file is REQUIRED for Next.js App Router."
fi

echo "================================"
