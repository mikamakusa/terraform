resource "digitalocean_spaces_bucket" "space_bucket" {
  count         = length(var.buckets)
  name          = lookup(var.buckets[count.index], "name")
  region        = lookup(var.buckets[count.index], "region")
  acl           = lookup(var.buckets[count.index], "acl")
  force_destroy = lookup(var.buckets[count.index], "force_destroy", false)

  dynamic "cors_rule" {
    for_each = lookup(var.buckets[count.index], "cors_rule")
    content {
      allowed_headers = lookup(cors_rule.value, "allowed_headers", null)
      allowed_methods = lookup(cors_rule.value, "allowed_methods")
      allowed_origins = lookup(cors_rule.value, "allowed_origins")
      max_age_seconds = lookup(cors_rule.value, "max_age_seconds")
    }
  }
}