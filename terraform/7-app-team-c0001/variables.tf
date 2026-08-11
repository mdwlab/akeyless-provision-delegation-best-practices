variable "akeyless_api_gateway_address" {
  description = "Address of the private gateway itself (not api.akeyless.io), with the /api/v2 suffix — see terraform/2-gateway-admin/REAME.MD for why."
  type        = string
  default     = "https://gw-condor.mdwlab.org/api/v2"
}

variable "akeyless_access_id" {
  description = "Access ID of the app_team_c0001 API key (created by the 5-regional-admin-auths config)"
  type        = string
  sensitive   = true
}

variable "akeyless_access_key" {
  description = "Access key of the app_team_c0001 API key (created by the 5-regional-admin-auths config)"
  type        = string
  sensitive   = true
}

variable "secret_name" {
  description = "Rotated secret this persona is allowed to read (created by 6-regional-admin-items)"
  type        = string
  default     = "/xcorp/cn/c0001/database/condor_postgres_user_rs1"
}
