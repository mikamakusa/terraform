resource "openstack_networking_secgroup_v2" "sec_group" {
  count       = "${length(var.sec_group)}"
  name        = "${lookup(var.sec_group[count.index],"name")}"
  description = "${lookup(var.sec_group[count.index],"description")}"
  region      = "${lookup(var.sec_group[count.index],"region")}"
}

resource "openstack_networking_secgroup_rule_v2" "sec_group_rule" {
  count             = "${ "${length(var.sec_group)}" == "0" ? "0" : "${length(var.sec_group_rule)}" }"
  security_group_id = "${element(openstack_networking_secgroup_v2.sec_group.*.id,lookup(var.sec_group_rule[count.index],"sec_group_id"))}"
  direction         = "${lookup(var.sec_group_rule[count.index],"direction")}"
  ethertype         = "${lookup(var.sec_group_rule[count.index],"ethertype")}"
  protocol          = "${lookup(var.sec_group_rule[count.index],"protocol")}"
  port_range_min    = "${lookup(var.sec_group_rule[count.index],"port_range_min")}"
  port_range_max    = "${lookup(var.sec_group_rule[count.index],"port_range_max")}"
  remote_ip_prefix  = "${lookup(var.sec_group_rule[count.index],"remote_ip_prefix")}"
  region            = "${lookup(var.sec_group_rule[count.index],"region")}"
}
