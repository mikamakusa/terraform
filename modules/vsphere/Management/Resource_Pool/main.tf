resource "vsphere_resource_pool" "resource_pool" {
  for_each = var.resource_pool
  name                    = each.key
  parent_resource_pool_id = each.value.parent_resource_pool_id

  cpu_share_level    = var.config.cpu_share_level
  cpu_expandable     = var.config.cpu_expandable
  cpu_limit          = var.config.cpu_limit
  cpu_reservation    = var.config.cpu_reservation
  cpu_shares         = var.config.cpu_shares
  memory_expandable  = var.config.memory_expandable
  memory_limit       = var.config.memory_limit
  memory_reservation = var.config.memory_reservation
  memory_share_level = var.config.memory_share_level
  memory_shares      = var.config.memory_shares
  tags               = var.config.tags
}