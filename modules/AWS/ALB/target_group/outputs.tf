output "target_group_arn" {
  value = aws_alb_target_group.target_group.*.arn
}