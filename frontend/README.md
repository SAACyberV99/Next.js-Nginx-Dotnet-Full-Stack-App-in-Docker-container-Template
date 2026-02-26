# Next.js Frontend - Hello World

This is a simple Next.js application that demonstrates the frontend component of the Docker architecture.

## Features

- ⚛️ Next.js 14 with App Router
- 🎨 Modern, responsive UI
- 🔌 API route to test backend connectivity
- 🐳 Docker-ready with optimized builds

## Local Development

### Prerequisites
- Node.js 18+ installed
- npm or yarn

### Run Locally (Outside Docker)

```bash
# Install dependencies
npm install

# Run development server
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

### Run with Docker

From the project root (not this directory):

```bash
# Build and run all services
docker-compose up --build

# Or run only the frontend
docker-compose up frontend
```

## Project Structure

```
frontend/
├── app/
│   ├── api/
│   │   └── hello/
│   │       └── route.js       # API route for backend testing
│   ├── globals.css            # Global styles
│   ├── layout.js              # Root layout
│   ├── page.js                # Home page
│   └── page.module.css        # Page styles
├── package.json
├── next.config.js             # Next.js configuration
├── Dockerfile                 # Docker build instructions
└── .dockerignore             # Docker ignore patterns
```

## API Routes

- `GET /api/hello` - Test endpoint that will eventually connect to the .NET backend

## Building for Production

```bash
npm run build
npm start
```

## Environment Variables

The app uses these environment variables:

- `NEXT_PUBLIC_API_URL` - Backend API URL (default: http://nginx/api)
- `NODE_ENV` - Environment mode (development/production)

## Testing the Backend Connection

1. Click the "Test Backend API" button on the home page
2. The app will call `/api/hello` which should proxy to your .NET backend
3. Currently returns a placeholder response until the backend is configured

## Next Steps

1. Ensure your .NET backend has a `/api/health` endpoint
2. Uncomment the fetch code in `app/api/hello/route.js`
3. Test the full stack connection through the UI

## Learn More

- [Next.js Documentation](https://nextjs.org/docs)
- [Next.js App Router](https://nextjs.org/docs/app)
- [React Documentation](https://react.dev)
