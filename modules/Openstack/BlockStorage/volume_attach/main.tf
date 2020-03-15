resource "openstack_blockstorage_volume_attach_v2" "volume_attach" {
  count       = length(var.volume_attach)
  host_name   = lookup(var.volume_attach[count.index], "host_name")
  volume_id   = element(var.volume_id, lookup(var.volume_attach[count.index], "volume_id"))
  region      = lookup(var.volume_attach[count.index], "region", null)
  attach_mode = lookup(var.volume_attach[count.index], "attach_mode", null)
  device      = lookup(var.volume_attach[count.index], "device", null)
  initiator   = lookup(var.volume_attach[count.index], "initiator", null)
  ip_address  = lookup(var.volume_attach[count.index], "ip_address", null)
  multipath   = lookup(var.volume_attach[count.index], "multipath", null)
  os_type     = lookup(var.volume_attach[count.index], "os_type", null)
  platform    = lookup(var.volume_attach[count.index], "platform", null)
  wwnn        = lookup(var.volume_attach[count.index], "wwnn", null)
  wwpn        = [lookup(var.volume_attach[count.index], "wwpn", null)]
}