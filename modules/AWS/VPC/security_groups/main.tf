resource "aws_security_group" "security_group" {
  count       = length(var.security_group)
  name        = lookup(var.security_group[count.index], "name")
  description = lookup(var.security_group[count.index], "description")
  vpc_id      = element(var.vpc_id, lookup(var.security_group[count.index], "vpc_id"))
  tags        = lookup(var.security_group[count.index], "tags")
}