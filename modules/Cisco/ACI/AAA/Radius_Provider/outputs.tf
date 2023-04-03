output "radius_provider_id" {
  value = aci_radius_provider.radius_provider.*.id
}