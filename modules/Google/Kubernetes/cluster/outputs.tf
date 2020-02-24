output "k8s_cluster_id" {
  value = google_container_cluster.cluster.*.id
}

output "k8s_cluster_name" {
  value = google_container_cluster.cluster.*.name
}