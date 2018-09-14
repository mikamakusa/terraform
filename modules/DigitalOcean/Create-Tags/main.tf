resource "digitalocean_tag" "do_tag" {
  count = "${length(var.tag_name)}"
  name = "${lookup(var.tag_name[count.index], "name")}"
}