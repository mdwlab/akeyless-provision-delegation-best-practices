output "rotated_secret_names" {
  description = "Names of the app-team rotated secrets"
  value = {
    c0001 = akeyless_rotated_secret_postgresql.condor_postgres_user_rs1.name
    c0002 = akeyless_rotated_secret_postgresql.condor_postgres_user_rs2.name
  }
}
