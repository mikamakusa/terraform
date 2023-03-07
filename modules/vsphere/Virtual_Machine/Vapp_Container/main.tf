resource "vsphere_vapp_container" "vapp_container" {
  for_each                = var.vapp
  name                    = each.key
  parent_resource_pool_id = each.value.parent_resource_pool_id
  parent_folder_id        = each.value.parent_folder_id
  cpu_share_level         = each.value.cpu_share_level
  cpu_shares              = each.value.cpu_shares
  cpu_reservation         = each.value.cpu_reservation
  cpu_expandable          = each.value.cpu_expandable
  cpu_limit               = each.value.cpu_limit
  memory_share_level      = each.value.memory_share_level
  memory_shares           = each.value.memory_shares
  memory_reservation      = each.value.memory_reservation
  memory_expandable       = each.value.memory_expandable
  memory_limit            = each.value.memory_limit
  tags                    = var.tags
}