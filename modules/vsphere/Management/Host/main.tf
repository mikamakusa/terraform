resource "vsphere_host" "host" {
  for_each        = var.host
  hostname        = each.key
  password        = each.value.password
  username        = each.value.username
  datacenter      = each.value.datacenter
  cluster         = each.value.cluster
  cluster_managed = each.value.cluster_managed
  thumbprint      = each.value.thumbprint
  license         = each.value.license
  force           = each.value.force
  connected       = each.value.connected
  maintenance     = each.value.maintenance
  lockdown        = each.value.lockdown
  tags            = each.value.tags
}