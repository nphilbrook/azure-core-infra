component "rg" {
  for_each = var.locations

  source = "./rg"

  inputs = {
    environment  = var.environment
    location     = each.value
    default_tags = var.default_tags
  }

  providers = {
    azurerm = provider.azurerm.this
  }
}


component "dns_tls" {
  for_each = var.locations

  source = "./dns_tls"

  inputs = {
    resource_group_name = component.rg[each.value].resource_group_name
    location            = each.value
    default_tags        = var.default_tags
    username            = var.username
  }

  providers = {
    azurerm = provider.azurerm.this
  }
}

removed {
  for_each = var.removed_locations
  source   = "./rg"
  from     = component.rg[each.value]

  providers = {
    azurerm = provider.azurerm.this
  }
}


removed {
  for_each = var.removed_locations
  source   = "./dns_tls"
  from     = component.dns_tls[each.value]

  providers = {
    azurerm = provider.azurerm.this
  }
}

# component "sgs" {
#   source = "./sgs"

#   for_each = var.regions

#   inputs = {
#     packer_channel  = var.packer_channel
#     region          = each.value
#     source_ip_cidrs = var.source_ip_cidrs
#     project_name    = var.project_name
#   }

#   providers = {
#     aws = provider.aws.configurations[each.value]
#   }
# }

# component "ec2" {
#   for_each = local.dev_prod_channels
#   source   = "./ec2"

#   inputs = {
#     packer_channel               = var.packer_channel
#     region                       = "us-east-1"
#     packer_instance_profile_name = component.iam["_"].packer_instance_profile_name
#     sg_id                        = component.sgs["us-east-1"].allow_ssh_egress_sg_id
#     num_instances                = var.num_packer_instances
#     project_name                 = var.project_name
#   }

#   providers = {
#     aws = provider.aws.configurations["us-east-1"]
#     hcp = provider.hcp.this
#   }
# }
