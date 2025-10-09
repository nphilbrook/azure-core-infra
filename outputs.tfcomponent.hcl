output "environment_info" {
  value = {
    for location in var.locations : location => {
      location            = location
      resource_group_name = component.rg[location].resource_group_name
    zone = component.dns_tls[location].zone_name }
  }
  type = map(object({
    location            = string
    resource_group_name = string
    zone                = string
  }))
}
