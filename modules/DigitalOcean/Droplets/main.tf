resource "digitalocean_droplet" "do_droplets" {
  count              = "${length(var.droplets)}"
  name               = "${lookup(var.droplets[count.index], "name")}-${lookup(var.droplets[count.index], "id")}"
  region             = "${lookup(var.droplets[count.index], "region")}"
  image              = "${lookup(var.droplets[count.index], "image")}"
  size               = "${lookup(var.droplets[count.index], "size")}"
  backups            = "${lookup(var.droplets[count.index], "backups")}"
  monitoring         = "${lookup(var.droplets[count.index], "monitoring")}"
  ipv6               = "${lookup(var.droplets[count.index], "ipv6")}"
  private_networking = "${lookup(var.droplets[count.index], "private_net")}"
  resize_disk        = "${lookup(var.droplets[count.index], "resize_disk")}"
  volume_ids         = "${lookup(var.droplets[count.index], "volume_id")}"
  tags               = "[${var.droplets_tags}]"
  ssh_keys           = "${lookup(var.droplets[count.index], "ssh_key_id")}"
}
