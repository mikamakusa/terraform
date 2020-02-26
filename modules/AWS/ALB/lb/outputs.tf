output "lb_arn" {
  value = aws_alb.alb.*.arn
}