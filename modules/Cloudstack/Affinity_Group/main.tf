resource "cloudstack_affinity_group" "affinity_group" {
  count       = length(var.affinity_group)
  name        = lookup(var.affinity_group[count.index], "name")
  type        = lookup(var.affinity_group[count.index], "type")
  description = lookup(var.affinity_group[count.index], "description", null)
  project     = lookup(var.affinity_group[count.index], "project", null)
}