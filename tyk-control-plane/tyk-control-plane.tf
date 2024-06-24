resource "helm_release" "tyk" {
  name       = "tyk"
  repository = "https://helm.tyk.io/public/helm/charts"
  chart      = "tyk-control-plane"
  version    = "1.4.0"
  namespace  = var.namespace
  atomic     = true

  set {
    name  = "global.redis.addrs[0]"
    value = "${module.redis.name}-redis-cluster.${var.namespace}.svc:${module.redis.redis-port}"
  }

  set {
    name  = "global.redis.pass"
    value = module.redis.redis-pass
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
    value = "${module.pgsql.name}-postgresql.${var.namespace}.svc"
  }

  set {
    name  = "global.postgres.port"
    value = module.pgsql.storage-port
  }

  set {
    name  = "global.postgres.password"
    value = module.pgsql.storage-pass
  }

  set {
    name  = "global.postgres.database"
    value = module.pgsql.storage-name
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
    name  = "tyk-mdcb.mdcb.useSecretName"
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
    name  = "tyk-dashboard.dashboard.extraEnvs[0].name"
    value = "TYK_DB_SECURITY_OPENPOLICY_ENABLED"
  }

  set {
    name  = "tyk-dashboard.dashboard.extraEnvs[0].value"
    type  = "string"
    value = var.opa_enabled ? "true" : "false"
  }

  set {
    name  = "tyk-dashboard.dashboard.extraEnvs[1].name"
    value = "TYK_DB_SECURITY_OPENPOLICY_ENABLEAPI"
  }

  set {
    name  = "tyk-dashboard.dashboard.extraEnvs[1].value"
    type  = "string"
    value = var.opa_enabled ? "true" : "false"
  }

  set {
    name  = "tyk-dashboard.dashboard.extraVolumes[0].name"
    value = "opa-rules"
  }

  set {
    name  = "tyk-dashboard.dashboard.extraVolumes[0].configMap.name"
    value = "opa-rules"
  }

  set {
    name  = "tyk-dashboard.dashboard.extraVolumeMounts[0].name"
    value = "opa-rules"
  }

  set {
    name  = "tyk-dashboard.dashboard.extraVolumeMounts[0].mountPath"
    value = "/opt/tyk-dashboard/schemas/dashboard.rego"
  }

  set {
    name  = "tyk-dashboard.dashboard.extraVolumeMounts[0].subPath"
    value = "dashboard.rego"
  }

  set {
    name  = "tyk-pump.pump.image.tag"
    value = var.pump_version
  }

  set {
    name  = "tyk-pump.pump.image.repository"
    value = "tykio/tyk-pump-docker-pub"
  }

  set {
    name  = "tyk-mdcb.mdcb.image.tag"
    value = var.mdcb_version
  }

  set {
    name  = "tyk-mdcb.mdcb.service.type"
    value = "NodePort"
  }

  set {
    name  = "tyk-mdcb.mdcb.extraEnvs[0].name"
    value = "TYK_MDCB_SYNCWORKER_ENABLED"
  }

  set {
    name  = "tyk-mdcb.mdcb.extraEnvs[0].value"
    type  = "string"
    value = "true"
  }

  set {
    name  = "tyk-mdcb.mdcb.extraEnvs[1].name"
    value = "TYK_MDCB_SYNCWORKER_HASHKEYS"
  }

  set {
    name  = "tyk-mdcb.mdcb.extraEnvs[1].value"
    type  = "string"
    value = "true"
  }

  depends_on = [module.redis, module.pgsql, module.opa]
}
