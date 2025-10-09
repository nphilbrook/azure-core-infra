required_providers {
  azurerm = {
    source  = "hashicorp/azurerm"
    version = "~>4.47"
  }
}

provider "azurerm" "configurations" {
  config {
    use_cli                         = false
    resource_provider_registrations = "none"

    tenant_id       = var.az_tenant_id
    subscription_id = var.az_subscription_id
    client_id       = var.az_client_id
    client_secret   = var.az_client_secret

    features {
      resource_group {
        prevent_deletion_if_contains_resources = false
      }
    }
  }
}

