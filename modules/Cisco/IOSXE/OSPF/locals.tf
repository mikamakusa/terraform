locals {
  file       = yamldecode(file(join("/", [path.cwd, var.inventory_file])))
  ospf = lookup(local.file, "ospf")
  devices    = lookup(local.file, "devices")
}