$Image = "ghcr.io/gauravsingla111/devops-cloud-deployment:latest"
$Container = "devops-demo"

Write-Host "=== Starting deployment ==="

Write-Host "Pulling latest image from GHCR..."
docker pull $Image

if ($LASTEXITCODE -ne 0) {
    Write-Host "Image pull failed!"
    exit 1
}

Write-Host "Removing existing container..."
docker rm -f $Container 2>$null

Write-Host "Starting new container..."
docker run -d `
    --name $Container `
    -p 8080:8080 `
    $Image

if ($LASTEXITCODE -ne 0) {
    Write-Host "Container failed to start!"
    exit 1
}

Write-Host "Waiting for application..."
Start-Sleep -Seconds 5

Write-Host "Running health check..."

try {
    $response = Invoke-WebRequest `
        -Uri "http://localhost:8080/health" `
        -UseBasicParsing

    if ($response.StatusCode -eq 200) {
        Write-Host "Deployment successful!"
        Write-Host $response.Content
    }
}
catch {
    Write-Host "Health check failed!"
    docker logs $Container
    exit 1
}