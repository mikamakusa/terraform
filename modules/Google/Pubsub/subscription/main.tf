resource "google_pubsub_subscription" "subscription" {
  count                = length(var.subscription)
  name                 = lookup(var.subscription[count.index], "name")
  project              = var.project
  topic                = element(var.topic, lookup(var.subscription[count.index], "topic_id"))
  ack_deadline_seconds = lookup(var.subscription[count.index], "ack_deadline_seconds")
  labels               = lookup(var.subscription[count.index], "labels")

  dynamic "push_config" {
    for_each = lookup(var.subscription[count.index], "push_config") == null ? [] : [for i in lookup(var.subscription[count.index], "push_config") : {
      push_endpoint = i.push_endpoint
      attributes    = i.attributes
      oidc_token    = lookup(i, "oidc_token", null)
    }]
    content {
      push_endpoint = push_config.value.push_endpoint
      attributes    = push_config.value.attributes
      dynamic "oidc_token" {
        for_each = push_config.value.oidc_token == null ? [] : [for i in push_config.value.oidc_token : {
          service_account_email = i.service_account_email
          audience              = i.audience
        }]
        content {
          service_account_email = oidc_token.value.service_account_email
          audience              = oidc_token.value.audience
        }
      }
    }
  }

  message_retention_duration = ""
  retain_acked_messages      = ""

  dynamic "expiration_policy" {
    for_each = lookup(var.subscription[count.index], "expiration_policy")
    content {
      ttl = lookup(expiration_policy.value, "ttls")
    }
  }

  dynamic "dead_letter_policy" {
    for_each = lookup(var.subscription[count.index], "dead_letter_policy")
    content {
      dead_letter_topic     = lookup(dead_letter_policy.value, "dead_letter_topic")
      max_delivery_attempts = lookup(dead_letter_policy.value, "max_delivery_attempts")
    }
  }
}
