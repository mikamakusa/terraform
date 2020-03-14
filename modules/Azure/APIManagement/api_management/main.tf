resource "azurerm_api_management" "api_management" {
  count               = length(var.api_management)
  location            = var.location
  name                = lookup(var.api_management[count.index], "name")
  publisher_email     = lookup(var.api_management[count.index], "publisher_email")
  publisher_name      = lookup(var.api_management[count.index], "publisher_name")
  resource_group_name = var.resource_group_name
  sku_name            = lookup(var.api_management[count.index], "sku_name")

  dynamic "additional_location" {
    for_each = lookup(var.api_management[count.index], "additional_location") == null ? [] : lookup(var.api_management[count.index], "additional_location")
    content {
      location = lookup(additional_location.value, "location")
    }
  }

  dynamic "certificate" {
    for_each = lookup(var.api_management[count.index], "certificate") == null ? [] : lookup(var.api_management[count.index], "certificate")
    content {
      certificate_password = lookup(certificate.value, "certificate_password")
      encoded_certificate  = lookup(certificate.value, "encoded_certificate")
      store_name           = lookup(certificate.value, "store_name")
    }
  }

  dynamic "identity" {
    for_each = lookup(var.api_management[count.index], "identity") == null ? [] : lookup(var.api_management[count.index], "identity")
    content {
      type = lookup(identity.value, "type")
    }
  }

  dynamic "hostname_configuration" {
    for_each = lookup(var.api_management[count.index], "hostname_configuration") == null ? [] : [for i in lookup(var.api_management[count.index], "hostname_configuration") : {
      management = lookup(i, "management", null)
      scm        = lookup(i, "scm", null)
      portal     = lookup(i, "portal", null)
      proxy      = lookup(i, "proxy", null)
    }]
    content {
      dynamic "management" {
        for_each = hostname_configuration.value.management == null ? [] : [for i in hostname_configuration.value.management : {
          name                         = i.hostname
          key_vault_id                 = i.key_vault_id
          certificate                  = i.certificate
          certificate_password         = i.certificate_password
          negotiate_client_certificate = i.negotiate_client_certificate
        }]
        content {
          host_name                    = management.value.hostname
          key_vault_id                 = element(var.key_vault_id, management.value.key_vault_id)
          certificate                  = base64encode(management.value.certificate)
          certificate_password         = management.value.certificate_password
          negotiate_client_certificate = management.value.negotiate_client_certificate
        }
      }
      dynamic "scm" {
        for_each = hostname_configuration.value.scm == null ? [] : [for i in hostname_configuration.value.scm : {
          name                         = i.hostname
          key_vault_id                 = i.key_vault_id
          certificate                  = i.certificate
          certificate_password         = i.certificate_password
          negotiate_client_certificate = i.negotiate_client_certificate
        }]
        content {
          host_name                    = scm.value.name
          key_vault_id                 = element(var.key_vault_id, scm.value.key_vault_id)
          certificate                  = base64encode(scm.value.certificate)
          certificate_password         = scm.value.certificate_password
          negotiate_client_certificate = scm.value.negotiate_client_certificate
        }
      }
      dynamic "portal" {
        for_each = hostname_configuration.value.portal == null ? [] : [for i in hostname_configuration.value.portal : {
          name                         = i.hostname
          key_vault_id                 = i.key_vault_id
          certificate                  = i.certificate
          certificate_password         = i.certificate_password
          negotiate_client_certificate = i.negotiate_client_certificate
        }]
        content {
          host_name                    = portal.value.name
          key_vault_id                 = element(var.key_vault_id, portal.value.key_vault_id)
          certificate                  = base64encode(portal.value.certificate)
          certificate_password         = portal.value.certificate_password
          negotiate_client_certificate = portal.value.negotiate_client_certificate
        }
      }
      dynamic "proxy" {
        for_each = hostname_configuration.value.proxy == null ? [] : [for i in hostname_configuration.value.proxy : {
          name                         = i.hostname
          key_vault_id                 = i.key_vault_id
          certificate                  = i.certificate
          certificate_password         = i.certificate_password
          negotiate_client_certificate = i.negotiate_client_certificate
        }]
        content {
          host_name                    = proxy.value.name
          key_vault_id                 = element(var.key_vault_id, proxy.value.key_vault_id)
          certificate                  = base64encode(proxy.value.certificate)
          certificate_password         = proxy.value.certificate_password
          negotiate_client_certificate = proxy.value.negotiate_client_certificate
        }
      }
    }
  }

  dynamic "policy" {
    for_each = lookup(var.api_management[count.index], "policy")
    content {
      xml_content = lookup(policy.value, "xml_content")
      xml_link    = lookup(policy.value, "xml_link")
    }
  }

  dynamic "protocols" {
    for_each = lookup(var.api_management[count.index], "protocols")
    content {
      enable_http2 = lookup(protocols.value, "enable_http2")
    }
  }

  dynamic "sign_in" {
    for_each = lookup(var.api_management[count.index], "sign_in")
    content {
      enabled = lookup(sign_in.value, "enabled", false)
    }
  }

  dynamic "sign_up" {
    for_each = lookup(var.api_management[count.index], "sign_up") == null ? [] : [for i in lookup(var.api_management[count.index], "sign_up") : {
      enabled = i.enabled
      terms   = lookup(i, "terms_of_service")
    }]
    content {
      enabled = sign_up.value.enabled
      dynamic "terms_of_service" {
        for_each = sign_up.value.terms == null ? [] : [for i in sign_up.value.terms : {
          consent = i.consent
          enabled = i.enabled
        }]
        content {
          consent_required = terms_of_service.value.consent
          enabled          = terms_of_service.value.enabled
        }
      }
    }
  }

  dynamic "security" {
    for_each = lookup(var.api_management[count.index], "security")
    content {
      disable_backend_ssl30      = lookup(security.value, "disable_backend_ssl30")
      disable_backend_tls10      = lookup(security.value, "disable_backend_tls10")
      disable_backend_tls11      = lookup(security.value, "disable_backend_tls11")
      disable_frontend_ssl30     = lookup(security.value, "disable_frontend_ssl30")
      disable_frontend_tls10     = lookup(security.value, "disable_frontend_tls10")
      disable_frontend_tls11     = lookup(security.value, "disable_frontend_tls11")
      disable_triple_des_ciphers = lookup(security.value, "disable_triple_des_ciphers")
    }
  }

  tags = var.tags
}