resource "aws_db_subnet_group" "db_subnet_group" {
  count      = length(var.db_subnet_group)
  name       = lookup(var.db_subnet_group[count.index], "name")
  subnet_ids = [var.subnet_ids]
}