output "autoscaling_group_name" {
  value = aws_autoscaling_group.autoscalling_group.*.name
}