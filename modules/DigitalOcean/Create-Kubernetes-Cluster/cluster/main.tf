resource "digitalocean_kubernetes_cluster" "do_kube_cluster" {
  count   = length(var.kube_cluster)
  name    = join("-", [var.prefix, lookup(var.kube_cluster[count.index], "name"), lookup(var.kube_cluster[count.index], "id"), "cluster"])
  region  = var.region
  version = lookup(var.kube_cluster[count.index],"version")

  dynamic"node_pool" {
    for_each = lookup(var.kube_cluster[count.index], "node_pool")
    content {
      name       = lookup(node_pool.value, "node_pool_name")
      node_count = lookup(node_pool.value, "node_count")
      size       = lookup(node_pool.value,"size")
    }
  }
}