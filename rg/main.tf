resource "azurerm_resource_group" "rg" {
  name     = var.environment
  location = var.location
  tags     = var.default_tags
}
