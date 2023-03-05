data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_host" "hosts" {
  count         = length(var.hosts)
  datacenter_id = data.vsphere_datacenter.dc.id
  name          = var.hosts[count.index]
}