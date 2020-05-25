output "id" {
  value = google_dialogflow_intent.intent.*.id
}

output "name" {
  value = google_dialogflow_intent.intent.*.name
}

output "root_followup_intent_name" {
  value = google_dialogflow_intent.intent.*.root_followup_intent_name
}
