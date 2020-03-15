resource "cloudstack_egress_firewall" "egress_firewall" {
  count       = length(var.egress_firewall)
  network_id  = element(var.network_id, lookup(var.egress_firewall[count.index], "network_id"))
  managed     = lookup(var.egress_firewall[count.index], "managed")
  parallelism = lookup(var.egress_firewall[count.index], "parallelism", null)

  dynamic "rule" {
    for_each = lookup(var.egress_firewall[count.index], "rule")
    content {
      cidr_list = lookup(rule.value, "cidr_list")
      protocol  = lookup(rule.value, "protocol")
      icmp_code = lookup(rule.value, "icmp_code", null)
      icmp_type = lookup(rule.value, "icmp_type", null)
      ports     = lookup(rule.value, "ports", null)
    }
  }
}