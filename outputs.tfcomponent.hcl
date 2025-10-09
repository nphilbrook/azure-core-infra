output "environment_info" {
  value = {
    for location in var.locations : location => {
      location            = location
      resource_group_name = component.rg[location].resource_group_name
    zone = component.dns_tls[location].azurerm_dns_zone.zone.name }
  }
  type = map(object({
    location            = string
    resource_group_name = string
    zone                = string
  }))
}
