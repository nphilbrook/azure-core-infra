resource "azurerm_dns_zone" "zone" {
  name                = "${var.location}.${var.resource_group_name}.azure.${var.username}.sbx.hashidemos.io"
  resource_group_name = var.resource_group_name

  tags = var.default_tags
}
