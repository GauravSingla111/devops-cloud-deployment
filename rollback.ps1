param(
    [Parameter(Mandatory=$true)]
    [string]$Version
)

$Container = "devops-demo"
$Image = "ghcr.io/gauravsingla111/devops-cloud-deployment:$Version"

Write-Host "=== Starting rollback ==="
Write-Host "Target version: $Version"

Write-Host "Pulling image from GHCR..."
docker pull $Image

if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to pull image!"
    exit 1
}

Write-Host "Removing current container..."
docker rm -f $Container 2>$null

Write-Host "Starting rollback version..."
docker run -d `
    --name $Container `
    -p 8080:8080 `
    $Image

if ($LASTEXITCODE -ne 0) {
    Write-Host "Rollback failed!"
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
        Write-Host "Rollback successful!"
        Write-Host $response.Content
    }
}
catch {
    Write-Host "Rollback health check failed!"
    docker logs $Container
    exit 1
}