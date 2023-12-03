variable "deployment_name" {
  description = "The name of the deployment"
  type        = string
}

variable "app_label" {
  description = "Label to assign to the app"
  type        = string
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "image" {
  description = "Container image"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
  default = null
}

variable "env_vars" {
  description = "List of environment variables"
  type        = list(map(string))
  default     = []
}

variable "volume_name" {
  description = "Name of the volume"
  type        = string
  default     = ""
}

variable "mount_path" {
  description = "Path to mount the volume"
  type        = string
  default     = ""
}

resource "kubernetes_deployment" "app" {
  metadata {
    name   = var.deployment_name
    labels = {
      app = var.app_label
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = var.app_label
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_label
        }
      }

      spec {
        container {
          name  = var.container_name
          image = var.image

          dynamic "env" {
            for_each = var.env_vars
            content {
              name  = env.value["name"]
              value = env.value["value"]
            }
          }

          port {
            container_port = var.container_port
          }

          volume_mount {
            mount_path = var.mount_path
            name       = var.volume_name
          }
        }

        volume {
          name = var.volume_name
          empty_dir {}
        }
      }
    }
  }
}
