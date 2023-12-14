data "cloudfoundry_domain" "this" {
  count = var.cloudfoundry_domain_name ? 1 : 0
  name  = var.cloudfoundry_domain_name
}

data "cloudfoundry_service" "this" {
  count = var.cloudfoundry_service ? 1 : 0
  name  = var.cloudfoundry_service
}