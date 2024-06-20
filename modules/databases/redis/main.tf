locals {
  redis-pass = "topsecretpassword"
  redis-port = 6379
}

resource "helm_release" "tyk_redis" {
  name       = "tyk-redis"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis-cluster"
  version    = "10.0.1"
  namespace  = var.namespace
  atomic     = true

  set {
    name  = "password"
    value = local.redis-pass
  }

  set {
    name  = "service.ports.redis"
    value = local.redis-port
  }

  set {
    name  = "redis.containerPorts.redis"
    value = local.redis-port
  }

  set {
    name  = "redis.resourcesPreset"
    value = "none"
  }
}

output "name" {
  value = helm_release.tyk_redis.name
}

output "redis-pass" {
  value = local.redis-pass
}

output "redis-port" {
  value = local.redis-port
}