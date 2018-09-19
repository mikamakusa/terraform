resource "openstack_blockstorage_volume_v3" "os_blk_stor" {
  count                = "${length(var.var_os_blk_stor)}"
  region               = "${var.region ? 1 : 0}"
  name                 = "${lookup(var.var_os_blk_stor[count.index],"name")? 1 : 0}"
  size                 = "${lookup(var.var_os_blk_stor[count.index],"size")}"
  description          = "${lookup(var.var_os_blk_stor[count.index],"description")? 1 : 0}"
  enable_online_resize = "${lookup(var.var_os_blk_stor[count.index],"online_resize")? 1 : 0}"
  availability_zone    = "${lookup(var.var_os_blk_stor[count.index],"availability_zone")? 1 : 0}"
  consistency_group_id = "${lookup(var.var_os_blk_stor[count.index],"consistency_group_id")? 1 : 0}"
  image_id             = "${lookup(var.var_os_blk_stor[count.index],"image_id")? 1 : 0}"
  snapshot_id          = "${lookup(var.var_os_blk_stor[count.index],"snapshot_id")? 1 : 0}"
  source_replica       = "${lookup(var.var_os_blk_stor[count.index],"source_replica")? 1 : 0}"
  source_vol_id        = "${lookup(var.var_os_blk_stor[count.index],"source_vol_id")? 1 : 0}"
  volume_type          = "${lookup(var.var_os_blk_stor[count.index],"vol_type")? 1 : 0}"
}

resource "openstack_blockstorage_volume_attach_v3" "os_blk_stor_attach" {
  depends_on  = ["openstack_blockstorage_volume_v3.os_blk_stor"]
  region      = "${var.region ? 1 : 0}"
  count       = "${length(var.var_os_blk_stor_attach)}"
  host_name   = "${lookup(var.var_os_blk_stor_attach[count.index],"host_name")}"
  volume_id   = "${element(openstack_blockstorage_volume_v3.os_blk_stor.*.id,lookup(var.var_os_blk_stor_attach[count.index],"volume_id"))}"
  device      = "${lookup(var.var_os_blk_stor_attach[count.index],"device")? 1 : 0}"
  ip_address  = "${lookup(var.var_os_blk_stor_attach[count.index],"ip_address")? 1 : 0}"
  initiator   = "${lookup(var.var_os_blk_stor_attach[count.index],"initiator")? 1 : 0}"
  os_type     = "${lookup(var.var_os_blk_stor_attach[count.index],"os")? 1 : 0}"
  platform    = "${var.platform}"
  multipath   = "${lookup(var.var_os_blk_stor_attach[count.index],"multipath")? 1 : 0}"
  wwnn        = "${lookup(var.var_os_blk_stor_attach[count.index],"wwnn")? 1 : 0}"
  wwpn        = ["${lookup(var.var_os_blk_stor_attach[count.index],"wwpn")? 1 : 0}"]
  attach_mode = "${lookup(var.var_os_blk_stor_attach[count.index],"attach_mode")? 1 : 0}"
}
