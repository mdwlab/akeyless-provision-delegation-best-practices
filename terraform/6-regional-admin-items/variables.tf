variable "akeyless_api_gateway_address" {
  description = "Address of the private gateway itself (not api.akeyless.io) — rotated secrets are gateway-mediated. Needs the /api/v2 suffix."
  type        = string
  default     = "https://gw-condor.mdwlab.org/api/v2"
}

variable "akeyless_access_id" {
  description = "Access ID of the region_admin API key (created by the global-admin config)"
  type        = string
  sensitive   = true
}

variable "akeyless_access_key" {
  description = "Access key of the region_admin API key (created by the global-admin config)"
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

variable "target_name" {
  description = "Full name of the target these rotated secrets rotate against (created by the cmdb-admin-targets config)"
  type        = string
  default     = "/xcorp/cn/targets/wayne_condor_postgres_target"
}

variable "c0001_rotated_username" {
  description = "Database user whose password gets rotated for app team c0001"
  type        = string
  default     = "akeyless_rotated_user_c0001"
}

variable "c0001_rotated_password" {
  description = "Initial password for c0001_rotated_username — Akeyless takes over rotation from here"
  type        = string
  sensitive   = true
}

variable "c0002_rotated_username" {
  description = "Database user whose password gets rotated for app team c0002"
  type        = string
  default     = "akeyless_rotated_user_c0002"
}

variable "c0002_rotated_password" {
  description = "Initial password for c0002_rotated_username — Akeyless takes over rotation from here"
  type        = string
  sensitive   = true
}
