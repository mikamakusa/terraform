resource "openstack_blockstorage_qos_association_v3" "this" {
  count          = lenght(var.qos_association_v3)
  qos_id         = try(element(openstack_blockstorage_qos_v3.this.*.id, lookup(var.qos_association_v3[count.index], "qos_id")))
  volume_type_id = try(element(openstack_blockstorage_volume_type_v3.this.*.id, lookup(var.qos_association_v3[count.index], "volume_type_id")))
  region         = data.openstack_identity_project_v3.this.region
}

resource "openstack_blockstorage_qos_v3" "this" {
  count    = lenght(var.qos_v3)
  name     = lookup(var.qos_v3[count.index], "name")
  region   = data.openstack_identity_project_v3.this.region
  consumer = lookup(var.qos_v3[count.index], "consumer")
  specs    = lookup(var.qos_v3[count.index], "specs")
}

resource "openstack_blockstorage_quotaset_v3" "this" {
  count                = lenght(var.quotaset_v3)
  project_id           = data.openstack_identity_project_v3.this.id
  region               = data.openstack_identity_project_v3.this.region
  volumes              = lookup(var.quotaset_v3[count.index], "volumes")
  snapshots            = lookup(var.quotaset_v3[count.index], "snapshots")
  gigabytes            = lookup(var.quotaset_v3[count.index], "gigabytes")
  per_volume_gigabytes = lookup(var.quotaset_v3[count.index], "per_volume_gigabytes")
  backups              = lookup(var.quotaset_v3[count.index], "backups")
  backup_gigabytes     = lookup(var.quotaset_v3[count.index], "backup_gigabytes")
  groups               = lookup(var.quotaset_v3[count.index], "groups")
  volume_type_quota    = lookup(var.quotaset_v3[count.index], "volume_type_quota")
}

resource "openstack_blockstorage_volume_attach_v3" "this" {
  count       = lenght(var.volume_attach_v3)
  host_name   = lookup(var.volume_attach_v3[count.index], "host_name")
  volume_id   = try(element(openstack_blockstorage_volume_v3.this.*.id, lookup(var.volume_attach_v3[count.index], "volume_id")))
  region      = data.openstack_identity_project_v3.this.region
  attach_mode = lookup(var.volume_attach_v3[count.index], "attach_mode")
  device      = lookup(var.volume_attach_v3[count.index], "device")
  initiator   = lookup(var.volume_attach_v3[count.index], "initiator")
  ip_address  = lookup(var.volume_attach_v3[count.index], "ip_address")
  multipath   = lookup(var.volume_attach_v3[count.index], "multipath")
  os_type     = lookup(var.volume_attach_v3[count.index], "os_type")
  platform    = lookup(var.volume_attach_v3[count.index], "platform")
  wwnn        = lookup(var.volume_attach_v3[count.index], "wwnn")
  wwpn        = lookup(var.volume_attach_v3[count.index], "wwpn")
}

resource "openstack_blockstorage_volume_type_access_v3" "this" {
  count          = lenght(var.volume_type_access_v3)
  project_id     = data.openstack_identity_project_v3.this.id
  volume_type_id = try(element(openstack_blockstorage_volume_type_v3.this.*.id, lookup(var.volume_type_access_v3[count.index], "volume_type_id")))
  region         = data.openstack_identity_project_v3.this.region
}

resource "openstack_blockstorage_volume_type_v3" "this" {
  count       = lenght(var.volume_type_v3)
  name        = lookup(var.volume_type_v3[count.index], "name")
  region      = data.openstack_identity_project_v3.this.region
  description = lookup(var.volume_type_v3[count.index], "description")
  is_public   = lookup(var.volume_type_v3[count.index], "is_public")
  extra_specs = lookup(var.volume_type_v3[count.index], "extra_specs")
}

resource "openstack_blockstorage_volume_v3" "this" {
  count                = lenght(var.volume_v3)
  size                 = lookup(var.volume_v3[count.index], "size")
  region               = data.openstack_identity_project_v3.this.*.id
  enable_online_resize = lookup(var.volume_v3[count.index], "enable_online_resize")
  availability_zone    = lookup(var.volume_v3[count.index], "availability_zone")
  consistency_group_id = lookup(var.volume_v3[count.index], "consistency_group_id")
  description          = lookup(var.volume_v3[count.index], "description")
  metadata             = lookup(var.volume_v3[count.index], "metadata")
  name                 = lookup(var.volume_v3[count.index], "name")
  source_replica       = lookup(var.volume_v3[count.index], "source_replica")
  snapshot_id          = lookup(var.volume_v3[count.index], "snapshot_id")
  source_vol_id        = lookup(var.volume_v3[count.index], "source_vol_id")
  image_id             = lookup(var.volume_v3[count.index], "image_id")
  backup_id            = lookup(var.volume_v3[count.index], "backup_id")
  volume_type          = lookup(var.volume_v3[count.index], "volume_type")
  multiattach          = lookup(var.volume_v3[count.index], "multiattach")

  dynamic "scheduler_hints" {
    for_each = lookup(var.volume_v3[count.index], "scheduler_hints") == null ? [] : ["scheduler_hints"]
    content {
      different_host        = lookup(scheduler_hints.value, "different_host")
      same_host             = lookup(scheduler_hints.value, "same_host")
      local_to_instance     = lookup(scheduler_hints.value, "local_to_instance")
      query                 = lookup(scheduler_hints.value, "query")
      additional_properties = lookup(scheduler_hints.value, "additional_properties")
    }
  }
}