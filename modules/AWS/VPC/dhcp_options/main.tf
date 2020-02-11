resource "aws_vpc_dhcp_options" "dhcp_options" {
  count                = length(var.dhcp_options)
  domain_name          = lookup(var.dhcp_options[count.index], "domain_name")
  domain_name_servers  = lookup(var.dhcp_options[count.index], "domain_name_servers")
  ntp_servers          = lookup(var.dhcp_options[count.index], "ntp_servers")
  netbios_name_servers = lookup(var.dhcp_options[count.index], "netbios_name_servers")
  netbios_node_type    = lookup(var.dhcp_options[count.index], "netbios_node_type")
}