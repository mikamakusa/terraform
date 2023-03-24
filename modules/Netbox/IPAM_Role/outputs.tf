output "ipam_role_id" {
  value = netbox_ipam_role.ipam_role.*.id
}