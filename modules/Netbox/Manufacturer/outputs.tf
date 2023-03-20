output "manufacturer_id" {
  value = netbox_manufacturer.manufacturer.*.id
}