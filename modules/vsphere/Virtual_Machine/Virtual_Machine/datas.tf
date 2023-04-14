data "vsphere_datacenter" "datacenter" {
  name = var.datacenter != "" ? 1 : 0
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster != "" ? 1 : 0
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore_cluster" "datastore_cluster" {
  name          = var.datastore_cluster != "" ? 1 : 0
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_resource_pool" "resource_pool" {
  name          = format("%s%s", data.vsphere_compute_cluster.cluster.name, "/Resources")
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore != "" ? 1 : 0
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

data "vsphere_host" "host" {
  count         = var.vsphere_host != "" ? 1 : 0
  datacenter_id = data.vsphere_datacenter.datacenter.id
  name          = var.vsphere_host
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

data "vsphere_ovf_vm_template" "ovf_template" {
  for_each         = toset(keys({ for k, v in var.ovf_template : k => v }))
  host_system_id   = data.vsphere_host.host.id
  name             = var.ovf_template[each.value]["name"]
  resource_pool_id = data.vsphere_resource_pool.resource_pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  remote_ovf_url   = var.ovf_template[each.value]["remote_ovf_url"]
  local_ovf_path   = var.ovf_template[each.value]["local_ovf_path"]
  ovf_network_map  = var.ovf_template[each.value]["ovf_network_map"]
}