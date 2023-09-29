data "digitalocean_certificate" "this" {
  name = var.certificate_name
}

data "digitalocean_region" "this" {
  slug = var.region
}

data "digitalocean_droplet" "this" {
  count = length(var.droplet_id)
  name  = var.droplet_id
}

data "digitalocean_vpc" "this" {
  name = var.vpc_name
}

data "digitalocean_project" "this" {
  name = var.project_name
}