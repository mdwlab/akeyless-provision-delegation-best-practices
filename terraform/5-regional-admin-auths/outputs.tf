output "role_names" {
  description = "Names of the app-team roles provisioned under base_path/region/teams"
  value       = { for k, r in akeyless_role.app_team : k => r.name }
}

output "persona_credentials" {
  description = "access_id/access_key per app-team persona — use these with `akeyless configure --profile app_team_<id>` in the CLI test phase"
  sensitive   = true
  value = {
    for k, a in akeyless_auth_method_api_key.app_team : k => {
      access_id  = a.access_id
      access_key = a.access_key
    }
  }
}
