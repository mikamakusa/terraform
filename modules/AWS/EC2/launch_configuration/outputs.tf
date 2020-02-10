output "launch_configuration_name" {
  value = aws_launch_configuration.launch_configuration.*.name
}