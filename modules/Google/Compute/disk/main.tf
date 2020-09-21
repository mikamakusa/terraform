resource "google_compute_disk" "disk" {
  count                     = length(var.disk)
  name                      = lookup(var.disk[count.index], "name")
  description               = lookup(var.disk[count.index], "description")
  labels                    = lookup(var.disk[count.index], "labels")
  size                      = lookup(var.disk[count.index], "size")
  physical_block_size_bytes = lookup(var.disk[count.index], "physical_block_size_bytes")
  type                      = lookup(var.disk[count.index], "type")
  image                     = lookup(var.disk[count.index], "image")
  resource_policies         = element(var.resource_policies, lookup(var.disk[count.index], "resource_policies_id"))
  zone                      = var.zone
  snapshot                  = lookup(var.disk[count.index], "snapshot")
  project                   = var.project

  dynamic "source_image_encryption_key" {
    for_each = lookup(var.disk[count.index], "source_image_encryption_key")
    content {
      raw_key           = lookup(source_image_encryption_key.value, "raw_key")
      kms_key_self_link = element(var.kms_key, lookup(source_image_encryption_key.value, "kms_key_id"))
    }
  }

  dynamic "source_snapshot_encryption_key" {
    for_each = lookup(var.disk[count.index], "source_snapshot_encryption_key")
    content {
      raw_key           = lookup(source_snapshot_encryption_key.value, "raw_key")
      kms_key_self_link = element(var.kms_key, lookup(source_snapshot_encryption_key.value, "kms_key_id"))
    }
  }

  dynamic "disk_encryption_key" {
    for_each = lookup(var.disk[count.index], "disk_encryption_key")
    content {
      raw_key           = lookup(disk_encryption_key.value, "raw_key")
      kms_key_self_link = element(var.kms_key, lookup(disk_encryption_key.value, "kms_key_id"))
    }
  }
}
