module "gke_cluster" {
  source = "./modules/gke-cluster"
  project_id = var.project_id
  region = var.region
  zone = var.zone
}

module "deployements" {
  source = "./modules/deployment-module"
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
  credentials = file("eval-terraform-ef799185e155.json")
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host  = "https://${module.gke_cluster.kubernetes_cluster_host}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke_cluster.kubernetes_cluster_ca_certificate)
}