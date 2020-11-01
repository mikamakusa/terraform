resource "digitalocean_container_registry" "container_registry" {
  count = length(var.container_registry)
  name = lookup(var.container_registry[count.index], "name")
}