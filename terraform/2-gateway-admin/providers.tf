terraform {
  required_version = ">= 1.5.0"

  required_providers {
    akeyless = {
      source  = "akeyless-community/akeyless"
      version = "~> 2.0"
    }
  }
}

# gateway-create-allowed-access 400s with "command is not available on
# public gateway" when routed through api.akeyless.io, so this must point
# at the private gateway itself.
provider "akeyless" {
  api_gateway_address = var.akeyless_api_gateway_address

  api_key_login {
    access_id  = var.akeyless_access_id
    access_key = var.akeyless_access_key
  }
}
