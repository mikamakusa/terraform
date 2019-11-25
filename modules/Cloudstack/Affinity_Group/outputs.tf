output "affinity_group_id" {
  value = cloudstack_affinity_group.affinity_group.*.id
}