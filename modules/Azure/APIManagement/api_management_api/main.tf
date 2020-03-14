resource "azurerm_api_management_api" "api_management_api" {
  count               = length(var.api_management_api)
  api_management_name = element(var.api_management_name, lookup(var.api_management_api[count.index], "api_management_id"))
  display_name        = lookup(var.api_management_api[count.index], "display_name")
  name                = lookup(var.api_management_api[count.index], "name")
  path                = lookup(var.api_management_api[count.index], "path")
  protocols           = lookup(var.api_management_api[count.index], "protocols")
  resource_group_name = var.resource_group_name
  revision            = lookup(var.api_management_api[count.index], "revision")
  description         = lookup(var.api_management_api[count.index], "description")
  service_url         = lookup(var.api_management_api[count.index], "service_url")
  soap_pass_through   = lookup(var.api_management_api[count.index], "soap_pass_through")

  dynamic "import" {
    for_each = lookup(var.api_management_api[count.index], "import") == "" ? null : [for i in lookup(var.api_management_api[count.index], "import") : {
      format = i.content_format
      value  = i.value
      wsdl   = lookup(i, "wsdl_selector", null)
    }]
    content {
      content_format = import.value.format
      content_value  = import.value.value
      dynamic "wsdl_selector" {
        for_each = import.value.wsdl == "" ? null : [for i in import.value.wsdl : {
          endpoint = i.endpoint_name
          service  = i.service
        }]
        content {
          endpoint_name = wsdl_selector.value.endpoint
          service_name  = wsdl_selector.value.service
        }
      }
    }
  }

  dynamic "subscription_key_parameter_names" {
    for_each = lookup(var.api_management_api[count.index], "subscription_key_parameter_names") == "" ? null : lookup(var.api_management_api[count.index], "subscription_key_parameter_names")
    content {
      header = lookup(subscription_key_parameter_names.value, "header")
      query  = lookup(subscription_key_parameter_names.value, "query")
    }
  }
}