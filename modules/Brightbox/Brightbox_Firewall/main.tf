resource "brightbox_firewall_policy" "bbx_firewal_policy" {
  count        = "${length(var.fw_policy)}"
  name         = "${lookup(var.fw_policy[count.index],"name")}"
  server_group = "${var.server_group}"
  description  = "${lookup(var.fw_policy[count.index],"description")}"
}

resource "brightbox_firewall_rule" "bbx_firewall_rule" {
  depends_on       = ["brightbox_firewall_policy.bbx_firewal_policy"]
  count            = "${length(var.fw_rule)}"
  firewall_policy  = "${element(brightbox_firewall_policy.bbx_firewal_policy.*.name,lookup(var.fw_rule[count.index],"fw_policy"))}"
  description      = "${lookup(var.fw_rule[count.index],"description")? 1 : 0}"
  protocol         = "${lookup(var.fw_rule[count.index],"protocol")? 1 : 0}"
  source           = "${lookup(var.fw_rule[count.index],"source")? 1 : 0}"
  source_port      = "${lookup(var.fw_rule[count.index],"src_port")? 1 : 0}"
  destination      = "${lookup(var.fw_rule[count.index],"destination")? 1 : 0}"
  destination_port = "${lookup(var.fw_rule[count.index],"dest_port")? 1 : 0}"
  icmp_type_name   = "${lookup(var.fw_rule[count.index],"icmp_type")? 1 : 0}"
}
