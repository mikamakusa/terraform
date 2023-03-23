resource "netbox_tag" "tag" {
  count       = length(var.tag)
  name        = lookup(var.tag[count.index], "name")
  color_hex   = lookup(var.tag[count.index], "color_hex", "9e9e9e")
  description = lookup(var.tag[count.index], "description", null)
  slug        = lookup(var.tag[count.index], "slug", null)
  tags        = lookup(var.tag[count.index], "tags", {})
}