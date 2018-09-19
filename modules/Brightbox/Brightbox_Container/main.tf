resource "brightbox_container" "bbx_container" {
  count       = "${length(var.container)}"
  name        = "${lookup(var.container[count.index],"name")}"
  description = "${lookup(var.container[count.index],"description")}"
  orbit_url   = "${lookup(var.container[count.index],"url") ? 1 : 0}"
}
