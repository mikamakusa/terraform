resource "aws_alb_listener" "listener" {
  count             = length(var.listener)
  load_balancer_arn = element(var.load_balancer_arn, lookup(var.listener[count.index], "load_balancer_id"))
  port              = lookup(var.listener[count.index], "port")
  protocol          = lookup(var.listener[count.index], "protocol")

  dynamic "default_action" {
    for_each = lookup(var.listener[count.index], "default_action")
    content {
      type             = lookup(default_action.value, "type")
      target_group_arn = element(var.target_group_arn, lookup(default_action.value, "target_group_id"))
    }
  }
}