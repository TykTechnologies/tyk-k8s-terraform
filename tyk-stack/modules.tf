module "opa" {
  source = "../modules/tyk/opa"

  namespace = var.namespace
}

module "operator" {
  source = "../modules/tyk/operator"

  namespace = var.namespace

  count = var.operator_enabled ? 1 : 0
}

module "datadog" {
  source = "../modules/observability/datadog"

  namespace = var.namespace

  datadog_api_key = var.datadog_api_key
  datadog_site    = var.datadog_site

  count = var.datadog_enabled ? 1 : 0
}