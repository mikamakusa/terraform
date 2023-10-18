output "kubernertes_cluster" {
  value = try(azurerm_kubernetes_cluster.this)
}

output "kubernetes_cluster_node_pool" {
  value = try(azurerm_kubernetes_cluster_node_pool.this)
}

output "log_analytics_solution" {
  value = try(azurerm_log_analytics_solution.this)
}

output "role_assignment" {
  value = try(azurerm_role_assignment.this)
}

output "user_assigned_identity" {
  value = try(azurerm_user_assigned_identity)
}