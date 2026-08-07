resource "akeyless_gateway_allowed_access" "cmdb_admin" {
  name        = "cmdb_admin_gateway_access"
  access_id   = var.cmdb_admin_access_id
  cluster_id  = var.cluster_id
  permissions = var.cmdb_admin_permissions
}

resource "akeyless_gateway_allowed_access" "region_admin" {
  name        = "region_admin_gateway_access"
  access_id   = var.region_admin_access_id
  cluster_id  = var.cluster_id
  permissions = var.region_admin_permissions
}
