output "id" {
  value = google_dialogflow_agent.agent.*.id
}

output "avatar_uri_backend" {
  value = google_dialogflow_agent.agent.*.avatar_uri_backend
}
