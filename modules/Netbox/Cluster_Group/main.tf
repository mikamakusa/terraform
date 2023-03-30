resource "netbox_cluster_group" "cluster_group" {
  count = length(var.cluster_group)
  name  = lookup(var.cluster_group[count.index], "name")
  slug  = lookup(var.cluster_group[count.index], "slug", null)
}