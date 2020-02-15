resource "aws_elasticache_subnet_group" "subnet_group" {
  count      = length(var.subnet_group)
  name       = lookup(var.subnet_group[count.index], "name")
  subnet_ids = [var.subnet_ids]
}