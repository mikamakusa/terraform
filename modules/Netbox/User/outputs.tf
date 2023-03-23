output "user_id" {
  value = netbox_user.user.*.id
}