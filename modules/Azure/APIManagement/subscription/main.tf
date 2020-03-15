resource "azurerm_api_management_subscription" "subscription" {
  count               = length(var.subscription)
  api_management_name = element(var.api_management_name, lookup(var.subscription[count.index], "api_management_id"))
  display_name        = lookup(var.subscription[count.index], "display_name")
  product_id          = element(var.product_id, lookup(var.subscription[count.index], "product_id"))
  resource_group_name = var.resource_group_name
  user_id             = element(var.user_id, lookup(var.subscription[count.index], "user_id"))
  state               = lookup(var.subscription[count.index], "state")
  subscription_id     = var.subscription_id
}