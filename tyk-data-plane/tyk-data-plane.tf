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
