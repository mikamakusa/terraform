resource "aws_security_group" "security_group" {
  count       = length(var.security_group)
  name        = lookup(var.security_group[count.index], "name")
  description = lookup(var.security_group[count.index], "description")
  vpc_id      = var.vpc_id
  tags        = lookup(var.security_group[count.index], "tags")
}

resource "aws_security_group_rule" "security_group_rules" {
  count             = length(var.security_group) == "0" ? "0" : length(var.security_rule)
  from_port         = lookup(var.security_rule[count.index],"from_port")
  protocol          = lookup(var.security_rule[count.index],"protocol")
  security_group_id = element(aws_security_group.security_group.*.id,lookup(var.security_rule[count.index],"security_group_id"))
  to_port           = lookup(var.security_rule[count.index],"to_port")
  type              = lookup(var.security_rule[count.index],"type")
}