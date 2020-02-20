resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
  count                 = length(var.node_pool)
  name                  = lookup(var.node_pool[count], "name")
  kubernetes_cluster_id = lookup(var.node_pool[count], "kubernetes_cluster_id")
  vm_size               = lookup(var.node_pool[count], "vm_size")
  availability_zones    = lookup(var.node_pool[count], "availability_zones")
  enable_auto_scaling   = lookup(var.node_pool[count], "enable_auto_scaling")
  enable_node_public_ip = lookup(var.node_pool[count], "enable_node_public_ip")
  max_pods              = lookup(var.node_pool[count], "max_pods")
  node_taints           = lookup(var.node_pool[count], "node_taints")
  os_disk_size_gb       = lookup(var.node_pool[count], "os_disk_size_gb")
  os_type               = lookup(var.node_pool[count], "os_type")
  vnet_subnet_id        = lookup(var.node_pool[count], "vnet_subnet_id") == "" ? var.vnet_subnet_id : element(var.vnet_subnet_id, lookup(var.node_pool[count.index], "vnet_subnet_id"))
  max_count             = lookup(var.node_pool[count], "enable_auto_scaling") == true ? lookup(var.node_pool[count.index], "max_count") : []
  min_count             = lookup(var.node_pool[count], "enable_auto_scaling") == true ? lookup(var.node_pool[count.index], "min_count") : []
  node_count            = lookup(var.node_pool[count], "enable_auto_scaling") == false ? lookup(var.node_pool[count.index], "node_count") : []
}
