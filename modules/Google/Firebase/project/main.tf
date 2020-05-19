resource "google_firebase_project" "firebase_project" {
  count    = length(var.firebase_project)
  provider = "google-beta"
  project  = lookup(var.firebase_project[count.index], "project")
}
