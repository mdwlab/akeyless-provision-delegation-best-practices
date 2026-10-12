resource "akeyless_role" "app_team" {
  for_each = var.app_teams

  name = "${var.base_path}/${var.region}/teams/app_team_${each.value}"

  # Event Center: Scoped — the team sees only events for items it can access.
  event_center_access = "scoped"

  # Manage Event Forwarders, limited by forwarder *name* (not item path) to
  # forwarders prefixed with the role's short name, e.g. app_team_c0001_*.
  # The provider only sends event_forwarders_name on create-role; an in-place
  # update sends just the access value and grants every forwarder ("/*").
  # Changing these on an existing role requires recreating it:
  #   terraform apply -replace='akeyless_role.app_team["<id>"]' \
  #                   -replace='akeyless_associate_role_auth_method.app_team["<id>"]'
  # event_forwarders_access must be left unset: create-role rejects it
  # together with event_forwarders_name, and names alone enable the rule.
  event_forwarders_name = ["app_team_${each.value}_*"]

  lifecycle {
    # The server stores names with a leading "/" (/app_team_c0001_*), so the
    # read-back always differs; an in-place update would also drop the names.
    # Use -replace (above) to change them.
    ignore_changes = [event_forwarders_name]
  }

  rules {
    capability = ["read", "list"]
    path       = "${var.base_path}/${var.region}/${each.value}/*"
    rule_type  = "item-rule"
  }
}
