resource "aws_alb_target_group" "target_group" {
  count       = length(var.target_group)
  name        = lookup(var.target_group[count.index], "name")
  port        = lookup(var.target_group[count.index], "port")
  protocol    = lookup(var.target_group[count.index], "protocol")
  vpc_id      = element(var.vpc_id, lookup(var.target_group[count.index], "vpc_id"))
  target_type = lookup(var.target_group[count.index], "target_type")

  dynamic "health_check" {
    for_each = lookup(var.target_group[count.index], "health_check")
    content {
      healthy_threshold   = lookup(health_check.value, "healthy_threshold")
      unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold")
      interval            = lookup(health_check.value, "interval")
      matcher             = lookup(health_check.value, "matcher")
      path                = lookup(health_check.value, "path")
      port                = lookup(health_check.value, "port")
      protocol            = lookup(health_check.value, "protocol")
      timeout             = lookup(health_check.value, "timeout")
    }
  }

  tags = var.tags
}