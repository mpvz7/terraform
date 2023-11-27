terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

resource "docker_network" "back_network" {
    name = "back-tier"
}

resource "docker_network" "front_network" {
    name = "front-tier"
}

output "vote_app_endpoint" {
  value = "http://localhost:${docker_container.vote_container.ports[0].external}"
  description = "The URL endpoint to access the Vote application"
}

output "result_app_endpoint" {
  value = "http://localhost:${docker_container.result_container.ports[0].external}"
  description = "The URL endpoint to access the Result application"
}