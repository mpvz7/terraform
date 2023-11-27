# Redis Container
resource "docker_container" "redis_container" {
  name  = "redis"
  image = docker_image.redis.image_id

  networks_advanced {
    name = docker_network.back_network.name
  }
}

# DB Container
resource "docker_container" "db_container" {
  name  = "db"
  image = docker_image.db.image_id
  env = [
    "POSTGRES_USER=postgres",
    "POSTGRES_PASSWORD=postgres"
  ]

  networks_advanced {
    name = docker_network.back_network.name
  }
}

# Vote Container
resource "docker_container" "vote_container" {
  name  = "vote"
  image = docker_image.vote_app.image_id
  ports {
    internal = "80"
    external = "5000"
  }

  networks_advanced {
    name = docker_network.back_network.name
  }

  networks_advanced {
    name = docker_network.front_network.name
  }
}

# Result Container
resource "docker_container" "result_container" {
  name  = "result"
  image = docker_image.result_app.image_id
  ports {
    internal = "80"
    external = "5001"
  }

  networks_advanced {
    name = docker_network.back_network.name
  }
  networks_advanced {
    name = docker_network.front_network.name
  }
}

# Worker Container
resource "docker_container" "worker_container" {
  name  = "worker"
  image = docker_image.worker_app.image_id

  networks_advanced {
    name = docker_network.back_network.name
  }
}

# Seed Container
resource "docker_container" "seed_container" {
  name  = "seed-data"
  image = docker_image.seed_app.image_id

  networks_advanced {
    name = docker_network.front_network.name
  }

  labels = {
    "com.docker.compose.profile" = "seed"
  }
}