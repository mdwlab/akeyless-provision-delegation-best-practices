variable "akeyless_api_gateway_address" {
  description = "Address of the private gateway itself (not api.akeyless.io) — rotated secrets are gateway-mediated. Needs the /api/v2 suffix."
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

variable "target_name" {
  description = "Full name of the target this rotated secret rotates against (created by the cmdb-admin-targets config — see its target_names output)"
  type        = string
  default     = "/xcorp/cn/targets/condor_self_rotate_target"
}
