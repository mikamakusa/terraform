output "backup" {
  value = try(
    google_alloydb_backup.this
  )
}

output "cluster" {
  value = try(
    google_alloydb_cluster.this
  )
}

output "instance" {
  value = try(
    google_alloydb_instance.this
  )
}

output "user" {
  value = try(
    google_alloydb_user.this
  )
}