output "do_db_cluster_id" {
  value = digitalocean_database_cluster.do_db_cluster.*.id
}

output "do_db_cluster_name" {
  value = digitalocean_database_cluster.do_db_cluster.*.name
}

output "do_db_cluster_engine" {
  value = digitalocean_database_cluster.do_db_cluster.*.engine
}

output "do_db_user_role" {
  value = digitalocean_database_user.do_db_user.*.role
}

output do_db_user_password {
  value = digitalocean_database_user.do_db_user.*.password
}