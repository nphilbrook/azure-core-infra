store "varset" "azure_auth" {
  name     = "Azure Credentials"
  category = "env"
}

locals {
  default_tags = {
    "created-by"   = "terraform"
    "source-stack" = "philbrook/azure-core-infra"
  }
}

deployment "dev" {
  inputs = {
    locations          = ["East US"]
    environment        = "dev"
    default_tags       = local.default_tags
    az_tenant_id       = store.varset.azure_auth.stable.ARM_TENANT_ID
    az_subscription_id = store.varset.azure_auth.stable.ARM_SUBSCRIPTION_ID
    az_client_id       = store.varset.azure_auth.stable.ARM_CLIENT_ID
    az_client_secret   = store.varset.azure_auth.ARM_CLIENT_SECRET
  }
}

# publish_output "dev_packer_public_dns" {
#   value = deployment.dev.packer_public_dns
# }

# publish_output "dev_packer_instance_profile_role_arn" {
#   value = deployment.dev.packer_instance_profile_role_arn
# }
