data "aci_node_mgmt_epg" "main" {
  for_each = var.configuration
  name     = join("-", [each.key, "node-mgmt-epg"])
  type     = each.value.node_mgmt_epg_type
}

data "aci_vpc_domain_policy" "main" {
  for_each = var.configuration
  name     = join("-", [each.key, "domain-policy"])
}