output "role_names" {
  description = "Names of the roles provisioned directly under base_path/region"
  value = {
    cmdb_admin   = akeyless_role.cmdb_admin.name
    gateway      = akeyless_role.gateway.name
    region_admin = akeyless_role.region_admin.name
  }
}

output "persona_credentials" {
  description = "access_id/access_key per persona. The region_admin pair feeds the regional-admin config's provider credentials."
  sensitive   = true
  value = {
    cmdb_admin = {
      access_id  = akeyless_auth_method_api_key.cmdb_admin.access_id
      access_key = akeyless_auth_method_api_key.cmdb_admin.access_key
    }
    region_admin = {
      access_id  = akeyless_auth_method_api_key.region_admin.access_id
      access_key = akeyless_auth_method_api_key.region_admin.access_key
    }
  }
}
