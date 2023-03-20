resource "netbox_manufacturer" "manufacturer" {
  count = length(var.manufacturer)
  name  = lookup(var.manufacturer[count.index], "name")
  slug  = lookup(var.manufacturer[count.index], "slug")
}