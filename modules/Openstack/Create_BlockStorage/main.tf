resource "openstack_blockstorage_volume_v2" "volume" {
  count                = length(var.volume)
  name                 = lookup(var.volume[count.index], "name")
  size                 = lookup(var.volume[count.index], "size")
  region               = lookup(var.volume[count.index], "region", null)
  consistency_group_id = lookup(var.volume[count.index], "consistency_group_id", null)
  availability_zone    = lookup(var.volume[count.index], "availability_zone", null)
  description          = lookup(var.volume[count.index], "description", null)
  image_id             = lookup(var.volume[count.index], "image_id", null)
  snapshot_id          = lookup(var.volume[count.index], "snapshot_id", null)
  source_replica       = lookup(var.volume[count.index], "source_replica", null)
  source_vol_id        = lookup(var.volume[count.index], "source_vol_id", null)
  volume_type          = lookup(var.volume[count.index], "volume_type", null)
  metadata             = lookup(var.volume[count.index], "metadata", null)
}

resource "openstack_blockstorage_volume_attach_v2" "volume_attach" {
  count       = length(var.volume) == "0" ? "0" : length(var.volume_attach)
  host_name   = lookup(var.volume_attach[count.index], "host_name")
  volume_id   = element(openstack_blockstorage_volume_v2.volume.*.id, lookup(var.volume_attach[count.index], "volume_id"))
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

resource "openstack_blockstorage_quotaset_v2" "quotaset" {
  count                = length(var.quotasets)
  project_id           = element(var.project_id, lookup(var.quotasets[count.index], "project_id"))
  region               = lookup(var.quotasets[count.index], "region")
  volumes              = lookup(var.quotasets[count.index], "volumes")
  snapshots            = lookup(var.quotasets[count.index], "snapshots")
  gigabytes            = lookup(var.quotasets[count.index], "gigabytes")
  per_volume_gigabytes = lookup(var.quotasets[count.index], "per_volume_gigabytes")
  backups              = lookup(var.quotasets[count.index], "backups")
  backup_gigabytes     = lookup(var.quotasets[count.index], "backup_gigabytes")
  groups               = lookup(var.quotasets[count.index], "groups")
}