resource "cloudstack_disk" "disk" {
  count              = length(var.disk)
  name               = lookup(var.disk[count.index], "name")
  zone               = lookup(var.disk[count.index], "zone")
  attach             = lookup(var.disk[count.index], "attach", true)
  device_id          = lookup(var.disk[count.index], "device_id", null)
  disk_offering      = lookup(var.disk[count.index], "disk_offering", null)
  size               = lookup(var.disk[count.index], "size", null)
  shrink_ok          = lookup(var.disk[count.index], "shrink_ok", false)
  virtual_machine_id = element(var.virtual_machine, lookup(var.disk[count.index], "virtual_machine_id", null))
  project            = lookup(var.disk[count.index], "project", null)
}