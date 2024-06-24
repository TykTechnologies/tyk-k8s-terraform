resource "helm_release" "datadog" {
  name       = "datadog"
  repository = "https://helm.datadoghq.com"
  chart      = "datadog"

  namespace = var.namespace
  atomic    = true

  set {
    name  = "datadog.apiKey"
    value = var.datadog_api_key
  }

  set {
    name  = "datadog.site"
    value = var.datadog_site
  }

  set {
    name  = "datadog.kubelet.tlsVerify"
    value = "false"
  }

  set {
    name  = "datadog.dogstatsd.tags"
    value = "tyk"
  }

  set {
    name  = "datadog.dogstatsd.originDetection"
    value = "true"
  }

  set {
    name  = "datadog.dogstatsd.nonLocalTraffic"
    value = "true"
  }
}