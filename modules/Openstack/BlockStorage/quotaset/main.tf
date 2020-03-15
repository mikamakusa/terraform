resource "openstack_blockstorage_quotaset_v2" "quotaset" {
  count                = length(var.quotasets)
  project_id           = var.project_id
  region               = lookup(var.quotasets[count.index], "region")
  volumes              = lookup(var.quotasets[count.index], "volumes")
  snapshots            = lookup(var.quotasets[count.index], "snapshots")
  gigabytes            = lookup(var.quotasets[count.index], "gigabytes")
  per_volume_gigabytes = lookup(var.quotasets[count.index], "per_volume_gigabytes")
  backups              = lookup(var.quotasets[count.index], "backups")
  backup_gigabytes     = lookup(var.quotasets[count.index], "backup_gigabytes")
  groups               = lookup(var.quotasets[count.index], "groups")
}