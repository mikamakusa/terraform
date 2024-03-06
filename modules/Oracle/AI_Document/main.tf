resource "oci_ai_document_model" "this" {
  count          = length(var.model) == "0" ? "0" : (length(var.project) || var.project_id)
  compartment_id = data.oci_identity_compartment.this.id
  model_type     = lookup(var.model[count.index], "model_type")
  model_id       = lookup(var.model[count.index], "model_id")
  project_id = try(
    data.oci_ai_document_project.this.id,
    element(oci_ai_document_project.this.*.id, lookup(var.model[count.index], "project_id"))
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
  is_quick_mode              = lookup(var.model[count.index], "is_quick_mode")
  max_training_time_in_hours = lookup(var.model[count.index], "max_training_time_in_hours")
  model_version              = lookup(var.model[count.index], "model_version")

  dynamic "component_models" {
    for_each = lookup(var.model[count.index], "component_models") == null ? [] : ["component_models"]
    content {
      model_id = lookup(component_models.value, "model_id")
    }
  }

  dynamic "operations" {
    for_each = lookup(var.model[count.index], "operations") == null ? [] : ["operations"]
    content {
      operation = lookup(operations.value, "operation")
      path      = lookup(operations.value, "path")
      value     = lookup(operations.value, "value")
    }
  }

  dynamic "testing_dataset" {
    for_each = lookup(var.model[count.index], "testing_dataset") == null ? [] : ["testing_dataset"]
    content {
      dataset_type = lookup(testing_dataset.value, "dataset_type")
      bucket       = lookup(testing_dataset.value, "bucket")
      dataset_id   = lookup(testing_dataset.value, "dataset_id")
      object       = lookup(testing_dataset.value, "object")
      namespace    = lookup(testing_dataset.value, "namespace")
    }
  }

  dynamic "training_dataset" {
    for_each = lookup(var.model[count.index], "training_dataset") == null ? [] : ["training_dataset"]
    content {
      dataset_type = lookup(training_dataset.value, "dataset_type")
      bucket       = lookup(training_dataset.value, "bucket")
      dataset_id   = lookup(training_dataset.value, "dataset_id")
      namespace    = lookup(training_dataset.value, "namespace")
      object       = lookup(training_dataset.value, "object")
    }
  }

  dynamic "validation_dataset" {
    for_each = lookup(var.model[count.index], "validation_dataset") == null ? [] : ["validation_dataset"]
    content {
      dataset_type = lookup(validation_dataset.value, "dataset_type")
      bucket       = lookup(validation_dataset.value, "bucket")
      dataset_id   = lookup(validation_dataset.value, "dataset_id")
      namespace    = lookup(validation_dataset.value, "object")
      object       = lookup(validation_dataset.value, "namespace")
    }
  }
}

resource "oci_ai_document_processor_job" "this" {
  count          = length(var.processor_job)
  compartment_id = data.oci_identity_compartment.this.id
  display_name   = lookup(var.processor_job[count.index], "display_name")

  dynamic "input_location" {
    for_each = lookup(var.processor_job[count.index], "input_location")
    content {
      source_type = lookup(input_location.value, "source_type")
      data        = lookup(input_location.value, "source_type") == "INLINE_DOCUMENT_CONTENT" ? lookup(input_location.value, "data") : null

      dynamic "object_locations" {
        for_each = lookup(input_location.value, "source_type") == "OBJECT_STORAGE_LOCATIONS" ? lookup(input_location.value, "object_locations") : []
        content {
          bucket    = lookup(object_locations.value, "bucket")
          namespace = lookup(object_locations.value, "namespace")
          object    = lookup(object_locations.value, "object")
        }
      }
    }
  }

  dynamic "output_location" {
    for_each = lookup(var.processor_job[count.index], "output_location")
    content {
      bucket    = lookup(output_location.value, "bucket")
      namespace = lookup(output_location.value, "namespace")
      prefix    = lookup(output_location.value, "prefix")
    }
  }

  dynamic "processor_config" {
    for_each = lookup(var.processor_job[count.index], "processor_config")
    content {
      processor_type        = lookup(processor_config.value, "processor_type")
      document_type         = lookup(processor_config.value, "document_type")
      is_zip_output_enabled = lookup(processor_config.value, "is_zip_output_enabled")
      language              = lookup(processor_config.value, "language")

      dynamic "features" {
        for_each = lookup(processor_config.value, "features")
        content {
          feature_type            = lookup(features.value, "feature_type")
          generate_searchable_pdf = lookup(features.value, "feature_type") == "TEXT_EXTRACTION" ? lookup(features.value, "generate_searchable_pdf") : null
          max_results             = (lookup(features.value, "feature_type") == "DOCUMENT_CLASSIFICATION" || lookup(features.value, "feature_type") == "LANGUAGE_CLASSIFICATION") ? lookup(features.value, "max_results") : null
          model_id                = (lookup(features.value, "feature_type") == "DOCUMENT_CLASSIFICATION" || lookup(features.value, "feature_type") == "KEY_VALUE_EXTRACTION") ? lookup(features.value, "model_id") : null
          tenancy_id              = (lookup(features.value, "feature_type") == "DOCUMENT_CLASSIFICATION" || lookup(features.value, "feature_type") == "KEY_VALUE_EXTRACTION") ? lookup(features.value, "tenancy_id") : null
        }
      }
    }
  }
}

resource "oci_ai_document_project" "this" {
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

