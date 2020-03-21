resource "azurerm_api_management_authorization_server" "authorization_server" {
  count                        = length(var.authorization_server)
  api_management_name          = element(var.api_management_name, lookup(var.authorization_server[count.index], "api_management_id"))
  authorization_endpoint       = lookup(var.authorization_server, "authorization_endpoint")
  authorization_methods        = lookup(var.authorization_server, "authorization_methods")
  client_id                    = lookup(var.authorization_server, "client_id")
  client_registration_endpoint = lookup(var.authorization_server, "client_registration_endpoint")
  display_name                 = lookup(var.authorization_server, "display_name")
  grant_types                  = lookup(var.authorization_server, "grant_types")
  name                         = lookup(var.authorization_server, "name")
  resource_group_name          = var.resource_group_name
  bearer_token_sending_methods = lookup(var.authorization_server, "bearer_token_sending_methods", null)
  client_authentication_method = lookup(var.authorization_server, "client_authentication_method", null)
  client_secret                = lookup(var.authorization_server, "client_secret", null)
  default_scope                = lookup(var.authorization_server, "default_scope", null)
  description                  = lookup(var.authorization_server, "description", null)
  resource_owner_username      = lookup(var.authorization_server, "resource_owner_username", null)
  resource_owner_password      = lookup(var.authorization_server, "resource_owner_password", null)
  support_state                = lookup(var.authorization_server, "support_state", null)
  token_endpoint               = lookup(var.authorization_server, "token_endpoint", null)

  dynamic "token_body_parameter" {
    for_each = lookup(var.authorization_server[count.index], "token_body_parameter")
    content {
      name  = lookup(token_body_parameter.value, "name")
      value = lookup(token_body_parameter.value, "value")
    }
  }
}