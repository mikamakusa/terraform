resource "aws_alb" "alb" {
  count              = length(var.alb)
  name               = lookup(var.alb[count.index], "name")
  internal           = lookup(var.alb[count.index], "internal", false)
  load_balancer_type = lookup(var.alb[count.index], "laod_balancer_type", null)
  security_groups    = [lookup(var.alb[count.index], "security_group_id") == [] ? var.security_group_id : (var.security_group_id, lookup(var.alb[count.index], "security_group_id"))]
  subnets            = [lookup(var.alb[count.index], "subnet_id") == [] ? var.subnet_id : element(var.subnet_id, lookup(var.alb[count.index], "subnet_id"))]
  tags               = var.tags
}