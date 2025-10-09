locals {
  default_tags = {
    "created-by"   = "terraform"
    "source-stack" = "philbrook/azure-core-infra"
  }
}

store "varset" "azure_auth" {
  name     = "Azure Credentials"
  category = "env"
}

store "varset" "aws_auth" {
  name     = "aws-creds"
  category = "env"
}

identity_token "aws" {
  audience = ["aws.workload.identity"]
}

deployment "dev" {
  inputs = {
    locations          = ["eastus"]
    removed_locations  = []
    environment        = "dev"
    default_tags       = local.default_tags
    az_tenant_id       = store.varset.azure_auth.stable.ARM_TENANT_ID
    az_subscription_id = store.varset.azure_auth.stable.ARM_SUBSCRIPTION_ID
    az_client_id       = store.varset.azure_auth.stable.ARM_CLIENT_ID
    az_client_secret   = store.varset.azure_auth.ARM_CLIENT_SECRET

    # AWS for NS records
    identity_token_aws = identity_token.aws.jwt
    role_arn           = store.varset.aws_auth.TFC_AWS_RUN_ROLE_ARN
  }
}

deployment "prod" {
  inputs = {
    locations          = ["eastus", "centralus"]
    removed_locations  = []
    environment        = "prod"
    default_tags       = local.default_tags
    az_tenant_id       = store.varset.azure_auth.stable.ARM_TENANT_ID
    az_subscription_id = store.varset.azure_auth.stable.ARM_SUBSCRIPTION_ID
    az_client_id       = store.varset.azure_auth.stable.ARM_CLIENT_ID
    az_client_secret   = store.varset.azure_auth.ARM_CLIENT_SECRET


    # AWS for NS records
    identity_token_aws = identity_token.aws.jwt
    role_arn           = store.varset.aws_auth.TFC_AWS_RUN_ROLE_ARN
  }
}

# publish_output "dev_packer_public_dns" {
#   value = deployment.dev.packer_public_dns
# }

# publish_output "dev_packer_instance_profile_role_arn" {
#   value = deployment.dev.packer_instance_profile_role_arn
# }
