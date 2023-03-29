output "cluster_id" {
  value = netbox_cluster.cluster.*.id
}