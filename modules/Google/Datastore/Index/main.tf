resource "google_datastore_index" "datastore_index" {
  count    = length(var.datastore_index)
  kind     = lookup(var.datastore_index[count.index], "kind")
  ancestor = lookup(var.datastore_index[count.index], "ancestor")
  project  = var.project

  dynamic "properties" {
    for_each = lookup(var.datastore_index[count.index], "properties")
    content {
      direction = lookup(properties.value, "direction")
      name      = lookup(properties.value, "name")
    }
  }
}
