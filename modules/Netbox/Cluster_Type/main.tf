resource "netbox_cluster_type" "cluster_type" {
  count = length(var.cluster_type)
  name  = lookup(var.cluster_type[count.index], "name")
  slug  = lookup(var.cluster_type[count.index], "slug", null)
}