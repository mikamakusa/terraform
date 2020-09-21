output "id" {
  value = google_pubsub_subscription.subscription.*.id
}

output "path" {
  value = google_pubsub_subscription.subscription.*.path
}
