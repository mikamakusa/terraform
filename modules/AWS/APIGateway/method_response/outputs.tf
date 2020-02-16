output "status_code" {
  value = aws_api_gateway_method_response.method_response.*.status_code
}