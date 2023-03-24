resource "netbox_rir" "rir" {
  count = length(var.rir)
  name  = lookup(var.rir[count.index], "name")
  slug  = lookup(var.rir[count.index], "slug", null)
}