# Self-rotating secret: condor_self_rotate_target's own credentials are what
# get rotated, matching the console-built /lilly/cn/cmdb/condor_postgres_self_rs.
resource "akeyless_rotated_secret_postgresql" "condor_postgres_self_rs" {
  name         = "${var.base_path}/${var.region}/cmdb/condor_postgres_self_rs"
  target_name  = var.target_name
  rotator_type = "target"

  authentication_credentials = "use-target-creds"
  auto_rotate                = "true"
  rotation_interval          = "7"
  password_length            = "16"
}
