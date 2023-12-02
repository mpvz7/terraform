variable "metada_name" {
  type = string
}

variable "metadata_label_app" {
  type = string
}

variable "replica" {
  type = number
}

variable "selector_label_app" {
  type = string
}

variable "template_metadata_app" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_image" {
  type = string
}

variable "container_port" {
  type = number
}

variable "port_name" {
  type = number
}


resource "kubernetes_deployment" "deployment_app" {
  metadata {
    name = var.metada_name
    labels = {
      app = var.metadata_label_app
    }
  }

  spec {
    replicas = var.replica
    selector {
      match_labels = {
        app = var.selector_label_app
      }
    }

    template {
      metadata {
        labels = {
          app = var.template_metadata_app
        }
      }

      spec {
        container {
          name  = var.container_name
          image = var.container_image

          port {
            container_port = var.container_port
            name = var.port_name
          }
        }
      }
    }
  }
}