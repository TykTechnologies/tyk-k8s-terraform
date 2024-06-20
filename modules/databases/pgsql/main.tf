locals {
  storage-name = "storage"
  storage-pass = "topsecretpassword"
  storage-port = 5432
}

resource "helm_release" "tyk_storage_postgres" {
  name       = "tyk-storage-postgres"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "12.12.10"
  namespace  = var.namespace
  atomic     = true

  set {
    name  = "auth.database"
    value = local.storage-name
  }

  set {
    name  = "auth.postgresPassword"
    value = local.storage-pass
  }

  set {
    name  = "containerPorts.postgresql"
    value = local.storage-port
  }

  set {
    name  = "primary.service.ports.postgresql"
    value = local.storage-port
  }
}

output "name" {
  value = helm_release.tyk_storage_postgres.name
}

output "storage-name" {
  value = local.storage-name
}

output "storage-port" {
  value = local.storage-port
}

output "storage-pass" {
  value = local.storage-pass
}
