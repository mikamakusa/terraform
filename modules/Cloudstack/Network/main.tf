resource "cloudstack_network" "network" {
  count            = length(var.network)
  cidr             = lookup(var.network[count.index], "cidr")
  name             = lookup(var.network[count.index], "name")
  network_offering = lookup(var.network[count.index], "network_offering")
  zone             = lookup(var.network[count.index], "zone")
  display_text     = lookup(var.network[count.index], "display_text", null)
  startip          = lookup(var.network[count.index], "startip", null)
  endip            = lookup(var.network[count.index], "endip", null)
  network_domain   = lookup(var.network[count.index], "network_domain", null)
  vlan             = lookup(var.network[count.index], "vlan", null)
  vpc_id           = element(var.vpc_id, lookup(var.network[count.index], "vpc_id", null))
  acl_id           = element(cloudstack_network_acl.network_acl.*.id, lookup(var.network[count.index], "acl_id", null))
  project          = lookup(var.network[count.index], "project", null)
  source_nat_ip    = lookup(var.network[count.index], "source_nat_ip", null)
}

resource "cloudstack_network_acl" "network_acl" {
  count       = length(var.network_acl)
  name        = lookup(var.network_acl[count.index], "name")
  vpc_id      = element(var.vpc_id, lookup(var.network_acl[count.index], "vpc_id"))
  description = lookup(var.network_acl[count.index], "description", null)
  project     = lookup(var.network_acl[count.index], "project", null)
}

resource "cloudstack_network_acl_rule" "network_acl_rule" {
  count       = length(var.network_acl) == "0" ? "0" : length(var.network_acl_rule)
  acl_id      = element(cloudstack_network_acl.network_acl.*.id, lookup(var.network_acl_rule[count.index], "acl_id"))
  managed     = lookup(var.network_acl_rule[count.index], "managed", false)
  project     = lookup(var.network_acl_rule[count.index], "project", null)
  parallelism = lookup(var.network_acl_rule[count.index], "parallelism", null)

  dynamic "rule" {
    for_each = lookup(var.network_acl_rule[count.index], "rule")
    content {
      cidr_list    = [lookup(rule.value, "cidr_list")]
      protocol     = lookup(rule.value, "protocol")
      action       = lookup(rule.value, "action", null)
      icmp_code    = lookup(rule.value, "icmp_code", null)
      icmp_type    = lookup(rule.value, "icmp_type", null)
      traffic_type = lookup(rule.value, "traffic_type", null)
      ports        = [lookup(rule.value, "ports", null)]
    }
  }
}