output "cluster_type_id" {
  value = netbox_cluster_type.cluster_type.*.id
}