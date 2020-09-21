resource "google_secret_manager_secret_version" "secret_version" {
  count       = length(var.secret_version)
  provider    = "google-beta"
  secret      = element(var.secret, lookup(var.secret_version[count.index], "secret_id"))
  secret_data = lookup(var.secret_version[count.index], "secret_data")
}
