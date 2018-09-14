resource "digitalocean_floating_ip" "floating_ip" {
  count      = "${length(var.floating_ip)}"
  region     = "${lookup(var.floating_ip[count.index], "region")}"
  droplet_id = "${lookup(var.floating_ip[count.index], "droplet_id")}"
}
