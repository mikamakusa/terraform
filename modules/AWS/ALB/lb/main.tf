resource "aws_alb" "alb" {
  count              = length(var.alb)
  name               = lookup(var.alb[count.index], "name")
  internal           = lookup(var.alb[count.index], "internal", false)
  load_balancer_type = lookup(var.alb[count.index], "laod_balancer_type", null)
  security_groups    = [element(var.security_group_id, lookup(var.alb[count.index], "security_group_id"))]
  subnets            = [
    element(var.subnet_id, lookup(var.alb[count.index], "subnet_id_1")),
    element(var.subnet_id, lookup(var.alb[count.index], "subnet_id_2"))
  ]
  tags               = var.tags
}