locals {
  file       = yamldecode(file(join("/", [path.cwd, var.inventory_file])))
  interfaces = lookup(local.file, "interfaces")
  devices    = lookup(local.file, "devices")
}