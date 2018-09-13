resource "digitalocean_volume" "do_volume" {
  count       = "${length(var.do_volumes)}"
  name        = "${lookup(var.do_volumes[count.index], "name")}-vol"
  region      = "${lookup(var.do_volumes[count.index], "region")}"
  size        = "${lookup(var.do_volumes[count.index], "size")}"
  description = "${lookup(var.do_volumes[count.index], "description")}"
}
