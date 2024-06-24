resource "helm_release" "tyk" {
  name       = "tyk"
  repository = "https://helm.tyk.io/public/helm/charts"
  chart      = "tyk-stack"
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
    name  = "tyk-dashboard.dashboard.extraEnvs[0].configMap.name"
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
    name  = "global.components.pump"
    value = var.datadog_enabled ? "true" : "false"
  }

  set {
    name  = "tyk-pump.pump.extraEnvs[0].name"
    value = "TYK_PMP_PUMPS_DOGSTATSD_TYPE"
  }

  set {
    name  = "tyk-pump.pump.extraEnvs[0].value"
    type  = "string"
    value = "dogstatsd"
  }

  set {
    name  = "tyk-pump.pump.extraEnvs[1].name"
    value = "TYK_PMP_PUMPS_DOGSTATSD_META_NAMESPACE"
  }

  set {
    name  = "tyk-pump.pump.extraEnvs[1].value"
    type  = "string"
    value = "tyk"
  }

  set {
    name  = "tyk-pump.pump.extraEnvs[2].name"
    value = "TYK_PMP_PUMPS_DOGSTATSD_META_ADDRESS"
  }

  set {
    name  = "tyk-pump.pump.extraEnvs[2].value"
    type  = "string"
    value = "datadog.tyk.svc:8125"
  }

  set {
    name  = "tyk-pump.pump.extraEnvs[3].name"
    value = "TYK_PMP_PUMPS_DOGSTATSD_META_ASYNCUDS"
  }

  set {
    name  = "tyk-pump.pump.extraEnvs[3].value"
    type  = "string"
    value = "true"
  }

  set {
    name  = "tyk-pump.pump.extraEnvs[4].name"
    value = "TYK_PMP_PUMPS_DOGSTATSD_META_ASYNCUDSWRITETIMEOUT"
  }

  set {
    name  = "tyk-pump.pump.extraEnvs[4].value"
    type  = "string"
    value = "2"
  }

  set {
    name  = "tyk-pump.pump.extraEnvs[5].name"
    value = "TYK_PMP_PUMPS_DOGSTATSD_META_BUFFERED"
  }

  set {
    name  = "tyk-pump.pump.extraEnvs[5].value"
    type  = "string"
    value = "true"
  }

  set {
    name  = "tyk-pump.pump.extraEnvs[5].name"
    value = "TYK_PMP_PUMPS_DOGSTATSD_META_BUFFEREDMAXMESSAGES"
  }

  set {
    name  = "tyk-pump.pump.extraEnvs[5].value"
    type  = "string"
    value = "32"
  }

  set {
    name  = "tyk-pump.pump.extraEnvs[6].name"
    value = "TYK_PMP_PUMPS_DOGSTATSD_META_SAMPLERATE"
  }

  set {
    name  = "tyk-pump.pump.extraEnvs[6].value"
    type  = "string"
    value = "0.9999999999"
  }

  set {
    name  = "tyk-pump.pump.extraEnvs[7].name"
    value = "TYK_PMP_PUMPS_DOGSTATSD_META_TAGS"
  }

  set {
    name  = "tyk-pump.pump.extraEnvs[7].value"
    type  = "string"
    value = "method,response_code,api_version,api_name,api_id,org_id,tracked,path,oauth_id"
  }

  depends_on = [module.redis, module.pgsql]
}
