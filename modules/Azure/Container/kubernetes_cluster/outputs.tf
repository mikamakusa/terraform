output "kubernetes_cluster_id" {
  value = azurerm_kubernetes_cluster.kubnernetes_cluster.*.id
}