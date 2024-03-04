output "certificate" {
  value = try(oci_apigateway_certificate.this)
}

output "deployment" {
  value = try(oci_apigateway_deployment.this)
}

output "gateway" {
  value = try(oci_apigateway_gateway.this)
}

output "usage_plan" {
  value = try(oci_apigateway_usage_plan.this)
}

output "subscriber" {
  value = try(oci_apigateway_subscriber.this)
}

output "api" {
  value = try(oci_apigateway_api.this)
}