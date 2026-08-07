resource "akeyless_role" "app_team" {
  for_each = var.app_teams

  name = "${var.base_path}/${var.region}/teams/app_team_${each.value}"

  rules {
    capability = ["read", "list"]
    path       = "${var.base_path}/${var.region}/${each.value}/*"
    rule_type  = "item-rule"
  }
}
