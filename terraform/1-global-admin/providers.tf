terraform {
  required_version = ">= 1.5.0"

  required_providers {
    akeyless = {
      source  = "akeyless-community/akeyless"
      version = "~> 2.0"
    }
  }
}

# Credentials here must belong to an /admin-privileged identity (e.g. the
# account's devops/tf/api-key-by-terraform auth method) since this config
# creates the region's folder structure and the region_admin persona itself.
provider "akeyless" {
  api_gateway_address = var.akeyless_api_gateway_address

  api_key_login {
    access_id  = var.akeyless_access_id
    access_key = var.akeyless_access_key
  }
}
