data "oci_core_subnet" "this" {
  subnet_id = var.subnet_id
}

data "oci_functions_function" "this" {
  count       = var.function_id ? 1 : 0
  function_id = var.function_id
}

data "oci_identity_compartment" "this" {
  id = var.compartment_id
}