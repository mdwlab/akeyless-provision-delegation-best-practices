locals {
  # The API expects the CA certificate as base64-encoded PEM content, so the
  # file on disk stays human-readable PEM and gets encoded here.
  ssl_certificate = base64encode(file("${path.module}/certs/${var.ssl_certificate_filename}"))
}

# Replicates /lilly/cn/database/wayne_condor_postgres_target and
# /lilly/cn/database/condor_self_rotate_target under /xcorp/cn/targets.
resource "akeyless_target_db" "postgres" {
  for_each = var.targets

  name        = "${var.base_path}/${var.region}/targets/${each.key}"
  db_type     = "postgres"
  description = each.value.description

  host      = each.value.host
  port      = each.value.port
  db_name   = each.value.db_name
  user_name = each.value.user_name
  pwd       = each.value.password

  ssl             = true
  ssl_certificate = local.ssl_certificate
}
