resource "akeyless_auth_method_api_key" "app_team" {
  for_each = var.app_teams

  name = "${var.base_path}/${var.region}/teams/app_team_${each.value}"
}
