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
    location            = component.rg[each.value].resource_group_location
    environment         = var.environment
    default_tags        = var.default_tags
    username            = var.username
  }

  providers = {
    azurerm = provider.azurerm.this
    aws     = provider.aws.this
    # acme    = provider.acme.this
    # local   = provider.local.this
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
    aws     = provider.aws.this
  }
}
