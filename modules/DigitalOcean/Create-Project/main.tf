resource "digitalocean_project" "project" {
  count       = length(var.project)
  name        = lookup(var.project[count.index], "name")
  description = lookup(var.project[count.index], "description", null)
  purpose     = lookup(var.project[count.index], "purpose", null)
  environment = lookup(var.project[count.index], "environment", null)
  resources   = [element(var.droplets, lookup(var.project[count.index], "resources_id"))]
}