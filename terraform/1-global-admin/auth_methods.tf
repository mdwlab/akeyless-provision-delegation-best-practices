# Per-persona API key identities for the roles managed directly by global admin.
# App-team auth methods are NOT created here — the region_admin persona
# provisions those itself in the regional-admin config.

resource "akeyless_auth_method_api_key" "cmdb_admin" {
  name = "${var.base_path}/${var.region}_cmdb_admin"
}

resource "akeyless_auth_method_api_key" "region_admin" {
  name = "${var.base_path}/${var.region}_region_admin"
}
