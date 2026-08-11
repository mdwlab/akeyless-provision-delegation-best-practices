# Positive case: app_team_c0001's role grants read/list on
# /xcorp/cn/c0001/* (see 5-regional-admin-auths/roles.tf), so reading the
# current rotated value succeeds.
data "akeyless_rotated_secret" "condor_postgres_user_rs1" {
  name = var.secret_name
}
