resource "aws_default_security_group" "default_security_group" {
  count  = length(var.default_security_group)
  vpc_id = element(var.vpc_id, lookup(var.default_security_group[count.index], "vpc_id"))

  dynamic "ingress" {
    for_each = lookup(var.default_security_group[count.index], "ingress")
    content {
      self      = true
      from_port = lookup(ingress.value, "from_port")
      to_port   = lookup(ingress.value, "to_port")
      protocol  = lookup(ingress.value, "protocol")
    }
  }

  dynamic "egress" {
    for_each = lookup(var.default_security_group[count.index], "egress")
    content {
      self        = true
      from_port   = lookup(egress.value, "from_port")
      to_port     = lookup(egress.value, "to_port")
      protocol    = lookup(egress.value, "protocol")
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}