resource "digitalocean_cdn" "cdn" {
  count          = length(var.cdn)
  origin         = element(var.bucket_id, lookup(var.cdn[count.index], "bucket_id"))
  ttl            = lookup(var.cdn[count.index], "ttl", null)
  certificate_id = element(var.certificate_id, lookup(var.cdn[count.index], "certificate_id"), null)
  custom_domain  = lookup(var.cdn[count.index], "custom_domain", null)
}