output "autoscaling_group_name" {
  value = aws_autoscaling_group.autoscalling_group.*.name
}

output "autoscaling_group_arn" {
  value = aws_autoscaling_group.autoscalling_group.*.arn
}