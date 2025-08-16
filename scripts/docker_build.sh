#!/bin/bash

# NMAP-AI Docker Build Script
# This script helps build and manage Docker images for NMAP-AI

set -e

# Configuration
IMAGE_NAME="yashabalam/nmap-ai"
DOCKERFILE="Dockerfile"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Help function
show_help() {
    echo "NMAP-AI Docker Build Script"
    echo ""
    echo "Usage: $0 [OPTIONS] [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  build-dev          Build development image"
    echo "  build-prod         Build production image"
    echo "  build-all          Build all images"
    echo "  push               Push images to Docker Hub"
    echo "  run-dev            Run development container"
    echo "  run-prod           Run production container"
    echo "  clean              Clean up Docker images and containers"
    echo "  test               Test Docker build"
    echo ""
    echo "Options:"
    echo "  --no-cache         Build without using cache"
    echo "  --platform ARCH    Build for specific platform (linux/amd64, linux/arm64)"
    echo "  --tag TAG          Use custom tag"
    echo "  --help             Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 build-dev                    # Build development image"
    echo "  $0 build-prod --no-cache        # Build production image without cache"
    echo "  $0 build-all --platform linux/amd64  # Build for specific platform"
    echo "  $0 push --tag v1.0.0            # Push with custom tag"
}

# Parse command line arguments
NO_CACHE=""
PLATFORM=""
CUSTOM_TAG=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --no-cache)
            NO_CACHE="--no-cache"
            shift
            ;;
        --platform)
            PLATFORM="--platform $2"
            shift 2
            ;;
        --tag)
            CUSTOM_TAG="$2"
            shift 2
            ;;
        --help)
            show_help
            exit 0
            ;;
        -*)
            log_error "Unknown option: $1"
            show_help
            exit 1
            ;;
        *)
            COMMAND="$1"
            shift
            ;;
    esac
done

# Check if Docker is available
check_docker() {
    if ! command -v docker &> /dev/null; then
        log_error "Docker is not installed or not in PATH"
        exit 1
    fi
    
    if ! docker info &> /dev/null; then
        log_error "Docker daemon is not running"
        exit 1
    fi
    
    log_info "Docker is available"
}

# Build development image
build_dev() {
    log_info "Building development image..."
    local tag="${CUSTOM_TAG:-dev}"
    docker build $NO_CACHE $PLATFORM --target development -t "$IMAGE_NAME:$tag" -f "$DOCKERFILE" .
    log_success "Development image built: $IMAGE_NAME:$tag"
}

# Build production image
build_prod() {
    log_info "Building production image..."
    local tag="${CUSTOM_TAG:-latest}"
    docker build $NO_CACHE $PLATFORM --target production -t "$IMAGE_NAME:$tag" -f "$DOCKERFILE" .
    log_success "Production image built: $IMAGE_NAME:$tag"
}

# Build base image for testing
build_base() {
    log_info "Building base image for testing..."
    docker build $NO_CACHE $PLATFORM --target base -t "$IMAGE_NAME:base" -f "$DOCKERFILE" .
    log_success "Base image built: $IMAGE_NAME:base"
}

# Build all images
build_all() {
    log_info "Building all images..."
    build_base
    build_dev
    build_prod
    log_success "All images built successfully"
}

# Push images to Docker Hub
push_images() {
    log_info "Pushing images to Docker Hub..."
    
    # Check if logged in to Docker Hub
    if ! docker info | grep -q "Username:"; then
        log_warning "Not logged in to Docker Hub. Please run: docker login"
        read -p "Continue anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
    
    local tag="${CUSTOM_TAG:-latest}"
    
    # Push latest/custom tag
    docker push "$IMAGE_NAME:$tag"
    log_success "Pushed $IMAGE_NAME:$tag"
    
    # Push dev tag if it exists
    if docker image inspect "$IMAGE_NAME:dev" &> /dev/null; then
        docker push "$IMAGE_NAME:dev"
        log_success "Pushed $IMAGE_NAME:dev"
    fi
}

# Run development container
run_dev() {
    log_info "Running development container..."
    docker run -it --rm \
        -p 8080:8080 \
        -v "$(pwd)/data:/app/data" \
        -v "$(pwd)/logs:/app/logs" \
        -v "$(pwd)/results:/app/results" \
        "$IMAGE_NAME:dev"
}

# Run production container
run_prod() {
    log_info "Running production container..."
    docker run -it --rm \
        -p 8080:8080 \
        -v "$(pwd)/data:/app/data" \
        -v "$(pwd)/logs:/app/logs" \
        -v "$(pwd)/results:/app/results" \
        "$IMAGE_NAME:latest"
}

# Clean up Docker images and containers
cleanup() {
    log_info "Cleaning up Docker resources..."
    
    # Remove stopped containers
    if [ "$(docker ps -aq -f status=exited)" ]; then
        docker rm $(docker ps -aq -f status=exited)
        log_success "Removed stopped containers"
    fi
    
    # Remove dangling images
    if [ "$(docker images -f dangling=true -q)" ]; then
        docker rmi $(docker images -f dangling=true -q)
        log_success "Removed dangling images"
    fi
    
    # Remove NMAP-AI images if requested
    read -p "Remove all NMAP-AI images? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if [ "$(docker images $IMAGE_NAME -q)" ]; then
            docker rmi $(docker images $IMAGE_NAME -q) || true
            log_success "Removed NMAP-AI images"
        fi
    fi
    
    log_success "Cleanup completed"
}

# Test Docker build
test_build() {
    log_info "Testing Docker build..."
    
    # Build base image
    build_base
    
    # Test if image runs
    log_info "Testing if image starts correctly..."
    if docker run --rm "$IMAGE_NAME:base" python --version; then
        log_success "Docker image test passed"
    else
        log_error "Docker image test failed"
        exit 1
    fi
}

# Main execution
main() {
    check_docker
    
    case "${COMMAND:-help}" in
        build-dev)
            build_dev
            ;;
        build-prod)
            build_prod
            ;;
        build-all)
            build_all
            ;;
        push)
            push_images
            ;;
        run-dev)
            run_dev
            ;;
        run-prod)
            run_prod
            ;;
        clean)
            cleanup
            ;;
        test)
            test_build
            ;;
        help|--help)
            show_help
            ;;
        *)
            log_error "Unknown command: ${COMMAND}"
            show_help
            exit 1
            ;;
    esac
}

# Run main function
main