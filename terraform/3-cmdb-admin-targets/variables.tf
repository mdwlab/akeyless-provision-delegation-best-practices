variable "akeyless_api_gateway_address" {
  description = "Address of the private gateway itself (not api.akeyless.io) — targets are gateway-mediated. Needs the /api/v2 suffix."
  type        = string
  default     = "https://gw-condor.mdwlab.org/api/v2"
}

variable "akeyless_access_id" {
  description = "Access ID of the cmdb_admin API key (created by the global-admin config)"
  type        = string
  sensitive   = true
}

variable "akeyless_access_key" {
  description = "Access key of the cmdb_admin API key (created by the global-admin config)"
  type        = string
  sensitive   = true
}

variable "base_path" {
  description = "Root path this configuration provisions under — must match the global-admin config's base_path"
  type        = string
  default     = "/xcorp"
}

variable "region" {
  description = "Regional code under base_path, e.g. cn — must match the global-admin config's region"
  type        = string
  default     = "cn"
}

variable "targets" {
  description = "Postgres targets to create under base_path/region/targets, keyed by target short name (e.g. \"wayne_condor_postgres_target\")"
  type = map(object({
    host        = string
    port        = string
    db_name     = string
    user_name   = string
    password    = string
    description = optional(string, "")
  }))
  # Not marked sensitive: this map's keys drive for_each, and Terraform
  # forbids for_each over a sensitive value. The `pwd` attribute is already
  # marked sensitive by the provider schema, so its value is still redacted
  # in plan/apply output.
}

variable "ssl_certificate_filename" {
  description = "Filename, relative to this module's certs/ directory, of the PEM-encoded SSL certificate the postgres targets connect with"
  type        = string
  default     = "condor-ca.pem"
}
