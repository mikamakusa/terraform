resource "aws_appsync_graphql_api" "graphql_api" {
  count               = length(var.graphql_api)
  authentication_type = lookup(var.graphql_api[count.index], "authentication_type")
  name                = lookup(var.graphql_api[count.index], "name")
  schema              = lookup(var.graphql_api[count.index], "schema")

  dynamic "additional_authentication_provider" {
    for_each = lookup(var.graphql_api[count.index], "additional_authentication_provider") == "" ? null : [for i in lookup(var.graphql_api[count.index], "additional_authentication_provider") : {
      authentication_type   = i.authentication_type
      openid_connect_config = lookup(i, "openid_connect_config", null)
      user_pool_config      = lookup(i, "user_pool_config", null)
    }]
    content {
      authentication_type = additional_authentication_provider.value.authentication_type

      dynamic "openid_connect_config" {
        for_each = additional_authentication_provider.value.openid_connect_config == "" ? null : [for i in additional_authentication_provider.value.openid_connect_config : {
          issuer   = i.issuer
          auth_ttl = i.auth_ttl
          iat_ttl  = i.iat_ttl
        }]
        content {
          issuer    = openid_connect_config.value.issuer
          auth_ttl  = openid_connect_config.value.auth_ttl
          iat_ttl   = openid_connect_config.value.iat_ttl
          client_id = var.client_id
        }
      }

      dynamic "user_pool_config" {
        for_each = additional_authentication_provider.value.user_pool_config == "" ? null : [for i in additional_authentication_provider.value.user_pool_config : {
          app_id_client_regex = i.app_id_client_regex
          aws_region          = i.aws_region
        }]
        content {
          user_pool_id        = var.user_pool_id
          app_id_client_regex = user_pool_config.value.app_id_client_regex
          aws_region          = user_pool_config.value.aws_region
        }
      }
    }
  }

  dynamic "log_config" {
    for_each = lookup(var.graphql_api[count.index], "log_config") == "" ? null : lookup(var.graphql_api[count.index], "log_config")
    content {
      cloudwatch_logs_role_arn = var.cloudwatch_logs_role_arn
      field_log_level          = lookup(log_config.value, "field_log_level")
    }
  }

  dynamic "openid_connect_config" {
    for_each = lookup(var.graphql_api[count.index], "openid_connect_config") == "" ? null : lookup(var.graphql_api[count.index], "openid_connect_config")
    content {
      issuer    = lookup(openid_connect_config.value, "issuer")
      auth_ttl  = lookup(openid_connect_config.value, "auth_ttl", null)
      iat_ttl   = lookup(openid_connect_config.value, "iat_ttl", null)
      client_id = var.client_id
    }
  }

  dynamic "user_pool_config" {
    for_each = lookup(var.graphql_api[count.index], "user_pool_config") == "" ? null : lookup(var.graphql_api[count.index], "user_pool_config")
    content {
      default_action = lookup(user_pool_config.value, "default_action")
      user_pool_id   = var.user_pool_id
      aws_region     = lookup(user_pool_config.value, "aws_region")
    }
  }

  tags = var.tags
}