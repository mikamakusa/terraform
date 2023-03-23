resource "netbox_rir" "rir" {
  count = length(var.rir)
  name  = lookup(var.rir[count.index], "name")
  slug  = lookup(var.rir[count.index], "slug")
}

resource "netbox_asn" "asn" {
  count  = length(var.asn)
  asn    = lookup(var.asn[count.index], "asn")
  rir_id = element(netbox_rir.rir.*.id, lookup(var.asn[count.index], "rir_id"))
  tags   = lookup(var.asn[count.index], "tags", [])
}