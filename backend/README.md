# .NET Backend API

A simple .NET 8.0 Web API that serves as the backend for the Docker architecture with Next.js frontend and Nginx load balancer.

## Features

- 🟣 .NET 8.0 Minimal API
- 📝 Swagger/OpenAPI documentation
- 🔌 CORS enabled for frontend communication
- 🏥 Health check endpoint
- 🐳 Docker-ready with optimized builds

## API Endpoints

### Core Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/` | Root endpoint with service info |
| GET | `/api/health` | Health check endpoint |
| GET | `/api/hello` | Returns hello message |
| GET | `/api/time` | Returns current time information |
| POST | `/api/echo` | Echoes back your message |
| GET | `/swagger` | Swagger UI documentation |

### Endpoint Examples

**Health Check**
```bash
curl http://localhost:5000/api/health
```
Response:
```json
{
  "status": "healthy",
  "service": ".NET Backend API",
  "timestamp": "2024-02-20T10:30:00Z",
  "environment": "Production"
}
```

**Hello Endpoint**
```bash
curl http://localhost:5000/api/hello
```
Response:
```json
{
  "message": "Hello from .NET Backend!",
  "timestamp": "2024-02-20T10:30:00Z",
  "version": "1.0.0",
  "framework": ".NET 8.0"
}
```

**Echo Endpoint**
```bash
curl -X POST http://localhost:5000/api/echo \
  -H "Content-Type: application/json" \
  -d '{"message": "Hello World"}'
```
Response:
```json
{
  "received": "Hello World",
  "length": 11,
  "timestamp": "2024-02-20T10:30:00Z",
  "echo": "You said: Hello World"
}
```

## Local Development

### Prerequisites
- .NET 8.0 SDK installed
- (Optional) Visual Studio 2022 or VS Code

### Run Locally (Outside Docker)

```bash
# Restore dependencies
dotnet restore

# Run the application
dotnet run

# Or with watch (auto-reload)
dotnet watch run
```

The API will be available at:
- HTTP: http://localhost:5000
- Swagger: http://localhost:5000/swagger

### Run with Docker

From the project root (not this directory):

```bash
# Build and run all services
docker-compose up --build

# Or run only the backend
docker-compose up backend
```

## Project Structure

```
backend/
├── Program.cs                    # Main application entry point
├── BackendApi.csproj            # Project file with dependencies
├── appsettings.json             # Base configuration
├── appsettings.Development.json # Development settings
├── appsettings.Production.json  # Production settings
├── Dockerfile                   # Docker build instructions
├── .dockerignore               # Docker ignore patterns
├── .gitignore                  # Git ignore patterns
└── README.md                   # This file
```

## Configuration

### Environment Variables

The application uses these environment variables:

- `ASPNETCORE_ENVIRONMENT` - Environment name (Development/Production)
- `ASPNETCORE_URLS` - URLs the app listens on (default: http://+:5000)

### Logging

Logging levels are configured in `appsettings.json`:
- **Development**: Information level for detailed debugging
- **Production**: Warning level for performance

## Building for Production

```bash
# Build
dotnet build -c Release

# Publish
dotnet publish -c Release -o ./publish
```

## Testing the API

### Using curl

```bash
# Test health
curl http://localhost:5000/api/health

# Test hello
curl http://localhost:5000/api/hello

# Test echo
curl -X POST http://localhost:5000/api/echo \
  -H "Content-Type: application/json" \
  -d '{"message":"Test"}'
```

### Using Swagger UI

1. Start the application
2. Navigate to http://localhost:5000/swagger
3. Try out the endpoints interactively

### From Next.js Frontend

The frontend has a "Test Backend API" button that calls `/api/hello` through the Nginx load balancer.

## Adding New Endpoints

To add a new endpoint, add it to `Program.cs`:

```csharp
app.MapGet("/api/your-endpoint", () =>
{
    return Results.Ok(new { message = "Your response" });
})
.WithName("YourEndpoint")
.WithOpenApi();
```

## CORS Configuration

CORS is configured to allow all origins, methods, and headers for development. For production, you should restrict this:

```csharp
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowFrontend", policy =>
    {
        policy.WithOrigins("https://your-frontend-domain.com")
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});
```

## Database Integration

To add a database:

1. Install Entity Framework Core:
```bash
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
```

2. Create your DbContext and models
3. Add connection string to appsettings.json
4. Register DbContext in Program.cs

## Authentication

To add JWT authentication:

```bash
dotnet add package Microsoft.AspNetCore.Authentication.JwtBearer
```

Then configure in Program.cs before `var app = builder.Build();`

## Troubleshooting

**Port 5000 already in use?**
```bash
# Change port in appsettings.json or use environment variable
ASPNETCORE_URLS=http://+:5001 dotnet run
```

**CORS errors?**
- Check that CORS policy is applied before routing
- Verify frontend origin is allowed
- Check browser console for specific error

**Connection refused from frontend?**
- Ensure backend container is running: `docker-compose ps`
- Check Nginx configuration points to correct service
- Verify Docker network connectivity

## Next Steps

1. ✅ Run the API: `dotnet run`
2. ✅ Test endpoints: http://localhost:5000/swagger
3. ✅ Run full stack: `docker-compose up --build`
4. 📝 Add your business logic
5. 🗄️ Add database integration
6. 🔐 Add authentication

## Learn More

- [.NET Documentation](https://docs.microsoft.com/en-us/dotnet/)
- [ASP.NET Core Documentation](https://docs.microsoft.com/en-us/aspnet/core/)
- [Minimal APIs](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/minimal-apis)
- [Docker with .NET](https://docs.microsoft.com/en-us/dotnet/core/docker/introduction)
