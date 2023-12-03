module "gke_cluster" {
  source = "./modules/gke-cluster"
  project_id = var.project_id
  region = var.region
  zone = var.zone
}

module "postgres_deployment" {
  source          = "./modules/deployment-module"
  deployment_name = "postgres"
  app_label       = "postgres"
  container_name  = "postgres"
  image           = "postgres:15-alpine"
  container_port  = 5432
  env_vars        = [
    { name = "POSTGRES_USER", value = "postgres" },
    { name = "POSTGRES_PASSWORD", value = "postgres" }
  ]
  volume_name     = "db-data"
  mount_path      = "/var/lib/postgresql/data"
}

module "redis_deployment" {
  source          = "./modules/deployment-module"
  deployment_name = "redis"
  app_label       = "redis"
  container_name  = "redis"
  image           = "redis:alpine"
  container_port  = 6379
  volume_name     = "redis-data"
  mount_path      = "/data"
}

module "result_deployment" {
  source          = "./modules/deployment-module"
  deployment_name = "result"
  app_label       = "result"
  container_name  = "result"
  image           = "dockersamples/examplevotingapp_result"
  container_port  = 80
}

module "vote_deployment" {
  source          = "./modules/deployment-module"
  deployment_name = "vote"
  app_label       = "vote"
  container_name  = "vote"
  image           = "dockersamples/examplevotingapp_vote"
  container_port  = 80
}

module "worker_deployment" {
  source          = "./modules/deployment-module"
  deployment_name = "worker"
  app_label       = "worker"
  container_name  = "worker"
  image           = "dockersamples/examplevotingapp_worker"
}


module "services" {
  source = "./modules/service-module"
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.6.0" 
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.23.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  credentials = file(var.credentials)
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host  = "https://${module.gke_cluster.kubernetes_cluster_host}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke_cluster.kubernetes_cluster_ca_certificate)
}