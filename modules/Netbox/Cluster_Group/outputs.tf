output "cluster_group_id" {
  value = netbox_cluster_group.cluster_group.*.id
}