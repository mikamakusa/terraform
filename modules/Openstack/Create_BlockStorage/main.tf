resource "openstack_blockstorage_volume_v2" "os_blockstor" {
  count = "${length(var.os_blockstor)}"
  name  = "${lookup(var.os_blockstor,"name")}"
  size  = "${lookup(var.os_blockstor,"size")}"
}
