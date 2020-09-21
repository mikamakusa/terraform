resource "google_firebase_web_app" "web_app" {
  depends_on   = [var.depends]
  count        = length(var.firebase_web_app)
  provider     = "google-beta"
  project      = element(var.firebase_project, lookup(var.firebase_web_app[count.index], "project_id"))
  display_name = lookup(var.firebase_web_app[count.index], "display_name")
}
