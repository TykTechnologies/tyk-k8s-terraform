resource "helm_release" "tyk" {
  name       = "tyk"
  repository = "https://helm.tyk.io/public/helm/charts"
  chart      = "tyk-stack"
  version    = "1.4.0"
  namespace  = var.namespace
  atomic     = true

  set {
    name  = "global.redis.addrs[0]"
    value = "${helm_release.tyk_redis.name}-redis-cluster.${var.namespace}.svc:${local.redis-port}"
  }

  set {
    name  = "global.redis.pass"
    value = local.redis-pass
  }

  set {
    name  = "global.redis.enableCluster"
    value = "true"
  }

  set {
    name  = "global.storageType"
    value = "postgres"
  }

  set {
    name  = "global.postgres.host"
    value = "${helm_release.tyk_storage_postgres.name}-postgresql.${var.namespace}.svc"
  }

  set {
    name  = "global.postgres.port"
    value = local.storage-port
  }

  set {
    name  = "global.postgres.password"
    value = local.storage-pass
  }

  set {
    name  = "global.postgres.database"
    value = local.storage-name
  }

  set {
    name  = "global.postgres.sslmode"
    value = "disable"
  }

  set {
    name  = "tyk-pump.pump.backend[0]"
    value = "postgres"
  }

  set {
    name  = "global.secrets.useSecretName"
    value = "tyk-secret"
  }

  set {
    name  = "global.adminUser.useSecretName"
    value = "tyk-secret"
  }

  set {
    name  = "tyk-gateway.gateway.image.tag"
    value = var.gateway_version
  }

  set {
    name  = "tyk-dashboard.dashboard.image.tag"
    value = var.dashboard_version
  }

  set {
    name  = "tyk-pump.pump.image.tag"
    value = var.pump_version
  }

  set {
    name  = "tyk-pump.pump.image.repository"
    value = "tykio/tyk-pump-docker-pub"
  }

  depends_on = [helm_release.tyk_redis, helm_release.tyk_storage_postgres]
}