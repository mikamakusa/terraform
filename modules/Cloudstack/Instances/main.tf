resource "cloudstack_ssh_keypair" "ssh_keypair" {
  count = length(var.ssh_keypair)
  name = lookup(var.ssh_keypair[count.index], "name")
  public_key = file(join(".", [join("/", [path.cwd, "keypair", lookup(var.ssh_keypair[count.index], "keypair", null)]), "key"]))
  project = lookup(var.ssh_keypair[count.index], "project", null)
}

resource "cloudstack_instance" "instances" {
  count                = length(var.instance)
  service_offering     = lookup(var.instance[count.index], "service_offering")
  template             = lookup(var.instance[count.index], "template")
  zone                 = lookup(var.instance[count.index], "zone")
  display_name         = lookup(var.instance[count.index], "display_name", null)
  network_id           = element(var.network_id, lookup(var.instance[count.index], "network_id", null))
  ip_address           = lookup(var.ip_address, lookup(var.instance[count.index], "ip_address", null))
  root_disk_size       = lookup(var.instance[count.index], "root_disk_size", null)
  group                = lookup(var.instance[count.index], "group", null)
  affinity_group_names = [element(var.affinity_group, lookup(var.instance[count.index], "affinity_group_id", null))]
  security_group_names = [element(var.security_group, lookup(var.instance[count.index], "security_group_id", null))]
  project              = lookup(var.instance, "project", null)
  start_vm             = lookup(var.instance, "start_vm", true)
  user_data            = file(join(".", [join("/", [path.cwd, "user_data", lookup(var.instance[count.index], "user_data", null)]), "sh"]))
  keypair              = element(cloudstack_ssh_keypair.ssh_keypair.*.name, lookup(var.instance[count.index], "keypair_id", null))
  expunge              = lookup(var.instance[count.index], "expunge", true)
}