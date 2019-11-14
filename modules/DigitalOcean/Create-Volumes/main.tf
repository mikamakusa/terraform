resource "digitalocean_volume" "do_volume" {
  count                    = length(var.volumes)
  name                     = join("-", lookup(var.volumes[count.index], "name"), "vol")
  region                   = lookup(var.volumes[count.index], "region")
  size                     = lookup(var.volumes[count.index], "size")
  description              = lookup(var.volumes[count.index], "description", null)
  snapshot_id              = lookup(var.volumes[count.index], "snapshot_id", null)
  initial_filesystem_label = lookup(var.volumes[count.index], "initial_filesystem_label", null)
  initial_filesystem_type  = lookup(var.volumes[count.index], "inital_filesystem_type", null)
}

resource "digitalocean_volume_snapshot" "volume_snapshot" {
  count = length(var.volumes) == "0" ? "0" : length(var.snapshots)
  name = lookup(var.snapshots[count.index], "name")
  volume_id = element(digitalocean_volume.do_volume.*.id, lookup(var.snapshots[count.index], "volume_id"))
}

resource "digitalocean_volume_attachment" "volume_attachement" {
  count      = length(var.volumes) == "0" ? "0" : length(var.attachment)
  droplet_id = element(var.droplet_id, lookup(var.attachment[count.index], "droplet_id"))
  volume_id  = element(digitalocean_volume.do_volume.*.id, lookup(var.attachment[count.index], "volume_id"))
}