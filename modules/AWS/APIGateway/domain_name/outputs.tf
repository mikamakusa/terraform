output "api_gateway_domain_name" {
  value = aws_api_gateway_domain_name.domain_name.*.domain_name
}