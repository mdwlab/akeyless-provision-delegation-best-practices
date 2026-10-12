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

# Bootstrap grant for github-workflow-tf-global-admin's JWT identity — its
# own 2-gateway-admin job needs this to call gateway-create-allowed-access
# itself, which is why it can't grant itself this access.
resource "akeyless_gateway_allowed_access" "github_actions" {
  name        = "github_actions_gateway_access"
  access_id   = var.github_actions_access_id
  cluster_id  = var.cluster_id
  permissions = var.github_actions_permissions
}
