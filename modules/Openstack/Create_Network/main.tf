resource "openstack_networking_network_v2" "os_network" {
  count          = "${length(var.network)}"
  name           = "${lookup(var.network[count.index],"name")}"
  admin_state_up = "${lookup(var.network[count.index],"admin_state_up")}"
  region         = "${lookup(var.network[count.index],"region")}"
}

resource "openstack_networking_subnet_v2" "os_subnet" {
  count      = "${length(var.subnet)}"
  cidr       = "${lookup(var.subnet[count.index],"cidr")}"
  network_id = "${element(openstack_networking_network_v2.os_network.*.id,lookup(var.subnet[count.index],"id_network"))}"
  ip_version = "${lookup(var.subnet[count.index],"ip_version")}"
  region     = "${lookup(var.subnet[count.index],"region")}"
  name       = "${lookup(var.subnet[count.index],"name")}"
}

resource "openstack_networking_router_v2" "os_router" {
  count               = "${length(var.router)}"
  name                = "${lookup(var.router[count.index],"name")}"
  admin_state_up      = "${lookup(var.router[count.index],"admin_state_up")}"
  region              = "${lookup(var.router[count.index],"region")}"
  external_network_id = "${lookup(var.router[count.index],"external_network_id")}"
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  count     = "${ "${length(var.subnet)}" == "0" ? "0" : "${length(var.router)}" }"
  router_id = "${element(openstack_networking_router_v2.os_router.*.id,lookup(var.subnet[count.index],"subnet_id"))}"
  subnet_id = "${element(openstack_networking_subnet_v2.os_subnet.*.id,lookup(var.router[count.index],"router_id"))}"
}
