resource "aws_elasticache_security_group" "security_group" {
  count                = length(var.security_group)
  name                 = lookup(var.security_group[count.index], "name")
  security_group_names = [var.security_group_names]
}