resource "aws_api_gateway_domain_name" "domain_name" {
  count           = length(var.domain_name)
  domain_name     = lookup(var.domain_name[count.index], "domain_name")
  certificate_arn = var.certificate_arn
  security_policy = lookup(var.domain_name[count.index], "security_policy", null)

  dynamic "endpoint_configuration" {
    for_each = lookup(var.domain_name[count.index], "endpoint_configuration")
    content {
      types = [lookup(endpoint_configuration.value, "types", null)]
    }
  }
}