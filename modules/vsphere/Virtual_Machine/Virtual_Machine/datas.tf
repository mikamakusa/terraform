data "vsphere_datacenter" "datacenter" {
  name = var.datacenter != "" ? 1 : 0
}
data "vsphere_datastore_cluster" "datastore_cluster" {
  name          = var.datastore_cluster != "" ? 1 : 0
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_datastore" "datastore" {
  name          = var.datastore != "" ? 1 : 0
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_resource_pool" "resource_pool" {
  name          = var.resource_pool
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_network" "network" {
  count         = length(var.network)
  name          = keys(var.network)[count.index]
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_tag_category" "tag_category" {
  count = var.tags != null ? length(var.tags) : 0
  name  = keys(var.tags)[count.index]
}
data "vsphere_tag" "tag" {
  count       = var.tags != null ? length(var.tags) : 0
  category_id = data.vsphere_tag_category.tag_category[count.index].id
  name        = var.tags[keys(var.tags)[count.index]]
}

data "vsphere_folder" "folder" {
  path = var.folder
}

data "vsphere_storage_policy" "storage_policy" {
  name = var.storage_policy
}

data "vsphere_virtual_machine" "template" {
  count         = var.template_name != "" ? 1 : 0
  name          = var.template_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}