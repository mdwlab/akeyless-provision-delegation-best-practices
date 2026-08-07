output "target_names" {
  description = "Names of the postgres targets created under base_path/region/targets"
  value       = { for k, t in akeyless_target_db.postgres : k => t.name }
}

#output "rotated_secret_name" {
#  description = "Name of the self-rotating postgres rotated secret"
#  value       = akeyless_rotated_secret_postgresql.condor_postgres_self_rs.name
#}
