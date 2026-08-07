# Access roles created directly under base_path/region (not nested under
# .../teams — the teams roles are provisioned separately by region_admin).

resource "akeyless_role" "cmdb_admin" {
  name = "${var.base_path}/${var.region}/${var.region}_cmdb_admin_role"

  # Scoped to the cmdb path only — the region-wide wildcard would also grant
  # read access to app-team secrets under /xcorp/cn/<team>/*.
  rules {
    capability = ["read", "list", "update", "delete", "create"]
    path       = "${var.base_path}/${var.region}/cmdb/*"
    rule_type  = "item-rule"
  }

  rules {
    capability = ["read", "list", "update", "delete", "create"]
    path       = "${var.base_path}/${var.region}/*"
    rule_type  = "target-rule"
  }
}

resource "akeyless_role" "gateway" {
  name = "${var.base_path}/${var.region}/${var.region}_gateway_role"

  # Scoped to this region only (not base_path/*), since this gateway serves
  # /xcorp/cn — other regions get their own gateway role.
  rules {
    capability = ["read", "list", "update", "delete", "create"]
    path       = "${var.base_path}/${var.region}/*"
    rule_type  = "item-rule"
  }

  rules {
    capability = ["read", "list", "update", "delete", "create"]
    path       = "${var.base_path}/${var.region}/*"
    rule_type  = "target-rule"
  }

  rules {
    capability = ["read", "list", "update", "delete", "create"]
    path       = "${var.base_path}/${var.region}/*"
    rule_type  = "role-rule"
  }

  rules {
    capability = ["read", "list"]
    path       = "/*"
    rule_type  = "auth-method-rule"
  }
}

resource "akeyless_role" "region_admin" {
  name = "${var.base_path}/${var.region}/${var.region}_region_admin_role"

  rules {
    capability = ["read", "list", "update", "delete", "create"]
    path       = "${var.base_path}/${var.region}/*"
    rule_type  = "item-rule"
  }

  # List-only on targets: region admins don't get to read target credentials.
  rules {
    capability = ["list"]
    path       = "${var.base_path}/${var.region}/*"
    rule_type  = "target-rule"
  }

  # Visibility over sibling roles at the region level (cmdb_admin, gateway, itself).
  rules {
    capability = ["read", "list"]
    path       = "${var.base_path}/${var.region}/*"
    rule_type  = "role-rule"
  }

  # Full control over app-team roles/auth-methods so region_admin can
  # self-service onboarding without going back to global admin.
  rules {
    capability = ["read", "list", "update", "delete", "create"]
    path       = "${var.base_path}/${var.region}/teams/*"
    rule_type  = "role-rule"
  }

  rules {
    capability = ["read", "list", "update", "delete", "create"]
    path       = "${var.base_path}/${var.region}/teams/*"
    rule_type  = "auth-method-rule"
  }
}
