# Django Notes App — Containerized & DevOps-Ready

A full-stack Notes application (React + Django REST Framework + MySQL), rebuilt from the ground up with a hand-written DevOps pipeline — Docker multi-stage builds, Docker Compose orchestration, Nginx reverse proxy, and Jenkins CI.

This project started from the base application code in [LondheShubham153/django-notes-app](https://github.com/LondheShubham153/django-notes-app), with the entire containerization and CI/CD pipeline rebuilt independently as a deep-dive DevOps learning exercise — not copy-pasted from the original repo's Docker/Jenkins setup.

## Tech Stack

- **Frontend:** React
- **Backend:** Django REST Framework
- **Database:** MySQL 8.0
- **Web Server / Reverse Proxy:** Nginx
- **Containerization:** Docker (multi-stage builds)
- **Orchestration (local):** Docker Compose
- **CI:** Jenkins
- **Planned:** Kubernetes + Helm, ArgoCD (GitOps CD)

## Architecture

```
                        ┌────────────┐
   Browser  ──────────► │   Nginx    │  (port 80)
                        └─────┬──────┘
                  ┌───────────┼───────────┐
                  │                       │
           /api/, /admin/                 /
                  │                       │
           ┌──────▼──────┐        ┌───────▼───────┐
           │  django_app  │        │   frontend    │
           │  (Gunicorn)  │        │ (React, serve)│
           └──────┬───────┘        └───────────────┘
                  │
           ┌──────▼──────┐
           │      db      │
           │  (MySQL 8.0) │
           └──────────────┘
```

Each component runs in its own container, connected over a shared Docker network (`notes-app-nw`). Nginx is the single entry point — all traffic is routed to the frontend or backend based on the URL path.

## Features

- Full CRUD notes API (Django REST Framework)
- React frontend served independently of the backend
- MySQL persistence with a named Docker volume
- Multi-stage Docker builds for smaller, cleaner production images
- Health checks on backend and database containers
- Jenkins pipeline for automated image build and push to Docker Hub

## Getting Started

### Prerequisites

- Docker & Docker Compose
- A Docker Hub account (if you plan to push images)

### Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/AdityaShekhawatdev/DJANGO_NOTES_APP.git
   cd DJANGO_NOTES_APP
   ```

2. Create a `.env` file in the project root with the following variables:
   ```
   DB_NAME=your_db_name
   DB_USER=your_db_user
   DB_PASSWORD=your_db_password
   DB_HOST=db
   DB_PORT=3306
   ```

3. Build and start all services:
   ```bash
   docker-compose up --build -d
   ```

4. Access the app:
   - App (via Nginx): `http://localhost`
   - Backend API directly: `http://localhost:8000/api/notes/`
   - Django admin: `http://localhost/admin/`

### Useful Commands

```bash
# View running containers
docker-compose ps

# View logs for a specific service
docker-compose logs -f django_app

# Run Django migrations manually (if needed)
docker exec -it django_cont python manage.py migrate

# Stop and remove all containers
docker-compose down

# Stop and remove all containers + volumes (fresh DB)
docker-compose down -v
```

## CI/CD

A Jenkins pipeline (`Jenkinsfile`) builds the backend Docker image and pushes it to Docker Hub on each run. Kubernetes/Helm deployment and ArgoCD-based GitOps delivery are planned as the next phase.

## Project Structure

```
.
├── api/                  # Django REST app (models, views, serializers)
├── notesapp/             # Django project settings
├── mynotes/               # React frontend source
├── nginx/                 # Nginx config + Dockerfile
├── Dockerfile             # Backend multi-stage build
├── docker-compose.yml
├── Jenkinsfile
└── requirements.txt
```

## Acknowledgements

Base application code adapted from [LondheShubham153/django-notes-app](https://github.com/LondheShubham153/django-notes-app). All Docker, Compose, Nginx, and CI configuration in this repository was written independently as a self-learning DevOps exercise.
