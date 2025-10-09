locals {
  r53_zone = "${var.username}.sbx.hashidemos.io"
}

resource "azurerm_dns_zone" "zone" {
  name                = "${var.location}.${var.environment}.azure.${local.r53_zone}"
  resource_group_name = var.resource_group_name

  tags = var.default_tags
}

data "aws_route53_zone" "public_zone" {
  name = local.r53_zone
}

resource "aws_route53_record" "ns" {
  zone_id = data.aws_route53_zone.public_zone.zone_id
  name    = azurerm_dns_zone.zone.name
  type    = "NS"
  ttl     = 300
  records = azurerm_dns_zone.zone.name_servers
}
