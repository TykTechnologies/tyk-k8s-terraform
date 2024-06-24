provider "helm" {
  kubernetes {
    config_path    = var.kubernetes_config_path
    config_context = var.kubernetes_config_context
  }
}

provider "kubernetes" {
  config_path    = var.kubernetes_config_path
  config_context = var.kubernetes_config_context
}

module "redis" {
  source    = "../modules/databases/redis"
  namespace = var.namespace
}

module "pgsql" {
  source    = "../modules/databases/pgsql"
  namespace = var.namespace
}
