resource "google_secret_manager_secret" "secret" {
  count     = length(var.secret)
  provider  = "google-beta"
  secret_id = lookup(var.secret[count.index], "secret_id")
  project   = var.project
  labels    = lookup(var.secret[count.index], "labels")

  dynamic "replication" {
    for_each = [for i in lookup(var.secret[count.index], "replication") : {
      automatic    = i.automatic
      user_managed = lookup(i, "user_managed")
    }]
    content {
      automatic = replication.value.automatic
      dynamic "user_managed" {
        for_each = replication.value.user_manager == null ? [] : [for i in replication.value.user_managed : {
          replicas = lookup(i, "replicas")
        }]
        content {
          dynamic "replicas" {
            for_each = [for i in user_managed.value.replicas : {
              location = i.location
            }]
            content {
              location = replicas.value.location
            }
          }
        }
      }
    }
  }
}
