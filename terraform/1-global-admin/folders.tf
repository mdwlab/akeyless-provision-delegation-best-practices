resource "akeyless_folder" "region" {
  name = "${var.base_path}/${var.region}"
}

resource "akeyless_folder" "cmdb" {
  name       = "${var.base_path}/${var.region}/cmdb"
  depends_on = [akeyless_folder.region]
}

# Parent path for targets in this region, per the persona doc's Global/Account
# admin section ("Targets: Path /lilly/cn/targets").
resource "akeyless_folder" "targets" {
  name       = "${var.base_path}/${var.region}/targets"
  depends_on = [akeyless_folder.region]
}

resource "akeyless_folder" "app_team" {
  for_each   = var.app_teams
  name       = "${var.base_path}/${var.region}/${each.value}"
  depends_on = [akeyless_folder.region]
}
