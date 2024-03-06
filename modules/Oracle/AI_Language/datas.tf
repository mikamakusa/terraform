data "oci_identity_compartment" "this" {
  id = var.compartment_id
}

data "oci_ai_language_project" "this" {
  count = var.project_id ? 1 : 0
  id    = var.project_id
}

data "oci_ai_language_model" "this" {
  count = var.model_id ? 1 : 0
  id    = var.model_id
}