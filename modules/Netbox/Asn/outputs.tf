output "rir_id" {
  value = netbox_rir.rir.*.id
}

output "asn_id" {
  value = netbox_asn.asn.*.id
}