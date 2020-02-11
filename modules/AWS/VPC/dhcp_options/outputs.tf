output "dhcp_options_id" {
  value = aws_vpc_dhcp_options.dhcp_options.*.id
}