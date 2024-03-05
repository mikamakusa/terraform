resource "oci_ai_anomaly_detection_ai_private_endpoint" "this" {
  count          = length(var.private_endpoint)
  compartment_id = data.oci_identity_compartment.this.compartment_id
  dns_zones      = lookup(var.private_endpoint[count.index], "dns_zones")
  subnet_id      = data.oci_core_subnet.this.subnet_id
  display_name   = lookup(var.private_endpoint[count.index], "display_name")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.private_endpoint[count.index], "defined_tags")
  )
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.private_endpoint[count.index], "freeform_tags")
  )
}

resource "oci_ai_anomaly_detection_data_asset" "this" {
  count          = length(var.data_asset) == "0" ? "0" : length(var.project)
  compartment_id = data.oci_identity_compartment.this.compartment_id
  project_id     = try(element(oci_ai_anomaly_detection_project.this.*.id, lookup(var.data_asset[count.index], "project_id")))
  display_name   = lookup(var.data_asset[count.index], "display_name")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.data_asset[count.index], "defined_tags")
  )
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.data_asset[count.index], "freeform_tags")
  )
  description         = lookup(var.data_asset[count.index], "description")
  private_endpoint_id = lookup(var.data_asset[count.index], "private_endpoint_id")

  dynamic "data_source_details" {
    for_each = lookup(var.data_asset[count.index], "data_source_details")
    content {
      data_source_type          = lookup(data_source_details.value, "data_source_type")
      atp_password_secret_id    = lookup(data_source_details.value, "data_source_type") == "ORACLE_ATP" ? lookup(data_source_details.value, "atp_password_secret_id") : null
      atp_user_name             = lookup(data_source_details.value, "data_source_type") == "ORACLE_ATP" ? lookup(data_source_details.value, "atp_user_name") : null
      bucket                    = lookup(data_source_details.value, "data_source_type") == "ORACLE_OBJECT_STORAGE" ? lookup(data_source_details.value, "bucket") : null
      cwallet_file_secret_id    = lookup(data_source_details.value, "data_source_type") == "ORACLE_ATP" ? lookup(data_source_details.value, "cwallet_file_secret_id") : null
      database_name             = lookup(data_source_details.value, "data_source_type") == "ORACLE_ATP" ? lookup(data_source_details.value, "database_name") : null
      ewallet_file_secret_id    = lookup(data_source_details.value, "data_source_type") == "ORACLE_ATP" ? lookup(data_source_details.value, "ewallet_file_secret_id") : null
      key_store_file_secret_id  = lookup(data_source_details.value, "data_source_type") == "ORACLE_ATP" ? lookup(data_source_details.value, "key_store_file_secret_id") : null
      measurement_name          = lookup(data_source_details.value, "measurement_name")
      namespace                 = lookup(data_source_details.value, "data_source_type") == "ORACLE_OBJECT_STORAGE" ? lookup(data_source_details.value, "namespace") : null
      object                    = lookup(data_source_details.value, "data_source_type") == "ORACLE_OBJECT_STORAGE" ? lookup(data_source_details.value, "object") : null
      ojdbc_file_secret_id      = lookup(data_source_details.value, "data_source_type") == "ORACLE_ATP" ? lookup(data_source_details.value, "ojdbc_file_secret_id") : null
      password_secret_id        = lookup(data_source_details.value, "data_source_type") == "INFLUX" ? lookup(data_source_details.value, "password_secret_id") : null
      table_name                = lookup(data_source_details.value, "data_source_type") == "ORACLE_ATP" ? lookup(data_source_details.value, "table_name") : null
      tnsnames_file_secret_id   = lookup(data_source_details.value, "data_source_type") == "ORACLE_ATP" ? lookup(data_source_details.value, "tnsnames_file_secret_id") : null
      truststore_file_secret_id = lookup(data_source_details.value, "data_source_type") == "ORACLE_ATP" ? lookup(data_source_details.value, "truststore_file_secret_id") : null
      url                       = lookup(data_source_details.value, "data_source_type") == "INFLUX" ? lookup(data_source_details.value, "url") : null
      user_name                 = lookup(data_source_details.value, "data_source_type") == "INFLUX" ? lookup(data_source_details.value, "user_name") : null
      wallet_password_secret_id = lookup(data_source_details.value, "data_source_type") == "ORACLE_ATP" ? lookup(data_source_details.value, "wallet_password_secret_id") : null

      dynamic "version_specific_details" {
        for_each = lookup(data_source_details.value, "data_source_type") == "INFLUX" ? lookup(data_source_details.value, "version_specific_details") : []
        content {
          influx_version        = lookup(version_specific_details.value, "influx_version")
          bucket                = lookup(version_specific_details.value, "bucket")
          database_name         = lookup(version_specific_details.value, "database_name")
          organization_name     = lookup(version_specific_details.value, "organization_name")
          retention_policy_name = lookup(version_specific_details.value, "retention_policy_name")
        }
      }
    }
  }
}

