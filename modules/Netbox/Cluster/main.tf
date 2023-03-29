resource "netbox_cluster" "cluster" {
  count            = length(var.cluster)
  cluster_type_id  = element(var.cluster_type_id, lookup(var.cluster[count.index], "cluster_type_id", null))
  name             = lookup(var.cluster[count.index], "name")
  cluster_group_id = element(var.cluster_group_id, lookup(var.cluster[count.index], "cluster_group_id", null))
  site_id          = element(var.site_id, lookup(var.cluster[count.index], "site_id", null))
  tags             = lookup(var.cluster[count.index], "tags", [])
  tenant_id        = element(var.tenant_id, lookup(var.cluster[count.index], "tenant_id", null))
}