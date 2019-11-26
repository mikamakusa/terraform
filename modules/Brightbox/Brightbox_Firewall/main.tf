resource "brightbox_firewall_policy" "bbx_firewal_policy" {
  count        = length(var.fw_policy)
  name         = lookup(var.fw_policy[count.index],"name")
  server_group = var.server_group
  description  = lookup(var.fw_policy[count.index],"description")
}

resource "brightbox_firewall_rule" "bbx_firewall_rule" {
  count            = length(var.fw_policy) == "0" ? "0" : length(var.fw_rule)
  firewall_policy  = element(brightbox_firewall_policy.bbx_firewal_policy.*.name,lookup(var.fw_rule[count.index],"fw_policy"))
  description      = lookup(var.fw_rule[count.index],"description")
  protocol         = lookup(var.fw_rule[count.index],"protocol")
  source           = lookup(var.fw_rule[count.index],"source")
  source_port      = lookup(var.fw_rule[count.index],"src_port")
  destination      = lookup(var.fw_rule[count.index],"destination")
  destination_port = lookup(var.fw_rule[count.index],"dest_port")
  icmp_type_name   = lookup(var.fw_rule[count.index],"icmp_type")
}
