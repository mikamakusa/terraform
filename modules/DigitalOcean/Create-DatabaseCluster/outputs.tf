output "do_db_cluster_id" {
  value = digitalocean_database_cluster.do_db_cluster.*.id
}

output "do_db_cluster_name" {
  value = digitalocean_database_cluster.do_db_cluster.*.name
}

output "do_db_cluster_engine" {
  value = digitalocean_database_cluster.do_db_cluster.*.engine
}