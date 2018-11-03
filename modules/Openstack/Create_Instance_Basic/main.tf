data "openstack_networking_secgroup_v2" "os_sec_group" {
  count = "${length(var.os_instance)}"
  name  = "${lookup(var.os_instance[count.index],"name")}"
}

data "openstack_networking_network_v2" "os_network" {
  count = "${length(var.network)}"
  name  = "${lookup(var.network[count.index],"name")}"
}

resource "openstack_compute_keypair_v2" "os_keypair" {
  count      = "${length(var.os_keypair)}"
  name       = "${lookup(var.os_keypair[count.index],"name")}"
  public_key = "${lookup(var.os_keypair[count.index],"key_file")}"
}

resource "openstack_compute_instance_v2" "os_instance" {
  count       = "${length(var.os_instance)}"
  name        = "${lookup(var.os_instance[count.index],"name")}"
  image_name  = "${lookup(var.os_instance[count.index],"image_name")}"
  flavor_name = "${lookup(var.os_instance[count.index],"flavor_name")}"
  key_pair    = "${element(openstack_compute_keypair_v2.os_keypair.*.id,lookup(var.os_instance[count.index],"key_pair_id"))}"

  security_groups = [
    "${var.default_sec_group}",
    "${element(data.openstack_networking_secgroup_v2.os_sec_group.*.id,lookup(var.os_instance[count.index],"sec_group_id"))}",
  ]

  network {
    name        = "${data.openstack_networking_network_v2.os_network.name}"
    fixed_ip_v4 = "${lookup(var.os_instance[count.index],"fixed_ip_v4")}"
  }
}

resource "openstack_compute_floatingip_associate_v2" "os_floatip_assoc" {
  count       = "${length(var.float_ip)}"
  floating_ip = "${lookup(var.float_ip[count.index],"floating_ip")}"
  instance_id = "${element(openstack_compute_instance_v2.os_instance.*.id,lookup(var.float_ip[count.index],"id_instance"))}"
}