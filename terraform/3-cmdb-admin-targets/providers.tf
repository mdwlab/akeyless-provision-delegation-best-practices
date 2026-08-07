terraform {
  required_version = ">= 1.5.0"

  required_providers {
    akeyless = {
      source  = "akeyless-community/akeyless"
      version = "~> 2.0"
    }
  }
}

# Credentials here must be the cmdb_admin persona's own API key (output
# "persona_credentials.cmdb_admin" from the global-admin config's state) —
# not the account admin key.
provider "akeyless" {
  api_gateway_address = var.akeyless_api_gateway_address

  api_key_login {
    access_id  = var.akeyless_access_id
    access_key = var.akeyless_access_key
  }
}
