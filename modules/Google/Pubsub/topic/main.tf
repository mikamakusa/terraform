resource "google_pubsub_topic" "topic" {
  count        = length(var.topic)
  name         = lookup(var.topic[count.index], "name")
  project      = var.project
  labels       = lookup(var.topic[count.index], "labels")
  kms_key_name = element(var.kms_key_name, lookup(var.topic[count.index], "kms_key_id"))

  dynamic "message_storage_policy" {
    for_each = lookup(var.topic[count.index], "message_storage_policy")
    content {
      allowed_persistence_regions = [lookup(message_storage_policy.value, "allowed_persistence_regions")]
    }
  }
}
