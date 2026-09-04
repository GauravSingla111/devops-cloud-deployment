# AWS Docker CI/CD Deployment & Operations Demo

## Overview

A hands-on DevOps project demonstrating containerized application deployment, CI/CD automation, Linux-based operations, and application health monitoring.

The project simulates a production deployment workflow where application changes are automatically tested, containerized, and validated through GitHub Actions.

## Architecture

Developer
↓
GitHub
↓
GitHub Actions
↓
Docker Build
↓
Container
↓
Health Check

## Technologies

- Python / Flask
- Docker
- Git
- GitHub
- GitHub Actions
- Linux
- AWS EC2
- Nginx
- CI/CD
- HTTP health checks

## Application

The application provides:

- Web interface
- Environment information
- Container hostname
- Health check endpoint

Health endpoint:

`GET /health`

Example response:

```json
{
  "service": "devops-demo",
  "status": "healthy"
}