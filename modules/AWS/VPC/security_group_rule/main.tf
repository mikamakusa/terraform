resource "aws_security_group_rule" "security_group_rule" {
  count             = length(var.security_group_rule)
  from_port         = lookup(var.security_group_rule[count.index], "from_port")
  protocol          = lookup(var.security_group_rule[count.index], "protocol")
  security_group_id = element(var.security_group_id, lookup(var.security_group_rule[count.index], "security_group_id"))
  to_port           = lookup(var.security_group_rule[count.index], "to_port")
  type              = lookup(var.security_group_rule[count.index], "type")
  cidr_blocks       = [lookup(var.security_group_rule[count.index], "cidr_blocks")]
}