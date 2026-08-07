output "rotated_secret_name" {
  description = "Name of the self-rotating postgres rotated secret"
  value       = akeyless_rotated_secret_postgresql.condor_postgres_self_rs.name
}
