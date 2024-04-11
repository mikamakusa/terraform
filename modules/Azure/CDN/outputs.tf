output "endpoint" {
  value = try(
    azurerm_cdn_endpoint.this,
    azurerm_cdn_frontdoor_endpoint.this,
  )
}

output "frontdoor" {
  value = try(
    azurerm_cdn_frontdoor_endpoint.this,
    azurerm_cdn_frontdoor_firewall_policy.this,
    azurerm_cdn_frontdoor_route.this,
    azurerm_cdn_frontdoor_origin.this,
    azurerm_cdn_frontdoor_origin_group.this,
    azurerm_cdn_frontdoor_security_policy.this,
    azurerm_cdn_frontdoor_secret.this,
    azurerm_cdn_frontdoor_route_disable_link_to_default_domain.this,
    azurerm_cdn_frontdoor_custom_domain_association.this
  )
}

output "profile" {
  value = try(
    azurerm_cdn_frontdoor_profile.this,
    azurerm_cdn_profile.this
  )
}

output "frontdoor_rules" {
  value = try(
    azurerm_cdn_frontdoor_rule_set.this,
    azurerm_cdn_frontdoor_rule.this
  )
}