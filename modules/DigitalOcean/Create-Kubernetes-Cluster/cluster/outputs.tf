output "cluster_id" {
  value = digitalocean_kubernetes_cluster.do_kube_cluster.*.id
}