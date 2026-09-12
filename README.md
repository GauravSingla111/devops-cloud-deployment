# DevOps Cloud Deployment Demo

A containerized Flask application demonstrating a practical DevOps workflow using Git, Docker, GitHub Actions, GitHub Container Registry (GHCR), automated health checks, deployment automation, and version-based rollback.

## 🚀 Project Overview

This project demonstrates how application code can move from source control through an automated CI/CD pipeline and into a Docker-based deployment environment.

The project was designed as a practical demonstration of:

- Containerization
- CI/CD automation
- Docker image management
- Automated application health checks
- Container deployment
- Versioned releases
- Deployment rollback
- Basic production troubleshooting

---

## 🏗️ Architecture

```text
Developer
    │
    │ git push
    ▼
GitHub Repository
    │
    ▼
GitHub Actions
    │
    ├── Checkout source
    ├── Build Docker image
    ├── Start container
    ├── Health check
    └── Publish image
            │
            ▼
      GitHub Container Registry
            │
            │ docker pull
            ▼
       Docker Host
            │
            ▼
      Flask Application
            │
            ▼
       /health endpoint

---


## Deployment and Recovery

GHCR
  │
  ▼
deploy.ps1
  │
  ├── Pull latest image
  ├── Replace running container
  └── Health check
          │
          ▼
      Application

If a release needs to be reverted:

rollback.ps1 <VERSION>
          │
          ▼
   Pull known-good image
          │
          ▼
   Replace current container
          │
          ▼
      Health check


🛠️ Technologies

- Python / Flask
- Docker
- Git
- GitHub
- GitHub Actions
- GitHub Container Registry (GHCR)
- Linux-based CI runner
- CI/CD
- REST health checks

📁 Project Structure

devops-cloud-deployment/
│
├── .github/
│   └── workflows/
│       └── deploy.yml
│
├── app/
│   ├── app.py
│   └── requirements.txt
│
├── Dockerfile
├── deploy.ps1
├── rollback.ps1
├── .gitignore
└── README.md 

⚙️ Application
The Flask application exposes two endpoints.

Application
GET /

Displays:

Application status
Environment
Container hostname
Release information


Health Check
GET /health

Example response:

{
  "service": "devops-demo",
  "status": "healthy"
}

The health endpoint is used by the CI/CD pipeline and deployment scripts to verify that the application is responding successfully.

🔄 CI/CD Pipeline

The GitHub Actions workflow is triggered when code is pushed to the main branch or a pull request is created.

Pipeline stages
Git Push
   ↓
Checkout source code
   ↓
Build Docker image
   ↓
Run container
   ↓
Health check
   ↓
Login to GHCR
   ↓
Push versioned image
   ↓
Push latest image
Docker image tags

Each release is published using two tags:

latest
<Git commit SHA>

For example:

ghcr.io/<username>/devops-cloud-deployment:latest

ghcr.io/<username>/devops-cloud-deployment:<commit-sha>

Using Git commit SHA tags makes releases traceable and allows a known-good version to be restored.

🐳 Docker
Build locally
docker build -t devops-demo:1.0 .
Run locally
docker run -d \
  --name devops-demo \
  -p 8080:8080 \
  devops-demo:1.0
Check running containers
docker ps
View logs
docker logs devops-demo
Check application
curl http://localhost:8080/health
🚀 Deployment Automation

deploy.ps1 automates deployment of the latest container image from GHCR.

The script:

Pulls the latest Docker image
Removes the existing container
Starts the new container
Waits for application startup
Performs a health check
Displays application output if successful
Displays container logs if the health check fails

Run it with:

powershell -ExecutionPolicy Bypass -File .\deploy.ps1

Successful deployment:

Pulling latest image from GHCR...
Removing existing container...
Starting new container...
Running health check...
Deployment successful!
🔙 Rollback

The project supports rollback using immutable Git commit SHA image tags.

Example:

powershell -ExecutionPolicy Bypass -File .\rollback.ps1 182f48ba07fe33fe87975f4a0b01d41b1d711850

The rollback process:

Specify known-good SHA
        ↓
Pull image from GHCR
        ↓
Remove current container
        ↓
Start previous version
        ↓
Health check
        ↓
Rollback successful

This allows the deployment to return to a previously validated release.

🧪 Release Demonstration

The deployment workflow was tested using two application versions.

Version 1

Initial application release was deployed and validated.

Version 2

The application was modified and pushed to GitHub.

GitHub Actions then:

Built a new Docker image
Ran the health check
Published the new image to GHCR

The new version was deployed locally using:

powershell -ExecutionPolicy Bypass -File .\deploy.ps1
Rollback

The deployment was then rolled back to the previously validated Version 1 image using its Git SHA.

The rollback completed successfully and the application health check returned:

{
  "service": "devops-demo",
  "status": "healthy"
}
🔍 Troubleshooting Approach

The project follows a systematic Docker troubleshooting process.

1. Check running containers
docker ps
2. Check stopped containers
docker ps -a
3. Check application logs
docker logs <container>
4. Inspect container configuration
docker inspect <container>
5. Test application health
curl http://localhost:8080/health

This provides a simple troubleshooting sequence:

Container status
      ↓
Container logs
      ↓
Configuration
      ↓
Application health
🎯 Project Objectives

The project was built to demonstrate practical experience with:

Docker containerization
Git-based development workflows
CI/CD pipelines
Automated testing and health validation
Container registries
Deployment automation
Versioned releases
Rollback and recovery
Basic infrastructure troubleshooting
🔮 Future Improvements

Potential next steps include:

AWS EC2 deployment
Nginx reverse proxy
HTTPS/TLS
Gunicorn production WSGI server
Terraform infrastructure as code
Centralized logging
Application monitoring
Automated deployment to a cloud VM
Blue/green or rolling deployments
Automated rollback based on health checks
💡 Key Takeaway

This project demonstrates a complete development-to-deployment workflow:

Code
 ↓
Git
 ↓
GitHub
 ↓
GitHub Actions
 ↓
Docker Build
 ↓
Automated Health Check
 ↓
GHCR
 ↓
Docker Deployment
 ↓
Versioned Rollback