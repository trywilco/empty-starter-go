# Go API Starter

A minimal Go development environment with PostgreSQL for building APIs and web applications.

## 🚀 Getting Started

This repository provides a clean foundation - perfect for starting any Go backend project!

### Quick Start

1. **Open in Codespace** or clone locally
2. **Start developing** 

   ```bash
   # The environment provides:
   # ✅ Go 1.21+ development container
   # ✅ PostgreSQL database server
   # ✅ Hot reload with Air
   # ✅ VS Code optimized setup

   # Start your application with hot reload
   air
   ```

### What's Included

This starter provides the essentials:

- **Go Development Environment**: Latest Go with development tools
- **PostgreSQL**: Database server ready for your schema
- **Hot Reload**: Automatic restart on code changes with Air
- **VS Code Integration**: Optimized extensions and settings

### Sample Application

The starter includes a minimal HTTP server (`main.go`):

- **GET /** - Simple welcome endpoint
- **Ready for expansion** - Add your routes, middleware, and logic

### Setting Up Your Database

PostgreSQL is installed and running with a default development setup:

**Default Database Credentials:**
- **Host**: `localhost`
- **Port**: `5432`
- **Database**: `app_db`
- **User**: `app_user`
- **Password**: `app_password`

```bash
# Connect to PostgreSQL with default credentials
psql -h localhost -U app_user -d app_db

# Or connect as postgres superuser to create additional databases
sudo -u postgres psql
```

**For production or custom setup:**
```sql
-- Create your own user and database
CREATE USER myapp_user WITH PASSWORD 'your_password';
CREATE DATABASE myapp_db OWNER myapp_user;
GRANT ALL PRIVILEGES ON DATABASE myapp_db TO myapp_user;
```

### Environment Setup

The default database connection is already configured in `main.go`. For custom setups, create your environment variables:

```bash
# Example for custom database setup
export POSTGRES_HOST=localhost
export POSTGRES_PORT=5432
export POSTGRES_DB=your_db_name
export POSTGRES_USER=your_user
export POSTGRES_PASSWORD=your_password
```

**Default connection string:**
```
host=localhost port=5432 user=app_user password=app_password dbname=app_db sslmode=disable
```

**Ready to build?** 
Start coding your Go application! 🚀
