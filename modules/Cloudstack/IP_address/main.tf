resource "cloudstack_ipaddress" "ipaddress" {
  count       = length(var.ipaddress)
  is_portable = lookup(var.ipaddress[count.index], "is_portable", null)
  network_id  = element(var.network, lookup(var.ipaddress[count.index], "network_id", null))
  vpc_id      = element(var.vpc_id, lookup(var.ipaddress[count.index], "vpc_id", null))
  zone        = lookup(var.ipaddress[count.index], "zone", null)
  project     = lookup(var.ipaddress[count.index], "project", null)
}