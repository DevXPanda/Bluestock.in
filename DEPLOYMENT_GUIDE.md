# Vercel Deployment Guide - Bluestock Project

## Prerequisites
- Vercel account
- GitHub repository connected to Vercel
- PostgreSQL database (can be hosted on Vercel Postgres, Supabase, or any cloud provider)

## Step 1: Backend Deployment

### 1.1 Connect Backend to Vercel
1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Click "New Project"
3. Import your GitHub repository
4. Select the `backend` folder as the root directory
5. Configure the following settings:
   - **Framework Preset**: Node.js
   - **Root Directory**: `backend`
   - **Build Command**: `npm run build`
   - **Output Directory**: (leave empty for Node.js)
   - **Install Command**: `npm install`

### 1.2 Configure Environment Variables
In your Vercel project settings, add the following environment variables:

```bash
# Database Configuration
PG_HOST=your_postgres_host
PG_PORT=5432
PG_DATABASE=your_database_name
PG_USER=your_username
PG_PASSWORD=your_password

# Authentication
COOKIE_SECRET=your_secure_cookie_secret
JWT_SECRET=your_secure_jwt_secret

# Server Configuration
NODE_ENV=production

# CORS Configuration (update with your frontend URL)
CLIENT_URL=https://your-frontend-domain.vercel.app
```

### 1.3 Deploy Backend
1. Commit and push your changes to GitHub
2. Vercel will automatically trigger a new deployment
3. Monitor the deployment logs for any errors
4. Note the deployment URL (e.g., `https://your-backend.vercel.app`)

## Step 2: Frontend Deployment

### 2.1 Connect Frontend to Vercel
1. Create a new Vercel project for the frontend
2. Import the same GitHub repository
3. Select the `frontend` folder as the root directory
4. Configure the following settings:
   - **Framework Preset**: Vite
   - **Root Directory**: `frontend`
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`
   - **Install Command**: `npm install`

### 2.2 Update API Base URL
Before deploying, update the API base URL in your frontend code to point to your new backend URL:

```javascript
// In your API calls, update the base URL
const API_BASE_URL = 'https://your-backend.vercel.app/api';
```

### 2.3 Configure Environment Variables (if needed)
If you have any frontend environment variables, add them in Vercel:

```bash
VITE_API_BASE_URL=https://your-backend.vercel.app/api
VITE_GOOGLE_CLIENT_ID=your_google_client_id
```

### 2.4 Deploy Frontend
1. Commit and push your changes
2. Vercel will automatically deploy the frontend
3. Note the frontend URL (e.g., `https://your-frontend.vercel.app`)

## Step 3: Update CORS Configuration

### 3.1 Update Backend CORS
In your `backend/App.js`, update the CORS origin to match your frontend URL:

```javascript
const corsOptions = {
    origin: "https://your-frontend-domain.vercel.app",
    credentials: true,
    methods: ["GET", "POST", "DELETE", "PUT", "PATCH"],
    allowedHeaders: ["Content-Type", "X-Client-Platform", "Authorization"],
};
```

### 3.2 Redeploy Backend
After updating the CORS configuration, redeploy the backend to apply the changes.

## Step 4: Database Setup

### 4.1 PostgreSQL Database
Ensure your PostgreSQL database is accessible from Vercel:
- Use a cloud database service (Vercel Postgres, Supabase, AWS RDS, etc.)
- Configure the database connection string in environment variables
- Ensure the database is in the same region as your Vercel deployment for better performance

### 4.2 Database Migration
If you need to run database migrations, you can add a build script:

```json
{
    "scripts": {
        "vercel-build": "node Model/init.js && echo 'Database initialized'"
    }
}
```

## Step 5: Testing Deployment

### 5.1 Test Backend API
1. Test the health endpoint: `https://your-backend.vercel.app/`
2. Test authentication endpoints
3. Verify CORS is working correctly

### 5.2 Test Frontend
1. Visit your frontend URL
2. Test user registration and login
3. Test job posting and application features
4. Verify all API calls are working

## Step 6: Custom Domain (Optional)

### 6.1 Add Custom Domain
1. In Vercel dashboard, go to your project settings
2. Navigate to "Domains"
3. Add your custom domain
4. Configure DNS settings as instructed by Vercel

### 6.2 Update Environment Variables
After adding custom domains, update your environment variables:
- Update `CLIENT_URL` in backend
- Update API base URLs in frontend

## Troubleshooting

### Common Issues

1. **CORS Errors**
   - Ensure CORS origin is correctly set
   - Check that credentials are enabled
   - Verify the frontend URL is exact

2. **Database Connection Issues**
   - Verify database credentials
   - Check if database is accessible from Vercel
   - Ensure SSL is configured if required

3. **Build Failures**
   - Check build logs in Vercel dashboard
   - Verify all dependencies are in package.json
   - Ensure Node.js version is compatible

4. **Environment Variables**
   - Double-check all environment variables are set
   - Ensure no typos in variable names
   - Verify sensitive data is properly secured

### Performance Optimization

1. **Database Connection Pooling**
   - Your current setup already uses connection pooling
   - Monitor database performance in production

2. **Caching**
   - Consider adding Redis for session storage
   - Implement API response caching

3. **CDN**
   - Vercel automatically provides CDN for static assets
   - Optimize images and assets for faster loading

## Monitoring and Maintenance

### 1. Vercel Analytics
- Enable Vercel Analytics for performance monitoring
- Monitor API response times
- Track user engagement

### 2. Error Monitoring
- Set up error tracking (Sentry, LogRocket, etc.)
- Monitor server logs in Vercel dashboard
- Set up alerts for critical errors

### 3. Regular Updates
- Keep dependencies updated
- Monitor security vulnerabilities
- Regular database backups

## Rollback Strategy

If deployment fails:
1. Use Vercel's automatic rollback feature
2. Check deployment logs for specific errors
3. Fix issues in development
4. Redeploy with corrected code

## Security Checklist

- [ ] Environment variables are properly set
- [ ] Database credentials are secure
- [ ] CORS is properly configured
- [ ] JWT secrets are strong and unique
- [ ] HTTPS is enforced
- [ ] Rate limiting is implemented (if needed)
- [ ] Input validation is working
- [ ] Authentication is properly tested 