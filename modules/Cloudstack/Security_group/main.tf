resource "cloudstack_security_group" "security_group" {
  count       = length(var.security_group)
  name        = lookup(var.security_group[count.index], "name")
  description = lookup(var.security_group[count.index], "description", null)
  project     = lookup(var.security_group[count.index], "project", null)
}

resource "cloudstack_security_group_rule" "security_group_rule" {
  count             = length(var.security_group) == "0" ? "0" : length(var.security_group_rule)
  security_group_id = element(cloudstack_security_group.security_group.*.id, lookup(var.security_group_rule[count.index], "security_group_id"))
  parallelism       = lookup(var.security_group_rule[count.index], "parallelism", false)
  project           = lookup(var.security_group_rule[count.index], "project", null)

  dynamic "rule" {
    for_each = lookup(var.security_group_rule[count.index], "rule")
    content {
      protocol                 = lookup(rule.value, "protocol")
      cidr_list                = [lookup(rule.value, "cidr_list", null)]
      icmp_code                = lookup(rule.value, "icmp_code", null)
      icmp_type                = lookup(rule.value, "icmp_type", null)
      traffic_type             = lookup(rule.value, "traffic_type", null)
      ports                    = [lookup(rule.value, "ports", null)]
      user_security_group_list = [lookup(rule.value, "user_security_group_list", null)]
    }
  }
}