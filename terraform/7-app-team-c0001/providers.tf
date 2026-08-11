terraform {
  required_version = ">= 1.5.0"

  required_providers {
    akeyless = {
      source  = "akeyless-community/akeyless"
      version = "~> 2.0"
    }
  }
}

# Credentials here must be app_team_c0001's own API key (output
# "persona_credentials.c0001" from the 5-regional-admin-auths config's
# state), not an admin key — the whole point of this directory is to
# exercise that persona's actual RBAC boundary.
provider "akeyless" {
  api_gateway_address = var.akeyless_api_gateway_address

  api_key_login {
    access_id  = var.akeyless_access_id
    access_key = var.akeyless_access_key
  }
}
