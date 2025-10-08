resource "azurerm_dns_zone" "example-public" {
  # TODO: refactor username to variable
  name                = "${var.resource_group_name}.azure.nick-philbrook.sbx.hashidemos.io"
  resource_group_name = var.resource_group_name

  tags = var.default_tags
}
