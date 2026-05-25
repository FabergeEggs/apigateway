# KrakenD API Gateway Configuration

This repository contains configuration for the API Gateway service, which routes all queries from the frontend to all backend services.

## Configuration Features

### CORS (Cross-Origin Resource Sharing)
- **Allowed Methods**: GET, POST, PUT, DELETE, PATCH, OPTIONS
- **Allowed Headers**:
  - Origin
  - Content-Type
  - Authorization
  - Accept
  - X-Requested-With
- **Exposed Headers**: Set-Cookie
- **Credentials**: Enabled
- **Max Age**: 12 hours

### Header Forwarding
The gateway intelligently forwards headers based on endpoint requirements:
- **Authorization Header**: Passed to protected endpoints requiring JWT validation
- **Content-Type Header**: Forwarded to all endpoints that need it
- **Custom Headers**:
  - `X-User-Id`: User identifier from JWT token
  - `X-Username`: Username from JWT token
  - `X-User-Roles`: User roles from JWT token

### JWT Validation
Protected endpoints include JWT validation using RS256 algorithm with the Keycloak public key (JWKS endpoint).

### Output Encoding
All endpoints use `no-op` encoding, preserving the backend response format without transformation.

---

## Routes by Service

### Authentication Service (`http://auth-service:8000`)

| Endpoint | Method | Auth Required | Description |
|----------|--------|---------------|-------------|
| `/health` | GET | No | Health check endpoint |
| `/api/v1/auth/register` | POST | No | User registration |
| `/api/v1/auth/login` | POST | No | User login |
| `/api/v1/auth/forgot-password` | POST | No | Initiate password recovery |
| `/api/v1/auth/reset-password` | POST | No | Reset password with token |
| `/api/v1/auth/refresh` | POST | No | Refresh authentication token |
| `/api/v1/auth/logout` | POST | No | User logout |
| `/api/v1/auth/logout-all` | POST | Yes | Logout from all sessions |
| `/api/v1/auth/verify-email` | POST | No | Verify email address |

---

### Profile Service

| Endpoint | Method | Auth Required | Description |
|----------|--------|---------------|-------------|
| `/profile/{user_id}` | GET | Yes | Get user profile |
| `/profile/{user_id}` | PUT | Yes | Update user profile |
| `/profile/{user_id}` | DELETE | Yes | Delete user profile |

---

### Project Service (`http://project-service:8000`)

| Endpoint | Method | Auth Required | Description |
|----------|--------|---------------|-------------|
| `/project/health` | GET | Yes | Health check for project service |
| `/project` | POST | Yes | Create new project |
| `/project/batch` | POST | Yes | Batch operations on projects |
| `/project/{project_id}/info` | GET | Yes | Get project information |
| `/project/{project_id}/statistics` | GET | Yes | Get project statistics |
| `/project/{project_id}` | PUT | Yes | Update project |
| `/project/{project_id}/task` | POST | Yes | Create task in project |
| `/project/{project_id}/task/{task_id}` | GET | Yes | Get task details |
| `/project/{project_id}/task/{task_id}` | PUT | Yes | Update task |
| `/project/{project_id}/post` | POST | Yes | Create post in project |
| `/project/{project_id}/post/{post_id}` | GET | Yes | Get post details |
| `/project/{project_id}/post/{post_id}` | PUT | Yes | Update post |
| `/project/{project_id}/post/{post_id}` | DELETE | Yes | Delete post |
| `/project/{project_id}/member` | POST | Yes | Add project member |
| `/project/{project_id}/member/{user_id}` | DELETE | Yes | Remove project member |
| `/project/{project_id}/publications` | GET | Yes | Get project publications |
| `/project/profile/{profile_id}` | GET | Yes | Get project profile |

---

### Feed Service

| Endpoint | Method | Auth Required | Description |
|----------|--------|---------------|-------------|
| `/api/v1/feed/global` | GET | No | Get global feed |
| `/api/v1/feed` | GET | Yes | Get user personalized feed |
| `/api/v1/feed/projects/{project_id}` | GET | Yes | Get feed for specific project |

---

### Subscription Service

| Endpoint | Method | Auth Required | Description |
|----------|--------|---------------|-------------|
| `/api/v1/subscriptions` | GET | Yes | Get user subscriptions |
| `/api/v1/subscriptions` | POST | Yes | Create subscription |
| `/api/v1/subscriptions/{id}` | DELETE | Yes | Delete subscription |

---

### Media Service

| Endpoint | Method | Auth Required | Description |
|----------|--------|---------------|-------------|
| `/api/v1/media/me/uploads` | POST | Yes | Create media upload |
| `/api/v1/media/me/uploads/{upload_id}/complete` | POST | Yes | Complete media upload |
| `/api/v1/media/me/assets` | GET | Yes | List user media assets |
| `/api/v1/media/me/assets/{asset_id}` | GET | Yes | Get media asset details |
| `/api/v1/media/me/assets/{asset_id}` | DELETE | Yes | Delete media asset |