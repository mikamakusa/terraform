resource "azurerm_virtual_network" "virtual_network" {
  count               = length(var.virtual_network)
  address_space       = lookup(var.virtual_network[count.index], "address_space")
  location            = var.location
  name                = lookup(var.virtual_network[count.index], "name")
  resource_group_name = var.resource_group_name
  dns_servers         = lookup(var.virtual_network[count.index], "dns_servers")

  dynamic "ddos_protection_plan" {
    for_each = lookup(var.virtual_network[count.index], "ddos_protection_plan")
    content {
      enable = lookup(ddos_protection_plan.value, "enable", false)
      id     = element(var.ddos_protection_plan, lookup(ddos_protection_plan.value, "ddos_protection_plan_id"))
    }
  }

  dynamic "subnet" {
    for_each = lookup(var.virtual_network[count.index], "subnet")
    content {
      address_prefix = lookup(subnet.value, "address_prefix")
      name           = lookup(subnet.value, "name")
      security_group = lookup(subnet.value, "security_group_id") == "" ? var.security_group : element(var.security_group, lookup(subnet.value, "security_group_id"))
    }
  }

  tags = var.tags
}