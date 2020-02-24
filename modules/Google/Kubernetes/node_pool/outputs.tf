output "node_pool_id" {
  value = google_container_node_pool.node_pool.*.id
}

output "node_pool_name" {
  value = google_container_node_pool.node_pool.*.name
}

output "node_pool_cluster" {
  value = google_container_node_pool.node_pool.*.cluster
}