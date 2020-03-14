resource "azurerm_api_management_api_operation" "operation" {
  count               = length(var.operation)
  api_management_name = element(var.api_management_name, lookup(var.operation[count.index], "api_management_id"))
  api_name            = element(var.api_name, lookup(var.operation[count.index], "api_id"))
  display_name        = lookup(var.operation[count.index], "display_name")
  method              = lookup(var.operation[count.index], "method")
  operation_id        = lookup(var.operation[count.index], "operation_id")
  resource_group_name = var.resource_group_name
  url_template        = lookup(var.operation[count.index], "url_template")
  description         = lookup(var.operation[count.index], "description", null)

  dynamic "request" {
    for_each = lookup(var.operation[count.index], "request") == null ? [] : [for i in lookup(var.operation[count.index], "request") : {
      description    = i.description
      representation = lookup(i, "representation")
      header         = lookup(i, "header")
      query          = lookup(i, "query_parameter")
    }]
    content {
      description = request.value.description
      dynamic "representation" {
        for_each = request.value.representation == null ? [] : [for i in request.value.representation : {
          content = i.content
          sample  = i.sample
          schema  = i.schema
          type    = i.type
          form    = lookup(i, "form_parameter", null)
        }]
        content {
          content_type = representation.value.content
          sample       = representation.value.sample
          schema_id    = representation.value.schema
          type_name    = representation.value.type
          dynamic "form_parameter" {
            for_each = representation.value.form == null ? [] : [for i in representation.value.form : {
              name     = i.name
              required = i.required
              type     = i.type
            }]
            content {
              name     = form_parameter.value.name
              required = form_parameter.value.required
              type     = form_parameter.value.type
            }
          }
        }
      }
      dynamic "header" {
        for_each = request.value.header == null ? [] : [for i in request.value.header : {
          name     = i.name
          required = i.required
          type     = i.type
        }]
        content {
          name     = header.value.name
          required = header.value.required
          type     = header.value.type
        }
      }
      dynamic "query_parameter" {
        for_each = request.value.query == null ? [] : [for i in request.value.query : {
          name     = i.name
          required = i.required
          type     = i.type
        }]
        content {
          name     = query_parameter.value.name
          required = query_parameter.value.required
          type     = query_parameter.value.type
        }
      }
    }
  }

  dynamic "response" {
    for_each = lookup(var.operation[count.index], "response") == null ? [] : [for i in lookup(var.operation[count.index], "response") : {
      status         = i.status_code
      description    = i.description
      representation = lookup(i, "representation")
      header         = lookup(i, "header")
    }]
    content {
      status_code = response.value.status
      description = response.value.description
      dynamic "representation" {
        for_each = response.value.representation == null ? [] : [for i in response.value.representation : {
          content = i.content
          sample  = i.sample
          schema  = i.schema
          type    = i.type
          form    = lookup(i, "form_parameter", null)
        }]
        content {
          content_type = representation.value.content
          sample       = representation.value.sample
          schema_id    = representation.value.schema
          type_name    = representation.value.type
          dynamic "form_parameter" {
            for_each = representation.value.form == null ? [] : [for i in representation.value.form : {
              name     = i.name
              required = i.required
              type     = i.type
            }]
            content {
              name     = form_parameter.value.name
              required = form_parameter.value.required
              type     = form_parameter.value.type
            }
          }
        }
      }
      dynamic "header" {
        for_each = response.value.header == null ? [] : [for i in response.value.header : {
          name     = i.name
          required = i.required
          type     = i.type
        }]
        content {
          name     = header.value.name
          required = header.value.required
          type     = header.value.type
        }
      }
    }
  }

  dynamic "template_parameter" {
    for_each = lookup(var.operation[count.index], "template_parameter")
    content {
      name          = lookup(template_parameter.value, "name")
      required      = lookup(template_parameter.value, "required")
      type          = lookup(template_parameter.value, "type")
      description   = lookup(template_parameter.value, "description")
      default_value = lookup(template_parameter.value, "default_value")
      values        = lookup(template_parameter.value, "values")
    }
  }
}