resource "kubernetes_service" "postgres" {
  metadata {
    name = "postgres"
    labels = {
      app = "postgres"
    }
  }

  spec {
    selector = {
      app = "postgres"
    }

    port {
      port        = 5432
      target_port = 5432
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service" "redis" {
  metadata {
    name   = "redis"
    labels = {
        app = "redis"
    }
  }

  spec {
    selector = {
        app = "redis"
    }

    port {
        name        = "redis-service"
        port        = 6379
        target_port = 6379
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service" "result" {
  metadata {
    name = "result"
    labels = {
      app = "result"
    }
  }

  spec {
    selector = {
      app = "result"
    }

    port {
      port        = 5001
      target_port = 80
      node_port = 31001
    }

    type = "NodePort"
  }
}

resource "kubernetes_service" "vote" {
  metadata {
    name = "vote"
    labels = {
      app = "vote"
    }
  }

  spec {
    selector = {
      app = "vote"
    }

    port {
      name        = "vote-service"
      port        = 5000
      target_port = 80
      node_port   = 31000
    }

    type = "NodePort"
  }
}
