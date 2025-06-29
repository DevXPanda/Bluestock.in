# Bluestock Project - Job Portal Index

## Project Overview
**Bluestock Project** is a full-stack job portal application built with React (frontend) and Node.js/Express (backend). The application allows users to post jobs, apply for positions, and manage job applications with role-based access control.

**Live Demo:** [Frontend](https://hunter-iota.vercel.app/) | [Backend](https://job-portal-server-theta-olive.vercel.app/)

## Technology Stack

### Frontend
- **Framework:** React 18.2.0 with Vite
- **Routing:** React Router DOM 6.18.0
- **State Management:** React Context API + TanStack Query
- **Styling:** Tailwind CSS + Styled Components
- **HTTP Client:** Axios
- **Authentication:** Firebase Auth (Google OAuth)
- **UI Components:** React Icons, React DatePicker, SweetAlert2
- **Charts:** Recharts for statistics

### Backend
- **Runtime:** Node.js with Express.js
- **Database:** PostgreSQL with connection pooling
- **Authentication:** JWT + Cookie-based sessions
- **Password Hashing:** bcrypt
- **Validation:** express-validator
- **CORS:** Configured for cross-origin requests
- **Deployment:** Vercel

## Project Structure

```
Bluestock Project/
├── backend/                 # Node.js/Express API server
│   ├── App.js              # Express app configuration
│   ├── Server.js           # Server entry point
│   ├── Controller/         # Business logic handlers
│   ├── Model/              # Database models and queries
│   ├── Router/             # API route definitions
│   ├── Middleware/         # Custom middleware
│   ├── Validation/         # Input validation rules
│   ├── Utils/              # Utility functions
│   └── public/             # Static assets
└── frontend/               # React application
    ├── src/
    │   ├── components/     # Reusable UI components
    │   ├── pages/          # Page components
    │   ├── context/        # React Context providers
    │   ├── Layout/         # Layout components
    │   ├── Router/         # Routing configuration
    │   ├── utils/          # Utility functions
    │   └── assets/         # Static assets
    └── public/             # Public assets
```

## Database Schema

### Core Tables
1. **users** - User accounts and profiles
   - Supports email/password and Google OAuth
   - Role-based access (Admin=1, Recruiter=2, User=3)
   - Profile information (name, photo, location, etc.)

2. **jobs** - Job postings
   - Company, position, location, salary
   - Job type (full-time, part-time, internship, contract)
   - Skills and facilities arrays
   - Visibility status for admin approval

3. **applications** - Job applications
   - Links users to jobs
   - Application status tracking

4. **education** - User education records
   - Educational background for profiles

## API Endpoints

### Authentication (`/api/auth`)
- `POST /register` - User registration
- `POST /login` - User login
- `POST /logout` - User logout
- `GET /me` - Get current user
- `POST /google` - Google OAuth authentication

### Jobs (`/api/jobs`)
- `GET /` - Get all jobs (with pagination/filtering)
- `POST /` - Create new job (Recruiter only)
- `GET /my-jobs` - Get jobs by current user
- `GET /review` - Get jobs for admin review
- `GET /:id` - Get single job
- `PATCH /:id` - Update job (Recruiter only)
- `DELETE /:id` - Delete job
- `PATCH /:id/status` - Update job status (Admin only)

### Users (`/api/users`)
- `GET /` - Get all users (Admin only)
- `PATCH /:id` - Update user profile
- `DELETE /:id` - Delete user (Admin only)

### Applications (`/api/application`)
- `POST /` - Apply for a job
- `GET /` - Get applications (filtered by role)

### Education (`/api/education`)
- `POST /` - Add education record
- `GET /` - Get education records
- `PATCH /:id` - Update education record
- `DELETE /:id` - Delete education record

### Admin (`/api/admin`)
- `GET /stats` - Get dashboard statistics
- `GET /users` - Get all users
- `GET /jobs` - Get all jobs for management

## User Roles & Permissions

### Admin (Role: 1)
- Full system access
- Manage all users and jobs
- Approve/reject job postings
- View system statistics
- Delete any content

### Recruiter (Role: 2)
- Create and manage job postings
- View applications for their jobs
- Update job details
- Delete their own jobs

### User (Role: 3)
- Browse and search jobs
- Apply for jobs
- Manage profile and education
- View application status

## Key Features

### Frontend Features
1. **Responsive Design** - Mobile-first approach with Tailwind CSS
2. **Role-based UI** - Different interfaces for different user types
3. **Job Search & Filtering** - Advanced search with multiple filters
4. **Real-time Updates** - React Query for data synchronization
5. **Google OAuth** - Seamless authentication
6. **Dashboard Analytics** - Charts and statistics for admins
7. **Form Validation** - Client-side validation with React Hook Form

### Backend Features
1. **Secure Authentication** - JWT + HTTP-only cookies
2. **Input Validation** - Server-side validation with express-validator
3. **Role-based Authorization** - Middleware for route protection
4. **Database Connection Pooling** - Efficient PostgreSQL connections
5. **Error Handling** - Comprehensive error management
6. **CORS Configuration** - Secure cross-origin requests
7. **File Upload Support** - Profile photos and resumes

## Security Features
- Password hashing with bcrypt
- JWT token authentication
- HTTP-only cookies for session management
- Input validation and sanitization
- Role-based access control
- CORS protection
- SQL injection prevention with parameterized queries

## Deployment
- **Frontend:** Deployed on Vercel
- **Backend:** Deployed on Vercel
- **Database:** PostgreSQL (likely on a cloud provider)
- **Environment Variables:** Configured for production

## Development Setup

### Backend Setup
```bash
cd backend
npm install
# Create .env file with required variables
npm run dev
```

### Frontend Setup
```bash
cd frontend
npm install
npm run dev
```

### Environment Variables (Backend)
```
PG_HOST=your_postgres_host
PG_PORT=5432
PG_DATABASE=your_database_name
PG_USER=your_username
PG_PASSWORD=your_password
COOKIE_SECRET=your_cookie_secret
JWT_SECRET=your_jwt_secret
```

## Test Credentials
- **Recruiter:** recruiter1@gmail.com / Recruiter1#123456
- **User:** user1@gmail.com / User1#123456

## Key Components

### Frontend Components
- **DashboardLayout** - Main dashboard wrapper
- **JobCard** - Individual job display component
- **SearchAndFilter** - Job search functionality
- **PaginationCom** - Pagination controls
- **ApplicantProfileModal** - Applicant details modal
- **Stats** - Admin dashboard statistics

### Backend Controllers
- **UserController** - User management and authentication
- **JobController** - Job CRUD operations
- **ApplicationController** - Application management
- **AdminController** - Admin-specific operations
- **EducationController** - Education record management

## Performance Optimizations
- Database connection pooling
- React Query for caching and background updates
- Lazy loading of components
- Optimized database queries
- Static asset optimization

## Future Enhancements
- Email notifications
- Real-time chat between applicants and recruiters
- Advanced analytics and reporting
- Mobile app development
- Integration with job boards
- Resume parsing and matching 