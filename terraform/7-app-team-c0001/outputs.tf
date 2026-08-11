output "secret_value" {
  description = "Current value of the rotated secret, read via app_team_c0001's own credentials"
  value       = data.akeyless_rotated_secret.condor_postgres_user_rs1.value
  sensitive   = true
}
