resource "oci_ai_language_endpoint" "this" {
  count          = length(var.endpoint) == "0" ? "0" : length(var.model)
  compartment_id = data.oci_identity_compartment.this.id
  model_id = try(
    data.oci_ai_language_model.this.id,
    element(oci_ai_language_model.this.*.id, lookup(var.endpoint[count.index], "model_id"))
  )
  defined_tags = merge(
    var.defined_tags,
    lookup(var.endpoint[count.index], "defined_tags")
  )
  description  = lookup(var.endpoint[count.index], "description")
  display_name = lookup(var.endpoint[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.endpoint[count.index], "freeform_tags")
  )
  inference_units = lookup(var.endpoint[count.index], "inference_units")
}

resource "oci_ai_language_model" "this" {
  count          = length(var.model) == "0" ? "0" : length(var.project)
  compartment_id = data.oci_identity_compartment.this.id
  project_id = try(
    data.oci_ai_language_project.this.id,
    element(oci_ai_language_project.this.*.id, lookup(var.model[count.index], "project_id"))
  )
  defined_tags = merge(
    var.defined_tags,
    lookup(var.model[count.index], "defined_tags")
  )
  display_name = lookup(var.model[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.model[count.index], "freeform_tags")
  )
  id = lookup(var.model[count.index], "id")

  dynamic "model_details" {
    for_each = lookup(var.model[count.index], "model_details")
    content {
      model_type    = lookup(model_details.value, "model_type")
      language_code = lookup(model_details.value, "language_code")
      version       = lookup(model_details.value, "version")

      dynamic "classification_mode" {
        for_each = lookup(model_details.value, "model_type") == "TEXT_CLASSIFICATION" ? lookup(model_details.value, "classification_mode") : []
        content {
          classification_mode = lookup(classification_mode.value, "classification_mode")
          version             = lookup(classification_mode.value, "version")
        }
      }
    }
  }

  dynamic "test_strategy" {
    for_each = lookup(var.model[count.index], "test_strategy") == null ? [] : ["test_strategy"]
    content {
      strategy_type = lookup(test_strategy.value, "strategy_type")

      dynamic "testing_dataset" {
        for_each = lookup(test_strategy.value, "testing_dataset")
        content {
          dataset_type = lookup(testing_dataset.value, "dataset_type")
          dataset_id   = lookup(testing_dataset.value, "dataset_type") == "DATA_SCIENCE_LABELING" ? lookup(testing_dataset.value, "dataset_id") : null

          dynamic "location_details" {
            for_each = lookup(testing_dataset.value, "dataset_type") == "OBJECT_STORAGE" ? lookup(testing_dataset.value, "location_details") : []
            content {
              bucket        = lookup(location_details.value, "bucket")
              location_type = lookup(location_details.value, "location_type")
              namespace     = lookup(location_details.value, "namespace")
              object_names  = lookup(location_details.value, "object_names")
            }
          }
        }
      }

      dynamic "validation_dataset" {
        for_each = lookup(test_strategy.value, "validation_dataset") == null ? [] : ["validation_dataset"]
        content {
          dataset_type = lookup(validation_dataset.value, "dataset_type")
          dataset_id   = lookup(validation_dataset.value, "dataset_type") == "DATA_SCIENCE_LABELING" ? lookup(validation_dataset.value, "dataset_id") : null

          dynamic "location_details" {
            for_each = lookup(validation_dataset.value, "dataset_type") == "OBJECT_STORAGE" ? lookup(validation_dataset.value, "location_details") : []
            content {
              bucket        = lookup(location_details.value, "bucket")
              location_type = lookup(location_details.value, "location_type")
              namespace     = lookup(location_details.value, "namespace")
              object_names  = lookup(location_details.value, "object_names")
            }
          }
        }
      }
    }
  }

  dynamic "training_dataset" {
    for_each = lookup(var.model[count.index], "training_dataset") == null ? [] : ["training_dataset"]
    content {
      dataset_type = lookup(training_dataset.value, "dataset_type")
      dataset_id   = lookup(training_dataset.value, "dataset_type") == "DATA_SCIENCE_LABELING" ? lookup(training_dataset.value, "dataset_id") : null

      dynamic "location_details" {
        for_each = lookup(training_dataset.value, "dataset_type") == "OBJECT_STORAGE" ? lookup(training_dataset.value, "location_details") : []
        content {
          bucket        = lookup(location_details.value, "bucket")
          location_type = lookup(location_details.value, "location_type")
          namespace     = lookup(location_details.value, "namespace")
          object_names  = lookup(location_details.value, "object_names")
        }
      }
    }
  }
}

resource "oci_ai_language_project" "this" {
  count          = length(var.project)
  compartment_id = data.oci_identity_compartment.this.id
  defined_tags = merge(
    var.defined_tags,
    lookup(var.project[count.index], "defined_tags")
  )
  description  = lookup(var.project[count.index], "description")
  display_name = lookup(var.project[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.project[count.index], "freeform_tags")
  )
}