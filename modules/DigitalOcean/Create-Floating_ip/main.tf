resource "digitalocean_floating_ip" "floating_ip" {
  count      = length(var.floating_ip)
  region     = lookup(var.floating_ip[count.index], "region")
  droplet_id = lookup(var.floating_ip[count.index], "droplet_id", null)
}

resource "digitalocean_floating_ip_assignment" "floating_ip_assignment" {
  count      = length(var.floating_ip) == "0" ? "0" : length(var.floating_ip_assignment)
  droplet_id = element(var.droplet_id, lookup(var.floating_ip_assignment[count.index], "droplet_id"))
  ip_address = element(digitalocean_floating_ip.floating_ip.*.ip_address, lookup(var.floating_ip_assignment[count.index], "ip_address_id"))
}
