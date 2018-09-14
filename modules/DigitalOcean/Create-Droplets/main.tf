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
  volume_ids         = ["${element(var.volume_ids, count.index)}"]
  tags               = ["${element(var.droplets_tags, count.index)}"]
  ssh_keys           = "${lookup(var.droplets[count.index], "ssh_key_id")}"
}
