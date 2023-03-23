output "token_id" {
  value = netbox_token.token.*.id
}