resource "digitalocean_database_cluster" "do_db_cluster" {
  count      = length(var.db_cluster)
  name       = join("-", [var.prefix, lookup(var.db_cluster[count.index], "name")])
  node_count = lookup(var.db_cluster[count.index], "node_count")
  region     = var.region
  size       = lookup(var.db_cluster[count.index], "size")
  engine     = lookup(var.db_cluster[count.index], "engine")
  version    = lookup(var.db_cluster[count.index], "version")

  maintenance_window {
    day  = lookup(var.db_cluster[count.index], "day")
    hour = lookup(var.db_cluster[count.index], "hour")
  }
}

resource "digitalocean_database_db" "do_db" {
  count      = length(var.db_cluster) == "0" ? "0" : length(var.db)
  cluster_id = element(digitalocean_database_cluster.do_db_cluster.*.id, lookup(var.db[count.index], "cluster_id"))
  name       = lookup(var.db[count.index], "name")
}

resource "digitalocean_database_replica" "do_db_replica" {
  count      = length(var.db_cluster) == "0" ? "0" : length(var.db_replica)
  cluster_id = element(digitalocean_database_cluster.do_db_cluster.*.id, lookup(var.db_replica[count.index], "cluster_id"))
  name       = lookup(var.db_replica[count.index], "name")
  size       = lookup(var.db_replica[count.index], "size")
  region     = var.region
}

resource "digitalocean_database_user" "do_db_user" {
  count      = length(var.db_cluster) == "0" ? "0" : length(var.db_user)
  cluster_id = element(digitalocean_database_cluster.do_db_cluster.*.id, lookup(var.db_user[count.index], "cluster_id"))
  name       = lookup(var.db_user[count.index], "name")
}

resource "digitalocean_database_connection_pool" "do_db_connection_pool" {
  count      = length(var.db_cluster) == "0" ? "0" : length(var.connection_pool)
  cluster_id = element(digitalocean_database_cluster.do_db_cluster.*.id, lookup(var.connection_pool[count.index], "cluster_id"))
  name       = lookup(var.connection_pool[count.index], "name")
  mode       = lookup(var.connection_pool[count.index], "mode")
  size       = lookup(var.connection_pool[count.index], "size")
  db_name    = element(digitalocean_database_db.do_db.*.name, lookup(var.connection_pool[count.index], "database_id"))
  user       = element(digitalocean_database_user.do_db_user.*.name, lookup(var.connection_pool[count.index], "user_id"))
}