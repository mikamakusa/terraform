resource "digitalocean_droplet" "do_droplets" {
  count              = length(var.droplets)
  name               = join("-", [lookup(var.droplets[count.index], "name", null), lookup(var.droplets[count.index], "id", null)])
  region             = lookup(var.droplets[count.index], "region")
  image              = lookup(var.droplets[count.index], "image")
  size               = lookup(var.droplets[count.index], "size")
  backups            = lookup(var.droplets[count.index], "backups", null)
  monitoring         = lookup(var.droplets[count.index], "monitoring", null)
  ipv6               = lookup(var.droplets[count.index], "ipv6", null)
  private_networking = lookup(var.droplets[count.index], "private_net", null)
  resize_disk        = lookup(var.droplets[count.index], "resize_disk", false)
  volume_ids         = [element(var.volume_ids, lookup(var.droplets[count.index], "volume_ids")), null]
  tags               = lookup(var.droplets[count.index], "tags", null)
  ssh_keys           = element(var.ssh_keys, lookup(var.droplets[count.index], "ssh_key_id"), null)
  user_data          = lookup(var.droplets[count.index], "user_data", null)
}
