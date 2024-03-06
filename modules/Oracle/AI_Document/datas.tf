data "oci_identity_compartment" "this" {
  id = var.compartment_id
}

data "oci_ai_document_project" "this" {
  count      = var.project_id ? 1 : 0
  project_id = var.project_id
}