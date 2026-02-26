export async function GET() {
  try {
    // Call the .NET backend through the Nginx load balancer
    // In Docker, 'nginx' is the service name from docker-compose.yml
    const backendUrl = process.env.BACKEND_URL || 'http://backend:5000';
    
    const response = await fetch(`${backendUrl}/api/hello`);
    
    if (!response.ok) {
      throw new Error(`Backend responded with status: ${response.status}`);
    }
    
    const data = await response.json();
    
    return Response.json({
      success: true,
      message: 'Successfully connected to .NET backend!',
      backend: data,
      connectedAt: new Date().toISOString()
    });
    
  } catch (error) {
    return Response.json(
      { 
        success: false, 
        error: error.message,
        note: 'Make sure the backend container is running'
      },
      { status: 500 }
    );
  }
}
