resource "digitalocean_firewall" "do_firewall" {
  count       = length(var.do_firewall)
  name        = lookup(var.do_firewall[count.index], "name", null)
  droplet_ids = [element(var.droplet_ids, lookup(var.do_firewall[count.index], "droplet_ids"), null)]
  tags        = lookup(var.do_firewall[count.index], "tags", null)

  dynamic "inbound_rule" {
    for_each = lookup(var.do_firewall[count.index], "inbound_rule")
    content {
      protocol                  = lookup(inbound_rule.value, "protocol")
      port_range                = lookup(inbound_rule.value, "port_range", null)
      source_addresses          = [lookup(inbound_rule.value, "source_addresses", null)]
      source_droplet_ids        = [lookup(inbound_rule.value, "source_droplet_ids", null)]
      source_tags               = [lookup(inbound_rule.value, "source_tags", null)]
      source_load_balancer_uids = [lookup(inbound_rule.value, "source_load_balancer_uids", null)]
    }
  }

  dynamic "outbound_rule" {
    for_each = lookup(var.do_firewall[count.index], "outbound_rule")
    content {
      protocol                       = lookup(outbound_rule.value, "protocol")
      port_range                     = lookup(outbound_rule.value, "port_range", null)
      destination_addresses          = [lookup(outbound_rule.value, "destination_addresses", null)]
      destination_droplet_ids        = [lookup(outbound_rule.value, "destination_droplet_ids", null)]
      destination_tags               = [lookup(outbound_rule.value, "destination_tags", null)]
      destination_load_balancer_uids = [lookup(outbound_rule.value, "destination_load_balancer_uids", null)]
    }
  }
}
