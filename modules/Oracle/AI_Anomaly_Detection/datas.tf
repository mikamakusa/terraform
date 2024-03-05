data "oci_identity_compartment" "this" {
  id = var.compartment_id
}

data "oci_core_subnet" "this" {
  subnet_id = var.subnet_id
}