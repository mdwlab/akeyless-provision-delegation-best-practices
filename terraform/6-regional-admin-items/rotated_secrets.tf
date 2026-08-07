# Per-app-team rotated secrets, matching the console-built
# /lilly/cn/c0001/database/condor_postgres_user_rs1 and
# /lilly/cn/c0002/database/condor_postgres_user_rs2 — both rotate a
# dedicated DB user's password (not the target's own creds) against the
# shared wayne_condor_postgres_target.

resource "akeyless_rotated_secret_postgresql" "condor_postgres_user_rs1" {
  name         = "${var.base_path}/${var.region}/c0001/database/condor_postgres_user_rs1"
  target_name  = var.target_name
  rotator_type = "password"

  authentication_credentials = "use-target-creds"
  rotated_username            = var.c0001_rotated_username
  rotated_password            = var.c0001_rotated_password

  auto_rotate       = "true"
  rotation_interval = "7"
  password_length   = "16"
}

resource "akeyless_rotated_secret_postgresql" "condor_postgres_user_rs2" {
  name         = "${var.base_path}/${var.region}/c0002/database/condor_postgres_user_rs2"
  target_name  = var.target_name
  rotator_type = "password"

  authentication_credentials = "use-target-creds"
  rotated_username            = var.c0002_rotated_username
  rotated_password            = var.c0002_rotated_password

  auto_rotate       = "true"
  rotation_interval = "7"
  password_length   = "16"
}
