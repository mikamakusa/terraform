output "service_id" {
  value = netbox_service.service.*.id
}