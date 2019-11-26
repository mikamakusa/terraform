resource "cloudstack_vpc" "vpc" {
  count          = length(var.vpc)
  cidr           = lookup(var.vpc[count.index], "cidr")
  name           = lookup(var.vpc[count.index], "name")
  vpc_offering   = lookup(var.vpc[count.index], "vpc_offering")
  zone           = lookup(var.vpc[count.index], "zone")
  display_text   = lookup(var.vpc[count.index], "display_test", null)
  network_domain = lookup(var.vpc[count.index], "network_domain", null)
  project        = lookup(var.vpc[count.index], "project", null)
}