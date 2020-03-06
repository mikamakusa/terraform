resource "aws_alb" "alb" {
  count              = length(var.alb)
  name               = lookup(var.alb[count.index], "name")
  internal           = lookup(var.alb[count.index], "internal", false)
  load_balancer_type = lookup(var.alb[count.index], "load_balancer_type", null)
  security_groups    = var.security_group_id
  subnets            = var.subnet_id
  tags               = var.tags
}