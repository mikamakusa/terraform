output "capacity_provider_name" {
  value = aws_ecs_capacity_provider.capacity_provider.*.name
}