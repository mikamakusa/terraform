resource "azurerm_resource_group" "this" {
  count    = length(var.resource_group)
  location = lookup(var.resource_group[count.index], "location")
  name     = lookup(var.resource_group[count.index], "name")
}

resource "azurerm_virtual_network" "this" {
  count               = length(var.virtual_network)
  address_space       = lookup(var.virtual_network[count.index], "address_space")
  location            = element(azurerm_resource_group.this.*.location, lookup(var.virtual_network[count.index], "resource_group_id"))
  name                = lookup(var.virtual_network[count.index], "name")
  resource_group_name = element(azurerm_resource_group.this.*.name, lookup(var.virtual_network[count.index], "resource_group_id"))
}

resource "azurerm_subnet" "this" {
  count                = length(var.subnet)
  address_prefixes     = lookup(var.subnet[count.index], "address_prefix")
  name                 = lookup(var.subnet[count.index], "name")
  resource_group_name  = element(azurerm_resource_group.this.*.name, lookup(var.subnet[count.index], "resource_group_id"))
  virtual_network_name = element(azurerm_virtual_network.this.*.name, lookup(var.subnet[count.index], "virtual_network_id"))
}

resource "azurerm_network_security_group" "this" {
  for_each            = var.security_group
  location            = azurerm_resource_group.this[each.value.location].location
  name                = each.key
  resource_group_name = azurerm_resource_group.this[each.value.resource_group_name].name

  dynamic "security_rule" {
    for_each = each.value.security_rule
    content {
      name                       = security_rule.key
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "this" {
  count                     = length(var.security_group_association)
  network_security_group_id = azurerm_network_security_group.this[0].id
  subnet_id                 = element(azurerm_subnet.this.*.id, lookup(var.security_group_association[count.index], "subnet_id"))
}

resource "azuread_group" "this" {
  for_each         = lenght(var.ad_group)
  display_name     = lookup(var.ad_group[count.index], "display_name")
  security_enabled = true
}

resource "azuread_user" "this" {
  count               = length(var.ad_user)
  display_name        = lookup(var.ad_user[count.index], "display_name")
  user_principal_name = lookup(var.ad_user[count.index], "user_principal_name")
  password            = sensitive(lookup(var.ad_user[count.index], "password"))
}

resource "azuread_group_member" "this" {
  for_each         = length(var.group_member)
  group_object_id  = element(azuread_group.this.*.id, lookup(var.group_member[count.index], "group_object_id"))
  member_object_id = element(azuread_user.this.*.id, lookup(var.group_member[count.index], "member_object_id"))
}

resource "azuread_service_principal" "this" {
  application_id = data.azuread_application.this.id
  use_existing   = true
}

resource "azurerm_active_directory_domain_service" "this" {
  count                     = length(var.ad_domain_services)
  domain_name               = lookup(var.ad_domain_services[count.index], "domain_name")
  location                  = element(azurerm_resource_group.this.*.location, lookup(var.ad_domain_services[count.index], "resource_group_id"))
  name                      = lookup(var.ad_domain_services[count.index], "name")
  resource_group_name       = element(azurerm_resource_group.this.*.name, lookup(var.ad_domain_services[count.index], "resource_group_id"))
  sku                       = lookup(var.ad_domain_services[count.index], "sku")
  domain_configuration_type = lookup(var.ad_domain_services[count.index], "domain_configuration_type", null)
  filtered_sync_enabled     = lookup(var.ad_domain_services[count.index], "filtered_sync_enabled", false)
}