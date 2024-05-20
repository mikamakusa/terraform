output "app" {
  value = try(
    digitalocean_app.this.*.id
  )
}

output "vpc" {
  value = try(
    digitalocean_vpc.this.*.id
  )
}

output "droplet" {
  value = try(
    digitalocean_droplet.this.*.id
  )
}

output "certificate" {
  value = try(
    digitalocean_certificate.this.*.id
  )
}

output "tag" {
  value = try(
    digitalocean_tag.this.*.id
  )
}

output "volume" {
  value = try(
    digitalocean_volume.this.*.id
  )
}

output "database_cluster" {
  value = try(
    digitalocean_database_cluster.this.*.id
  )
}

output "database_db" {
  value = try(
    digitalocean_database_db.this.*.id
  )
}