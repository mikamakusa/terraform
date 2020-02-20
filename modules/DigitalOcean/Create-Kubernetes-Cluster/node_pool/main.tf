resource "digitalocean_kubernetes_node_pool" "do_node_pool" {
  count      = length(var.node_pool)
  cluster_id = element(var.cluster_id, lookup(var.node_pool[count.index], "kube_cluster_id"))
  name       = join("-", [var.prefix, lookup(var.node_pool[count.index], "name"), lookup(var.node_pool[count.index], "id"), "pool"])
  node_count = lookup(var.node_pool[count.index], "node_count")
  size       = lookup(var.node_pool[count.index], "size")
}