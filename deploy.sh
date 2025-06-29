#!/bin/bash

# Bluestock Project - Vercel Deployment Script
# This script helps automate the deployment process

echo "🚀 Starting Bluestock Project Deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    print_error "Vercel CLI is not installed. Please install it first:"
    echo "npm install -g vercel"
    exit 1
fi

# Check if user is logged in to Vercel
if ! vercel whoami &> /dev/null; then
    print_warning "You are not logged in to Vercel. Please login first:"
    vercel login
fi

print_status "Checking project structure..."

# Check if backend and frontend directories exist
if [ ! -d "backend" ]; then
    print_error "Backend directory not found!"
    exit 1
fi

if [ ! -d "frontend" ]; then
    print_error "Frontend directory not found!"
    exit 1
fi

print_success "Project structure verified"

# Function to deploy backend
deploy_backend() {
    print_status "Deploying backend..."
    
    cd backend
    
    # Check if .vercel directory exists (already linked)
    if [ -d ".vercel" ]; then
        print_status "Backend already linked to Vercel. Deploying..."
        vercel --prod
    else
        print_status "Linking backend to Vercel..."
        vercel
        print_status "Deploying backend to production..."
        vercel --prod
    fi
    
    cd ..
    print_success "Backend deployment completed"
}

# Function to deploy frontend
deploy_frontend() {
    print_status "Deploying frontend..."
    
    cd frontend
    
    # Check if .vercel directory exists (already linked)
    if [ -d ".vercel" ]; then
        print_status "Frontend already linked to Vercel. Deploying..."
        vercel --prod
    else
        print_status "Linking frontend to Vercel..."
        vercel
        print_status "Deploying frontend to production..."
        vercel --prod
    fi
    
    cd ..
    print_success "Frontend deployment completed"
}

# Function to update environment variables
update_env_vars() {
    print_status "Updating environment variables..."
    
    echo "Please provide the following information for your deployment:"
    
    read -p "Backend Vercel URL (e.g., https://your-backend.vercel.app): " BACKEND_URL
    read -p "Frontend Vercel URL (e.g., https://your-frontend.vercel.app): " FRONTEND_URL
    read -p "Database Host: " DB_HOST
    read -p "Database Name: " DB_NAME
    read -p "Database User: " DB_USER
    read -p "Database Password: " DB_PASSWORD
    read -p "JWT Secret: " JWT_SECRET
    read -p "Cookie Secret: " COOKIE_SECRET
    
    print_status "Setting backend environment variables..."
    cd backend
    vercel env add PG_HOST "$DB_HOST"
    vercel env add PG_DATABASE "$DB_NAME"
    vercel env add PG_USER "$DB_USER"
    vercel env add PG_PASSWORD "$DB_PASSWORD"
    vercel env add JWT_SECRET "$JWT_SECRET"
    vercel env add COOKIE_SECRET "$COOKIE_SECRET"
    vercel env add CLIENT_URL "$FRONTEND_URL"
    vercel env add NODE_ENV "production"
    cd ..
    
    print_status "Setting frontend environment variables..."
    cd frontend
    vercel env add VITE_API_BASE_URL "$BACKEND_URL/api"
    cd ..
    
    print_success "Environment variables updated"
}

# Main deployment flow
main() {
    echo "Choose deployment option:"
    echo "1) Deploy Backend Only"
    echo "2) Deploy Frontend Only"
    echo "3) Deploy Both (Backend + Frontend)"
    echo "4) Update Environment Variables"
    echo "5) Full Deployment (Backend + Frontend + Environment Variables)"
    
    read -p "Enter your choice (1-5): " choice
    
    case $choice in
        1)
            deploy_backend
            ;;
        2)
            deploy_frontend
            ;;
        3)
            deploy_backend
            deploy_frontend
            ;;
        4)
            update_env_vars
            ;;
        5)
            update_env_vars
            deploy_backend
            deploy_frontend
            ;;
        *)
            print_error "Invalid choice. Please run the script again."
            exit 1
            ;;
    esac
    
    print_success "Deployment process completed!"
    echo ""
    print_status "Next steps:"
    echo "1. Test your deployed application"
    echo "2. Update CORS settings if needed"
    echo "3. Monitor deployment logs in Vercel dashboard"
    echo "4. Set up custom domains if required"
}

# Run main function
main 