resource "google_bigquery_dataset" "dataset" {
  count                           = ""
  dataset_id                      = ""
  friendly_name                   = ""
  description                     = ""
  location                        = ""
  default_table_expiration_ms     = ""
  default_partition_expiration_ms = ""
  labels                          = {}
  project                         = ""

  dynamic "access" {
    for_each = ""
    content {
      domain         = ""
      group_by_email = ""
      role           = ""
      special_group  = ""
      user_by_email  = ""
      view {
        dataset_id = ""
        project_id = ""
        table_id   = ""
      }
    }
  }

  dynamic "default_encryption_configuration" {
    for_each = ""
    content {
      kms_key_name = ""
    }
  }
}
