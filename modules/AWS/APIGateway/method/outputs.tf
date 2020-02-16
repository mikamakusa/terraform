output "http_method" {
value = aws_api_gateway_method.api_method.*.http_method
}