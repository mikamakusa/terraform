output "arn" {
  value = aws_db_instance.instance.*.arn
}

output "address" {
  value = aws_db_instance.instance.*.address
}

output "parameter_group_name" {
  value = aws_db_instance.instance.*.parameter_group_name
}

output "subnet_group_name" {
  value = aws_db_instance.instance.*.db_subnet_group_name
}

output "engine" {
  value = aws_db_instance.instance.*.engine
}

output "endpoint" {
  value = aws_db_instance.instance.*.endpoint
}

output "id" {
  value = aws_db_instance.instance.*.id
}