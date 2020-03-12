resource "aws_db_security_group" "security_group" {
  count       = length(var.security_group)
  name        = lookup(var.security_group[count.index], "name")
  description = lookup(var.security_group[count.index], "description")

  dynamic "ingress" {
    for_each = lookup(var.security_group[count.index], "ingress")
    content {
      cidr                    = lookup(ingress.value, "cidr")
      security_group_id       = element(var.security_group_id, lookup(ingress.value, "security_group_id"))
      security_group_name     = element(var.security_group_name, lookup(ingress.value, "security_group_id"))
      security_group_owner_id = element(var.security_group_owner_id, lookup(var.security_group[count.index], "security_group_id"))
    }
  }

  tags = var.tags
}