module "opa" {
  source = "../modules/tyk/opa"

  namespace = var.namespace
}

module "operator" {
  source = "../modules/tyk/operator"

  namespace = var.namespace

  count = var.operator_enabled ? 1 : 0
}
