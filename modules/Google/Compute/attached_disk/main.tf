resource "google_compute_attached_disk" "attached_disk" {
  count       = length(var.attached_disk)
  disk        = element(var.disk, lookup(var.attached_disk[count.index], "disk_id"))
  instance    = element(var.instance, lookup(var.attached_disk[count.index], "instance_id"))
  project     = var.project
  zone        = var.zone
  device_name = lookup(var.attached_disk[count.index], "device_name", null)
  mode        = lookup(var.attached_disk[count.index], "mode", null)
}
