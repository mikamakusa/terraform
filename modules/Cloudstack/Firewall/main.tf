resource "cloudstack_firewall" "firewall" {
  count         = length(var.firewall)
  ip_address_id = element(var.ip_address, lookup(var.firewall[count.index], "ip_address_id"))
  managed       = lookup(var.firewall[count.index], "managed", false)
  parallelism   = lookup(var.firewall[count.index], "parallelism", null)

  dynamic "rule" {
    for_each = lookup(var.firewall[count.index], "rule")
    content {
      cidr_list = [lookup(rule.value, "cidr_list")]
      protocol  = lookup(rule.value, "protocol")
      icmp_type = lookup(rule.value, "icmp_type", null)
      icmp_code = lookup(rule.value, "icmp_code", null)
      ports     = [lookup(rule.value, "ports", null)]
    }
  }
}