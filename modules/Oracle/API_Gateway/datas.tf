data "oci_apigateway_gateway" "this" {
  count      = var.gateway_id ? 1 : 0
  gateway_id = var.gateway_id
}

data "oci_apigateway_deployment" "this" {
  count         = var.deployment_id ? 1 : 0
  deployment_id = var.deployment_id
}

data "oci_apigateway_certificate" "this" {
  count          = var.certificate_id ? 1 : 0
  certificate_id = var.certificate_id
}

data "oci_identity_compartment" "this" {
  id = var.compartment_id
}

data "oci_core_subnet" "this" {
  subnet_id = var.subnet_id
}