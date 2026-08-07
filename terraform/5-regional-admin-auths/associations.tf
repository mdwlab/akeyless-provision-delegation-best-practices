resource "akeyless_associate_role_auth_method" "app_team" {
  for_each = var.app_teams

  role_name = akeyless_role.app_team[each.key].name
  am_name   = akeyless_auth_method_api_key.app_team[each.key].name
}
