resource "openstack_fw_rule_v1" "os_fw_rule" {
  count                  = "${length(var.fw_rule)}"
  name                   = "${lookup(var.fw_rule,"name")}"
  description            = "${lookup(var.fw_rule,"description")}"
  region                 = "${lookup(var.fw_rule,"region")}"
  action                 = "${lookup(var.fw_rule,"action")}"
  protocol               = "${lookup(var.fw_rule,"protocol")}"
  destination_ip_address = "${lookup(var.fw_rule,"destination_ip_address")}"
  destination_port       = "${lookup(var.fw_rule,"desctnation_port")}"
  enabled                = "${lookup(var.fw_rule,"enabled")}"
}

resource "openstack_fw_policy_v1" "os_fw_policy" {
  count       = "${ "${length(var.fw_rule)}" == "0" ? "0" : "${length(var.fw_policy)}" }"
  name        = "${lookup(var.fw_policy,"name")}"
  description = "${lookup(var.fw_policy,"description")}"
  region      = "${lookup(var.fw_policy,"region")}"
  rules       = ["${element(openstack_fw_rule_v1.os_fw_rule.*.id,lookup(var.fw_policy,"rule_id"))}"]
}

resource "openstack_fw_firewall_v1" "os_firewall" {
  count          = "${ "${length(var.fw_policy)}" == "0" ? "0" : "${length(var.firewall)}" }"
  name           = "${lookup(var.firewall,"name")}}"
  description    = "${lookup(var.firewall,"description")}"
  admin_state_up = "${lookup(var.firewall,"admin_state_up")}"
  policy_id      = "${element(openstack_fw_policy_v1.os_fw_policy.*.id,lookup(var.firewall,"policy_id"))}"
}
