output "id" {
  value = google_pubsub_topic.topic.*.id
}