resource "oci_ai_anomaly_detection_detect_anomaly_job" "this" {
  count          = length(var.anomaly_job) == "0" ? "0" : length(var.model)
  compartment_id = data.oci_identity_compartment.this.compartment_id
  model_id = try(
    element(oci_ai_anomaly_detection_model.this.*.id, lookup(var.anomaly_job[count.index], "model_id"))
  )
  description  = lookup(var.model[count.index], "description")
  display_name = lookup(var.model[count.index], "display_name")
  sensitivity  = lookup(var.model[count.index], "sensitivity")

  dynamic "input_details" {
    for_each = lookup(var.model[count.index], "input_details")
    content {
      input_type   = lookup(input_details.value, "input_type")
      content      = lookup(input_details.value, "content")
      content_type = lookup(input_details.value, "content_type")
      signal_names = lookup(input_details.value, "signal_names")

      dynamic "data" {
        for_each = lookup(input_details.value, "data") == null ? [] : ["data"]
        content {
          timestamp = lookup(data.value, "timestamp")
          values    = lookup(data.value, "values")
        }
      }
      dynamic "object_locations" {
        for_each = lookup(input_details.value, "object_locations") == null ? [] : ["object_locations"]
        content {
          bucket    = lookup(object_locations.value, "bucket")
          namespace = lookup(object_locations.value, "namespace")
          object    = lookup(object_locations.value, "object")
        }
      }
    }
  }

  dynamic "output_details" {
    for_each = lookup(var.model[count.index], "output_details")
    content {
      bucket      = lookup(output_details.value, "bucket")
      namespace   = lookup(output_details.value, "namespace")
      output_type = lookup(output_details.value, "output_type")
      prefix      = lookup(output_details.value, "prefix")
    }
  }
}

resource "oci_ai_anomaly_detection_model" "this" {
  count          = length(var.model) == "0" ? "0" : length(var.project)
  compartment_id = data.oci_identity_compartment.this.compartment_id
  project_id = try(
    element(oci_ai_anomaly_detection_project.this.*.id, lookup(var.model[count.index], "project_id"))
  )
  defined_tags = merge(
    var.defined_tags,
    lookup(var.model[count.index], "defined_tags")
  )
  description  = lookup(var.model[count.index], "description")
  display_name = lookup(var.model[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.model[count.index], "freeform_tags")
  )

  dynamic "model_training_details" {
    for_each = lookup(var.model[count.index], "model_training_details")
    content {
      data_asset_ids    = lookup(model_training_details.value, "data_asset_ids")
      algorithm_hint    = lookup(model_training_details.value, "algorithm_hint")
      target_fap        = lookup(model_training_details.value, "target_fap")
      training_fraction = lookup(model_training_details.value, "training_fraction")
      window_size       = lookup(model_training_details.value, "window_size")
    }
  }
}

resource "oci_ai_anomaly_detection_project" "this" {
  count          = length(var.project)
  compartment_id = data.oci_identity_compartment.this.compartment_id
  display_name   = lookup(var.project[count.index], "display_name")
  description    = lookup(var.project[count.index], "description")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.project[count.index], "defined_tags")
  )
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.project[count.index], "freeform_tags")
  )
}