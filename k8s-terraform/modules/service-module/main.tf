variable "metadata_name" {
  type = string
}

variable "metadata_label_app" {
  type = string
}

variable "selector_app" {
  type = string
}

variable "port_name" {
  type = string
}

variable "port_number" {
  type = number
}

variable "target_port" {
  type = number
}

variable "node_port" {
  type = number
}
 
variable "type" {
  type = string
}

resource "kubernetes_service" "services_app" {
  metadata {
    name = var.metadata_name
    labels = {
      app = var.metadata_label_app
    }
  }

  spec {
    selector = {
      app = var.selector_app
    }

    port {
      port        = var.port
      target_port = var.target_port
      name        = var.port_name
      node_port   = var.node_port
    }

    type = var.type
  }
}
