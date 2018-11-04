data "openstack_networking_secgroup_v2" "os_sec_group" {
  count = "${length(var.os_loadbalancer)}"
  name  = "${lookup(var.os_loadbalancer[count.index],"name")}"
}

resource "openstack_lb_loadbalancer_v2" "os_loadbalancer" {
  count              = "${length(var.os_loadbalancer)}"
  name               = "${lookup(var.os_loadbalancer,"name")}"
  description        = "${lookup(var.os_loadbalancer,"description")}"
  admin_state_up     = "${lookup(var.os_loadbalancer,"admn_state_up")}"
  flavor             = "${lookup(var.os_loadbalancer,"flavor")}"
  vip_subnet_id      = "${lookup(var.os_loadbalancer,"vip_subnet_id")}"
  region             = "${lookup(var.os_loadbalancer,"region")}"
  security_group_ids = [
    "${element(data.openstack_networking_secgroup_v2.os_sec_group.*.id,lookup(var.os_loadbalancer,"sec_group_id"))}"
  ]
}

resource "openstack_lb_listener_v2" "os_lb_listener" {
  count           = "${ "${length(var.os_loadbalancer)}" == "0" ? "0" : "${length(var.os_listener)}" }"
  name            = "${lookup(var.os_listener,"name")}"
  description     = "${lookup(var.os_listener,"description")}"
  admin_state_up  = "${lookup(var.os_listener,"admin_state_up")}"
  loadbalancer_id = "${element(openstack_lb_loadbalancer_v2.os_loadbalancer.*.id,lookup(var.os_listener,"load_balancer_id"))}"
  protocol        = "${lookup(var.os_listener,"protocol")}"
  protocol_port   = "${lookup(var.os_listener,"protocol_port")}"
  region          = "${lookup(var.os_listener,"region")}"
}

resource "openstack_lb_pool_v2" "os_lb_pool" {
  count           = "${length(var.os_lbpool)}"
  name            = "${lookup(var.os_lbpool,"name")}"
  description     = "${lookup(var.os_lbpool,"description")}"
  loadbalancer_id = "${element(openstack_lb_loadbalancer_v2.os_loadbalancer.*.id,lookup(var.os_lbpool,"load_balancer_id"))}"
  listener_id     = "${element(openstack_lb_listener_v2.os_lb_listener.*.id,lookup(var.os_lbpool,"listener_id"))}"
  admin_state_up  = "${lookup(var.os_lbpool,"admin_state_up")}"
  region          = "${lookup(var.os_lbpool,"region")}"
  lb_method       = "${lookup(var.os_lbpool,"lb_method")}"
  protocol        = "${lookup(var.os_lbpool,"protocol")}"

  persistence {
    type        = "${lookup(var.os_lbpool,"persistence_type")}"
    cookie_name = "${lookup(var.os_lbpool,"persistence_cookie_type")}"
  }
}

resource "openstack_lb_member_v2" "os_lb_member" {
  count          = "${length(var.os_lbmember)}"
  name           = "${lookup(var.os_lbmember,"name")}"
  admin_state_up = "${lookup(var.os_lbmember,"admin_state_up")}"
  address        = "${lookup(var.os_lbmember,"address")}"
  pool_id        = "${element(openstack_lb_pool_v2.os_lb_pool.*.id,lookup(var.os_lbmember,"lbpool_id"))}"
  protocol_port  = "${lookup(var.os_lbmember,"protocol_port")}"
}
