output "record_fqdn" {
  value = digitalocean_record.do_record.*.fqdn
}

output "record_id" {
  value = digitalocean_record.do_record.*.id
}