resource "google_bigquery_dataset" "ggl_bq_dset" {
  count                       = length(var.ggl_bq_dset)
  dataset_id                  = lookup(var.ggl_bq_dset[count.index], "dataset_id")
  friendly_name               = lookup(var.ggl_bq_dset[count.index], "friendly_name")
  description                 = lookup(var.ggl_bq_dset[count.index], "desc")
  location                    = lookup(var.ggl_bq_dset[count.index], "location")
  default_table_expiration_ms = lookup(var.ggl_bq_dset[count.index], "expiration_ms")

  dynamic "default_encryption_configuration" {
    for_each = lookup(var.ggl_bq_dset[count.index], "default_encryption_configuration")
    content {
      kms_key_name = element(var.kms_key_name, lookup(default_encryption_configuration.value, "kms_key_id"))
    }
  }

  dynamic "access" {
    for_each = lookup(var.ggl_bq_dset[count.index], "access")
    content {
      domain         = lookup(access.value, "domain", null)
      group_by_email = lookup(access.value, "group_by_email", null)
      role           = lookup(access.value, "role", null)
      special_group  = lookup(access.value, "special_group", null)

    }
  }

  dynamic "view" {
    for_each = lookup(var.ggl_bq_dset[count.index], "view")
    content {
      dataset_id = element(google_bigquery_dataset.ggl_bq_dset.*.id, lookup(view.value, "dataset_id"))
      project_id = element(var.project_id, lookup(view.value, "project_id"))
      table_id   = element(google_bigquery_table.ggl_bq_table.*.id, lookup(view.value, "table_id"))
    }
  }
  labels = lookup(var.ggl_bq_dset[count.index], "labels")
}

resource "google_bigquery_table" "ggl_bq_table" {
  count           = length(var.ggl_bq_table) == "0" ? "0" : length(var.ggl_bq_dset)
  dataset_id      = element(google_bigquery_dataset.ggl_bq_dset.*.id, lookup(var.ggl_bq_table[count.index], "dataset_id"))
  table_id        = lookup(var.ggl_bq_table[count.index], "table_id")
  project         = var.project
  description     = lookup(var.ggl_bq_table[count.index], "description")
  expiration_time = lookup(var.ggl_bq_table[count.index], "expiration_time")
  friendly_name   = lookup(var.ggl_bq_table[count.index], "friendly_name")
  schema          = file(lookup(var.ggl_bq_table[count.index], "schema"))

  dynamic "time_partitioning" {
    for_each = lookup(var.ggl_bq_table[count.index], "time_partitioning")
    content {
      type                     = lookup(time_partitioning.value, "type")
      expiration_ms            = lookup(time_partitioning.value, "expiration_ms", null)
      field                    = lookup(time_partitioning.value, "field", null)
      require_partition_filter = lookup(time_partitioning.value, "require_partition_filter", false)
    }
  }

  dynamic "external_data_configuration" {
    for_each = lookup(var.ggl_bq_table[count.index], "external_data_configuration")
    content {
      autodetect    = lookup(external_data_configuration.value, "autodetect", false)
      source_format = lookup(external_data_configuration.value, "source_format")
      source_uris   = [lookup(external_data_configuration.value, "source_uris", null)]
      google_sheets_options {
        range             = lookup(external_data_configuration.value, "range", null)
        skip_leading_rows = lookup(external_data_configuration.value, "skip_leading_rows", true)
      }
      csv_options {
        quote                 = lookup(external_data_configuration.value, "quote")
        allow_jagged_rows     = lookup(external_data_configuration.value, "allow_jagged_rows", false)
        allow_quoted_newlines = lookup(external_data_configuration.value, "allow_quoted_newlines", false)
        skip_leading_rows     = lookup(external_data_configuration.value, "skip_leading_rows", true)
        encoding              = lookup(external_data_configuration.value, "encoding", null)
        field_delimiter       = lookup(external_data_configuration.value, "field_delimiter", null)
      }
    }
  }

  dynamic "view" {
    for_each = lookup(var.ggl_bq_table[count.index], "view")
    content {
      query          = lookup(view.value, "query")
      use_legacy_sql = lookup(view.value, "use_legacy_sql", true)
    }
  }

  labels = lookup(var.ggl_bq_table[count.index], "labels", null)
}

resource "google_bigquery_data_transfer_config" "data_transfer_config" {
  count                    = length(var.data_transfer_config)
  data_source_id           = lookup(var.data_transfer_config[count.index], "data_source_id")
  destination_dataset_id   = element(google_bigquery_dataset.ggl_bq_dset.*.id, lookup(var.data_transfer_config[count.index], "destination_dataset_id"))
  display_name             = lookup(var.data_transfer_config[count.index], "display_name")
  location                 = lookup(var.data_transfer_config[count.index], "location", null)
  schedule                 = lookup(var.data_transfer_config[count.index], "schedule", null)
  data_refresh_window_days = lookup(var.data_transfer_config[count.index], "data_refresh_window_days", null)
  disabled                 = lookup(var.data_transfer_config[count.index], "disabled", true)
  project                  = element(var.project, lookup(var.data_transfer_config[count.index], "project", null))
  params                   = lookup(var.data_transfer_config[count.index], "params")
}