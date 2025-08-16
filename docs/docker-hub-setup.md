# Docker Hub Publishing Setup

This document explains how to set up automated Docker image publishing to Docker Hub for the NMAP-AI project.

## Prerequisites

1. Docker Hub account (create at https://hub.docker.com/)
2. GitHub repository with proper permissions
3. Docker Hub repository created: `yashabalam/nmap-ai`

## Setting Up Docker Hub Repository

1. **Create Docker Hub Repository:**
   - Go to https://hub.docker.com/repositories
   - Click "Create Repository"
   - Repository name: `nmap-ai`
   - Namespace: `yashabalam`
   - Visibility: Public
   - Description: "AI-Powered Network Scanning & Automation Tool"

2. **Generate Access Token:**
   - Go to Account Settings > Security > Access Tokens
   - Click "New Access Token"
   - Description: "NMAP-AI GitHub Actions"
   - Permissions: Read, Write, Delete
   - Copy the generated token (save it securely)

## GitHub Secrets Configuration

Add the following secrets to your GitHub repository:

1. **Go to Repository Settings:**
   - Navigate to `https://github.com/yashab-cyber/nmap-ai/settings/secrets/actions`

2. **Add Secrets:**
   - `DOCKERHUB_USERNAME`: Your Docker Hub username (`yashabalam`)
   - `DOCKERHUB_TOKEN`: The access token generated in step 2 above

## Workflow Triggers

The Docker workflow will trigger on:

- **Push to main branch**: Creates `latest` tag
- **Push to develop branch**: Creates `dev` tag  
- **Release creation**: Creates version tags (e.g., `v1.0.0`, `1.0`, `1`)
- **Pull requests**: Builds but doesn't push

## Manual Building and Pushing

For manual operations, use the provided build script:

```bash
# Build development image
./scripts/docker_build.sh build-dev

# Build production image
./scripts/docker_build.sh build-prod

# Build all images
./scripts/docker_build.sh build-all

# Test build
./scripts/docker_build.sh test

# Push to Docker Hub (requires login)
docker login
./scripts/docker_build.sh push
```

## Docker Compose Usage

For local development:

```bash
# Development environment
docker-compose up nmap-ai

# Production environment
docker-compose --profile production up nmap-ai-prod

# Full stack with Redis and PostgreSQL
docker-compose --profile full up
```

## Image Tags and Variants

- `yashabalam/nmap-ai:latest` - Production image (built from main branch)
- `yashabalam/nmap-ai:dev` - Development image (built from develop branch)
- `yashabalam/nmap-ai:v1.0.0` - Version-specific tags (built from releases)
- `yashabalam/nmap-ai:sha-abc123` - Commit-specific tags

## Multi-Architecture Support

Images are built for:
- `linux/amd64` (Intel/AMD 64-bit)
- `linux/arm64` (ARM 64-bit, Apple M1/M2)

## Troubleshooting

### Docker Hub Login Issues

```bash
# Login to Docker Hub
docker login

# Verify login
docker info | grep Username
```

### Build Failures

```bash
# Test local build
./scripts/docker_build.sh test

# Build with no cache
./scripts/docker_build.sh build-prod --no-cache

# Check Docker daemon
docker info
```

### SSL Certificate Issues

The Dockerfile includes SSL certificate fixes:
- Updated CA certificates
- Trusted PyPI hosts
- SSL environment variables

### GitHub Actions Failures

1. Check that secrets are properly configured
2. Verify Docker Hub repository exists
3. Ensure access token has correct permissions
4. Check workflow logs for specific errors

## Security Considerations

1. **Never commit secrets** to the repository
2. **Use access tokens** instead of passwords
3. **Regularly rotate** Docker Hub tokens
4. **Monitor image vulnerabilities** using Docker Hub scanning
5. **Use multi-stage builds** to minimize attack surface

## Image Size Optimization

The Dockerfile uses multi-stage builds with:
- Base image with common dependencies
- Development stage with dev tools
- Production stage with minimal footprint

## Verification

After setup, verify the workflow by:

1. Creating a test commit to main branch
2. Checking GitHub Actions workflow execution
3. Verifying image appears in Docker Hub
4. Testing image pull: `docker pull yashabalam/nmap-ai:latest`

## Support

If you encounter issues:
1. Check GitHub Actions logs
2. Verify Docker Hub repository settings
3. Ensure all secrets are properly configured
4. Test local Docker build first

For additional help, create an issue in the GitHub repository.