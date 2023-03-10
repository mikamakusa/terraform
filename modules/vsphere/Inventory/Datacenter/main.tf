resource "vsphere_datacenter" "datacenter" {
  for_each          = var.datacenter
  name              = each.key
  folder            = each.value.folder
  tags              = each.value.tags
  custom_attributes = each.value.custom_attributes
}