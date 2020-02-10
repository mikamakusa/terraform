resource "aws_subnet_group" "subnet_group" {
  count      = length(var.subnet_group)
  name       = lookup(var.subnet_group[count.index], "name")
  subnet_ids = [element(var.subnet_group_id, lookup(var.subnet_group[count.index], "subnet_ids"))]
}