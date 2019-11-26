output "vpc_gateway_id" {
  value = cloudstack_vpn_gateway.vpn_gateway.*.id
}

output "vpc_gateway_public_ip" {
  value = cloudstack_vpn_gateway.vpn_gateway.*.public_ip
}