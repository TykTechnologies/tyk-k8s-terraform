resource "helm_release" "tyk" {
  name       = "tyk"
  repository = "https://helm.tyk.io/public/helm/charts"
  chart      = "tyk-data-plane"
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
    name  = "global.secrets.useSecretName"
    value = "tyk-secret"
  }

  set {
    name  = "global.remoteControlPlane.useSecretName"
    value = "tyk-secret"
  }

  set {
    name  = "global.remoteControlPlane.connectionString"
    value = var.cp_mdcb_connection_string
  }

  set {
    name  = "global.remoteControlPlane.sslInsecureSkipVerify"
    value = var.cp_mdcb_ssl_skip_verify
  }

  set {
    name  = "global.remoteControlPlane.useSSL"
    value = var.cp_mdcb_use_ssl
  }

  set {
    name  = "tyk-gateway.gateway.image.tag"
    value = var.gateway_version
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

  set {
    name  = "tyk-mdcb.mdcb.image.tag"
    value = var.mdcb_version
  }

  set {
    name  = "tyk-gateway.gateway.extraEnvs[0].name"
    value = "TYK_GW_SLAVEOPTIONS_SYNCHRONISERENABLED"
  }

  set {
    name  = "tyk-gateway.gateway.extraEnvs[0].value"
    type  = "string"
    value = "true"
  }

  depends_on = [module.redis]
}
