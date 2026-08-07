variable "akeyless_api_gateway_address" {
  description = "Akeyless API gateway address the provider talks to"
  type        = string
  default     = "https://api.akeyless.io"
}

variable "akeyless_access_id" {
  description = "Access ID of the account admin API key used to authenticate this Terraform run"
  type        = string
  sensitive   = true
}

variable "akeyless_access_key" {
  description = "Access key of the account admin API key used to authenticate this Terraform run"
  type        = string
  sensitive   = true
}

variable "base_path" {
  description = "Root path this configuration provisions under"
  type        = string
  default     = "/xcorp"
}

variable "region" {
  description = "Regional code under base_path, e.g. cn"
  type        = string
  default     = "cn"
}

variable "gateway_auth_method_name" {
  description = "Name of the existing shared gateway API key auth method to bind the regional gateway role to. The physical gateway already has an account-wide identity, so it is reused across regions rather than recreated per region."
  type        = string
  default     = "/devops/gateway/devops-api-key"
}

variable "app_teams" {
  description = "Application teams to pre-create item folders for (role/auth-method provisioning for these teams happens in the regional-admin config)"
  type        = set(string)
  default     = ["c0001", "c0002"]
}
