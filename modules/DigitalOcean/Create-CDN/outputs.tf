output "cdn_id" {
  value = digitalocean_cdn.cdn.*.id
}

output cdn_certificate_id {
  value = digitalocean_cdn.cdn.*.certificate_id
}

output "cdn_endpoint" {
  value = digitalocean_cdn.cdn.*.endpoint
}

output "cdn_created_at" {
  value = digitalocean_cdn.cdn.*.created_at
}

output "cdn_ttl" {
  value = digitalocean_cdn.cdn.*.ttl
}

output "cdn_custom_domain" {
  value = digitalocean_cdn.cdn.*.custom_domain
}