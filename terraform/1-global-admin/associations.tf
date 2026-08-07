resource "akeyless_associate_role_auth_method" "cmdb_admin" {
  role_name = akeyless_role.cmdb_admin.name
  am_name   = akeyless_auth_method_api_key.cmdb_admin.name
}

resource "akeyless_associate_role_auth_method" "gateway" {
  role_name = akeyless_role.gateway.name
  am_name   = var.gateway_auth_method_name
}

resource "akeyless_associate_role_auth_method" "region_admin" {
  role_name = akeyless_role.region_admin.name
  am_name   = akeyless_auth_method_api_key.region_admin.name
}
