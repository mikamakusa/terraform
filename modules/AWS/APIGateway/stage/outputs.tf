output "stage_name" {
  value = aws_api_gateway_stage.stage.*.stage_name
}