resource "kubernetes_deployment" "postgres" {
  metadata {
    name = "postgres"
    labels = {
      app = "postgres"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "postgres"
      }
    }

    template {
      metadata {
        labels = {
          app = "postgres"
        }
      }

      spec {
        container {
          name  = "postgres"
          image = "postgres:15-alpine"

          env {
            name  = "POSTGRES_USER"
            value = "postgres"
          }

          env {
            name  = "POSTGRES_PASSWORD"
            value = "postgres"
          }

          port {
            container_port = 5432
          }

          volume_mount {
            mount_path = "/var/lib/postgresql/data"
            name       = "db-data"
          }
        }

        volume {
          name = "db-data"
          empty_dir {}
        }
      }
    }
  }
}

resource "kubernetes_deployment" "redis" {
  metadata {
    name   = "redis"
    labels = {
        app = "redis"
    }
  }

  spec {
    replicas = 1
    selector {
        match_labels = {
            app = "redis"
      }
    }

    template {
        metadata {
            labels = {
                app = "redis"
        }
      }

      spec {
        container {
            name  = "redis"
            image = "redis:alpine"

            port {
                container_port = 6379
            }

            volume_mount {
                mount_path = "/data"
                name       = "redis-data"
            }
        }

        volume {
            name = "redis-data"
            empty_dir {}
        }
      }
    }
  }
}

resource "kubernetes_deployment" "result" {
  metadata {
    name = "result"
    labels = {
      app = "result"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "result"
      }
    }

    template {
      metadata {
        labels = {
          app = "result"
        }
      }

      spec {
        container {
          name  = "result"
          image = "dockersamples/examplevotingapp_result"

          port {
            container_port = 80
            name = "result"
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "vote" {
  metadata {
    name = "vote"
    labels = {
      app = "vote"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "vote"
      }
    }

    template {
      metadata {
        labels = {
          app = "vote"
        }
      }

      spec {
        container {
          name  = "vote"
          image = "dockersamples/examplevotingapp_vote"

          port {
            name = "vote"
            container_port = 80
          }
        }
      }
    }
  }
}


resource "kubernetes_deployment" "worker" {
  metadata {
    name = "worker"
    labels = {
      app = "worker"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "worker"
      }
    }

    template {
      metadata {
        labels = {
          app = "worker"
        }
      }

      spec {
        container {
          name  = "worker"
          image = "dockersamples/examplevotingapp_worker"
        }
      }
    }
  }
}
