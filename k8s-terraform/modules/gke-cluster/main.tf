variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "zone" {
  description = "zone"
}

resource "google_compute_network" "myvpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "mysubnet" {
  name          = "${var.project_id}-subnet"
  region        = var.region
  network       = google_compute_network.myvpc.name
  ip_cidr_range = "10.10.0.0/24"
}

resource "google_container_cluster" "mycluster" {
  name     = "${var.project_id}-gke"
  location = var.region

  remove_default_node_pool = false
  initial_node_count       = 1

  network    = google_compute_network.myvpc.name
  subnetwork = google_compute_subnetwork.mysubnet.name
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.mycluster.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.mycluster.endpoint
  description = "GKE Cluster Host"
}

output "kubernetes_cluster_ca_certificate" {
  value = google_container_cluster.mycluster.master_auth[0].cluster_ca_certificate
}