resource "azurerm_resource_group" "rg" {
  name     = "${var.environment}-${var.location}"
  location = var.location
  tags     = var.default_tags
}
