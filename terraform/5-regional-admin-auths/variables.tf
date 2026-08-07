variable "akeyless_api_gateway_address" {
  description = "Akeyless API gateway address the provider talks to"
  type        = string
  default     = "https://api.akeyless.io"
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

variable "app_teams" {
  description = "Application teams to provision a read/list-only role + API key auth method for"
  type        = set(string)
  default     = ["c0001", "c0002"]
}
