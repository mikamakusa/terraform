resource "digitalocean_kubernetes_cluster" "do_kube_cluster" {
  count   = "${length(var.kube_cluster)}"
  name    = "${var.prefix}-${lookup(var.kube_cluster[count.index],"name")}-${lookup(var.kube_cluster[count.index],"id")}-cluster"
  region  = "${var.region}"
  version = "${lookup(var.kube_cluster[count.index],"version")}"

  "node_pool" {
    name       = "${lookup(var.kube_cluster[count.index],"node_pool_name")}"
    node_count = "${lookup(var.kube_cluster[count.index],"node_count")}"
    size       = "${lookup(var.kube_cluster[count.index],"size")}"
  }
}

resource "digitalocean_kubernetes_node_pool" "do_node_pool" {
  count      = "${ "${length(var.kube_cluster}" == "0" ? "0" : "${length(var.node_pool}" }"
  cluster_id = "${element(digitalocean_kubernetes_cluster.do_kube_cluster.*.id,lookup(var.node_pool[count.index],"kube_cluster_id"))}"
  name       = "${var.prefix}-${lookup(var.node_pool[count.index],"name")}-${lookup(var.node_pool[count.index],"id")}-pool"
  node_count = "${lookup(var.node_pool[count.index],"node_count")}"
  size       = "${lookup(var.node_pool[count.index],"size")}"
}
