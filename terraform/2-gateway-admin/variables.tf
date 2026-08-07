variable "akeyless_api_gateway_address" {
  description = "Address of the private gateway itself (not api.akeyless.io) — this is what serves gateway-create-allowed-access. Root cause of every earlier auth/404 failure: this needs the /api/v2 suffix, not just the bare host."
  type        = string
  default     = "https://gw-condor.mdwlab.org/api/v2"
}

variable "akeyless_access_id" {
  description = "Access ID used to authenticate this Terraform run against the gateway (the account admin key — trusting a new identity on a gateway is an administrative action)"
  type        = string
  sensitive   = true
}

variable "akeyless_access_key" {
  description = "Access key used to authenticate this Terraform run against the gateway"
  type        = string
  sensitive   = true
}

variable "cluster_id" {
  description = "Numeric cluster ID of this gateway (condor.mdwlab.org / gw-condor.mdwlab.org)"
  type        = number
  default     = 63227
}

variable "cmdb_admin_access_id" {
  description = "cmdb_admin's own access ID (from global-admin's persona_credentials output) to trust on this gateway"
  type        = string
}

variable "cmdb_admin_permissions" {
  description = "Comma-separated list of gateway permissions to grant cmdb_admin (see akeyless_gateway_allowed_access docs for the full permission list)"
  type        = string
  default     = "targets,rotated_secret,rotate_secret_value"
}

variable "region_admin_access_id" {
  description = "region_admin's own access ID (from global-admin's persona_credentials output) to trust on this gateway"
  type        = string
}

variable "region_admin_permissions" {
  description = "Comma-separated list of gateway permissions to grant region_admin. Includes rotation: region_admin creates the per-app-team rotated secrets in 6-regional-admin-items."
  type        = string
  default     = "targets,rotated_secret,rotate_secret_value"
}
