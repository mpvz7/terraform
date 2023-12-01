resource "kubernetes_ingress_v1" "frontend-result" {
  metadata {
    name = "frontend-result"
  }
  spec {
    default_backend {
      service {
        name = "result"
        port {
          number = 5001
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "frontend-vote" {
  metadata {
    name = "frontend-vote"
  }
  spec {
    default_backend {
      service {
        name = "vote"
        port {
          number = 5000
        }
      }
    }
  }
}