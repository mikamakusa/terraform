resource "cloudstack_vpn_gateway" "vpn_gateway" {
  count  = length(var.vpn_gateway)
  vpc_id = element(var.vpc_id, lookup(var.vpn_gateway[count.index], "vpc_id"))
}

resource "cloudstack_vpn_customer_gateway" "vpn_customer_gateway" {
  count        = length(var.vpn_gateway) == "0" ? "0" : length(var.vpn_customer_gateway)
  cidr         = lookup(var.vpn_customer_gateway[count.index], "cidr")
  esp_policy   = lookup(var.vpn_customer_gateway[count.index], "esp_policy")
  gateway      = lookup(var.vpn_customer_gateway[count.index], "gateway")
  ike_policy   = lookup(var.vpn_customer_gateway[count.index], "ike_policy")
  ipsec_psk    = lookup(var.vpn_customer_gateway[count.index], "ipsec_psk")
  name         = lookup(var.vpn_customer_gateway[count.index], "name")
  dpd          = lookup(var.vpn_customer_gateway[count.index], "dpd", false)
  esp_lifetime = lookup(var.vpn_customer_gateway[count.index], "esp_lifetime", null)
  project      = lookup(var.vpn_customer_gateway[count.index], "project", null)
}

resource "cloudstack_vpn_connection" "vpn_connection" {
  count               = length(var.vpn_gateway) == "0" ? "0" : length(var.vpn_connection)
  customer_gateway_id = element(cloudstack_vpn_customer_gateway.vpn_customer_gateway.*.id, lookup(var.vpn_connection[count.index], "customer_gateway_id"))
  vpn_gateway_id      = element(cloudstack_vpn_gateway.vpn_gateway.*.id, lookup(var.vpn_connection[count.index], "vpn_gateway_id"))
}

