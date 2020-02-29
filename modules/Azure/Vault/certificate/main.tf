resource "azurerm_key_vault_certificate" "certificate" {
  count        = length(var.certificate)
  name         = lookup(var.certificate[count.index], "name")
  key_vault_id = element(var.key_vault_id, lookup(var.certificate[count.index], "key_vault_id"))

  dynamic "certificate_policy" {
    for_each = [for i in lookup(var.certificate[count.index], "certificate_policy") : {
      issuer   = lookup(i, "issuer_parameter")
      key      = lookup(i, "key_properties")
      secret   = lookup(i, "secret_properties")
      lifetime = lookup(i, "lifetime_action")
      x509     = lookup(i, "x509_certificate_properties")
    }]
    content {
      dynamic "issuer_parameters" {
        for_each = [for i in certificate_policy.value.issuer : {
          name = i.name
        }]
        content {
          name = issuer_parameters.value.name
        }
      }
      dynamic "key_properties" {
        for_each = [for i in certificate_policy.value.key : {
          exportable = i.exportable
          size       = i.key_size
          type       = i.key_type
          reuse      = i.reuse_key
        }]
        content {
          exportable = key_properties.value.exportable
          key_size   = key_properties.value.size
          key_type   = key_properties.value.type
          reuse_key  = key_properties.value.reuse
        }
      }
      dynamic "secret_properties" {
        for_each = [for i in certificate_policy.value.secret : {
          content = i.content_type
        }]
        content {
          content_type = secret_properties.value.content
        }
      }
      dynamic "lifetime_action" {
        for_each = certificate_policy.value.lifetime == null ? [] : [for i in certificate_policy.value.lifetime : {
          action  = lookup(i, "action")
          trigger = lookup(i, "trigger")
        }]
        content {
          dynamic "action" {
            for_each = [for i in lifetime_action.value.action : {
              action = i.action_type
            }]
            content {
              action_type = action.value.action
            }
          }
          dynamic "trigger" {
            for_each = [for i in lifetime_action.value.trigger : {
              days     = i.days_before_expiry
              lifetime = i.lifetime_percentage
            }]
            content {
              days_before_expiry  = trigger.value.days
              lifetime_percentage = trigger.value.lifetime
            }
          }
        }
      }
      dynamic "x509_certificate_properties" {
        for_each = certificate_policy.value.x509 == null ? [] : [for i in certificate_policy.value.x509 : {
          key          = i.key_usage
          subject      = i.subject
          validity     = i.validity_in_months
          alternatives = lookup(i, "subject_alternative_names")
        }]
        content {
          key_usage          = [x509_certificate_properties.value.key]
          subject            = x509_certificate_properties.value.subject
          validity_in_months = x509_certificate_properties.value.validity
          dynamic "subject_alternative_names" {
            for_each = x509_certificate_properties.value.alternatives == null ? [] : [for i in x509_certificate_properties.value.alternatives : {
              dns    = i.dns_name
              emails = i.emails
              upns   = i.upns
            }]
            content {
              dns_names = [subject_alternative_names.value.dns]
              emails    = [subject_alternative_names.value.emails]
              upns      = [subject_alternative_names.value.upns]
            }
          }
        }
      }
    }
  }

  dynamic "certificate" {
    for_each = lookup(var.certificate[count.index], "certificate")
    content {
      contents = lookup(certificate.value, "contents")
      password = lookup(certificate.value, "password")
    }
  }
}