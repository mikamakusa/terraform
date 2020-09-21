output "id" {
  value = google_datastore_index.datastore_index.*.id
}

output "index_id" {
  value = google_datastore_index.datastore_index.*.index_id
}
