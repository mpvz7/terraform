# Redis Image
resource "docker_image" "redis" {
  name = "docker.io/redis:alpine"
}

# Database - Postgres Image
resource "docker_image" "db" {
  name = "docker.io/postgres:15-alpine"
}

# Vote Application Image
resource "docker_image" "vote_app" {
  name = "vote_app"
  build {
    context = "./vote"
  }
}

# Result Application Image
resource "docker_image" "result_app" {
  name = "result_app"
  build {
    context = "./result"
  }
}

# Worker Application Image
resource "docker_image" "worker_app" {
  name = "worker_app"
  build {
    context = "./worker"
  }
}