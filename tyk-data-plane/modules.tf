module "datadog" {
  source = "../modules/observability/datadog"

  namespace = var.namespace

  datadog_api_key = var.datadog_api_key
  datadog_site    = var.datadog_site

  count = var.datadog_enabled ? 1 : 0
}