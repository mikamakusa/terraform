resource "aws_alb_listener_rule" "listener_rule" {
  count        = length(var.listener_rule)
  listener_arn = element(var.listener_arn, lookup(var.listener_rule[count.index], "listener_id"))
  priority     = lookup(var.listener_rule[count.index], "priority")

  dynamic "action" {
    for_each = [for i in lookup(var.listener_rule[count.index], "action") : {
      type     = i.type
      target   = i.target_group_arn
      redirect = lookup(i, "redirect", null)
      response = lookup(i, "fixed_response", null)
      cognito  = lookup(i, "authenticate_cognito", null)
      oidc     = lookup(i, "authenticate_oidc", null)
    }]
    content {
      type             = action.value.type
      target_group_arn = element(var.target_group_arn, action.value.target)

      dynamic "redirect" {
        for_each = action.value.redirect == null ? [] : [for i in action.value.redirect : {
          host     = i.host
          path     = i.path
          port     = i.port
          protocol = i.protocol
          query    = i.query
          status   = i.status
        }]
        content {
          host        = redirect.value.host
          path        = redirect.value.path
          port        = redirect.value.port
          protocol    = redirect.value.protocol
          query       = redirect.value.query
          status_code = redirect.value.status
        }
      }

      dynamic "fixed_response" {
        for_each = action.value.response == null ? [] : [for i in action.value.response : {
          content = i.content
          message = i.message
          status  = i.status
        }]
        content {
          content_type = fixed_response.value.content
          message_body = fixed_response.value.message
          status_code  = fixed_response.value.status
        }
      }

      dynamic "authenticate_cognito" {
        for_each = action.value.cognito == null ? [] : [for i in action.value.cognito : {
          user_pool_id               = i.user_pool_id
          user_pool_client_id        = i.user_pool_client_id
          user_pool_domain_id        = i.user_pool_domain_id
          on_unauthenticated_request = i.on_unauthenticated_request
          session_timeout            = i.session_timeout
          session_cookie_name        = i.session_cookie_name
          scope                      = i.scope
        }]
        content {
          user_pool_arn              = element(var.cognito_user_pool_arn, authenticate_cognito.value.user_pool_id)
          user_pool_client_id        = element(var.congito_user_pool_client_id, authenticate_cognito.value.user_pool_client_id)
          user_pool_domain           = element(var.cognito_user_pool_domain, authenticate_cognito.value.user_pool_domain_id)
          on_unauthenticated_request = authenticate_cognito.value.on_unauthenticated_request
          session_timeout            = authenticate_cognito.value.session_timeout
          session_cookie_name        = authenticate_cognito.value.session_cookie_name
          scope                      = authenticate_cognito.value.scope
        }
      }

      dynamic "authenticate_oidc" {
        for_each = action.value.oidc == null ? [] : [for i in action.value.oidc : {
          authorization       = i.authorization
          client_id           = i.client_id
          client_secret       = i.client_secret
          issuer              = i.issuer
          token               = i.token
          user_info           = i.user_info
          on_unauthenticated  = i.on_unauthenticated
          session_timeout     = i.session_timeout
          scope               = i.scope
          session_cookie_name = i.session_cookie_name
        }]
        content {
          authorization_endpoint     = authenticate_oidc.value.authorization
          client_id                  = authenticate_oidc.value.client_id
          client_secret              = authenticate_oidc.value.client_secret
          issuer                     = authenticate_oidc.value.issuer
          token_endpoint             = authenticate_oidc.value.token
          user_info_endpoint         = authenticate_oidc.value.user_info
          on_unauthenticated_request = authenticate_oidc.value.on_unauthenticated
          session_timeout            = authenticate_oidc.value.session_timeout
          scope                      = authenticate_oidc.value.scope
          session_cookie_name        = authenticate_oidc.value.session_cookie_name
        }
      }
    }
  }

  dynamic "condition" {
    for_each = lookup(var.listener_rule[count.index], "condition")
    content {
      host_header         = lookup(condition.value, "host_header")
      http_request_method = lookup(condition.value, "http_request_method")
      path_pattern        = lookup(condition.value, "path_pattern")
      source_ip           = lookup(condition.value, "source_ip")
    }
  }
}