var builder = WebApplication.CreateBuilder(args);

// Add services to the container
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Add CORS policy to allow frontend access
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowFrontend", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});

var app = builder.Build();

// Configure the HTTP request pipeline
if (app.Environment.IsDevelopment() || app.Environment.IsProduction())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("AllowFrontend");

// Health check endpoint
app.MapGet("/api/health", () =>
{
    return Results.Ok(new
    {
        status = "healthy",
        service = ".NET Backend API",
        timestamp = DateTime.UtcNow,
        environment = app.Environment.EnvironmentName
    });
})
.WithName("Health")
.WithOpenApi();

// Hello endpoint
app.MapGet("/api/hello", () =>
{
    return Results.Ok(new
    {
        message = "Hello from .NET Backend!",
        timestamp = DateTime.UtcNow,
        version = "1.0.0",
        framework = ".NET 8.0"
    });
})
.WithName("GetHello")
.WithOpenApi();

// Get current time endpoint
app.MapGet("/api/time", () =>
{
    return Results.Ok(new
    {
        utc = DateTime.UtcNow,
        local = DateTime.Now,
        timezone = TimeZoneInfo.Local.DisplayName
    });
})
.WithName("GetTime")
.WithOpenApi();

// Echo endpoint - returns what you send
app.MapPost("/api/echo", (EchoRequest request) =>
{
    return Results.Ok(new
    {
        received = request.Message,
        length = request.Message?.Length ?? 0,
        timestamp = DateTime.UtcNow,
        echo = $"You said: {request.Message}"
    });
})
.WithName("PostEcho")
.WithOpenApi();

// Root endpoint
app.MapGet("/", () => 
{
    return Results.Ok(new
    {
        service = ".NET Backend API",
        status = "running",
        endpoints = new[]
        {
            "/api/health - Health check",
            "/api/hello - Hello message",
            "/api/time - Current time",
            "/api/echo - Echo your message (POST)",
            "/swagger - API documentation"
        }
    });
});

Console.WriteLine("🚀 .NET Backend API is starting...");
Console.WriteLine($"Environment: {app.Environment.EnvironmentName}");
Console.WriteLine("Listening on port 5000");

app.Run();

// Request models
public record EchoRequest(string? Message);
