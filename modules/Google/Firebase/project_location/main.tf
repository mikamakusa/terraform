resource "google_firebase_project_location" "project_location" {
  count       = length(var.project_location)
  location_id = lookup(var.project_location[count.index], "location_id")
  project     = element(var.firebase_project, lookup(var.project_location[count.index], "project_id"))
  provider    = "google-beta"
}
