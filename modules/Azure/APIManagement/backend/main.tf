resource "azurerm_api_management_backend" "backend" {
  count               = length(var.backend)
  api_management_name = element(var.api_management_name, lookup(var.backend[count.index], "api_management_id"))
  name                = lookup(var.backend[count.index], "name")
  protocol            = lookup(var.backend[count.index], "protocol")
  resource_group_name = var.resource_group_name
  url                 = lookup(var.backend[count.index], "url")
  description         = lookup(var.backend[count.index], "description")
  resource_id         = element(var.resource_id, lookup(var.backend[count.index], "resource_id"))
  title               = lookup(var.backend[count.index], "title")

  dynamic "credentials" {
    for_each = lookup(var.backend[count.index], "credentials") == null ? [] : [for i in lookup(var.backend[count.index], "credentials") : {
      certificate   = i.certificate
      header        = lookup(i, "header")
      query         = lookup(i, "query")
      authorization = lookup(i, "authorization")
    }]
    content {
      certificate = credentials.value.certificate
      header {
        variables = credentials.value.header
      }
      query {
        variables = credentials.value.query
      }
      dynamic "authorization" {
        for_each = credentials.value.authorization == null ? [] : [for auth in credentials.value.authorization : {
          parameter = auth.parameter
          scheme    = auth.scheme
        }]
        content {
          parameter = authorization.value.parameter
          scheme    = authorization.value.scheme
        }
      }
    }
  }

  dynamic "proxy" {
    for_each = lookup(var.backend[count.index], "proxy") == null ? [] : lookup(var.backend[count.index], "proxy")
    content {
      url      = lookup(proxy.value, "url")
      username = lookup(proxy.value, "username")
      password = lookup(proxy.value, "password")
    }
  }

  dynamic "service_fabric_cluster" {
    for_each = lookup(var.backend[count.index], "service_fabric_cluster") == null ? [] : [for service in lookup(var.backend[count.index], "service_fabric_cluster") : {
      client           = service.client_certificate_thumbprint
      endpoints        = service.management_endpoints
      partition        = service.max_partition_resolution_retries
      thumbprints      = service.server_certificate_thumbprints
      server_x509_name = lookup(service, "server_x509_name")
    }]
    content {
      client_certificate_thumbprint    = service_fabric_cluster.value.client
      management_endpoints             = element(var.management_endpoints, service_fabric_cluster.value.endpoints)
      max_partition_resolution_retries = service_fabric_cluster.value.partition
      server_certificate_thumbprints   = service_fabric_cluster.value.thumbprints
      dynamic "server_x509_name" {
        for_each = service_fabric_cluster.value.server_x509_name == null ? [] : [for server in service_fabric_cluster.value.server_x509_name : {
          issuer = server.issuer_certificate_thumbprint
          name   = server.name
        }]
        content {
          issuer_certificate_thumbprint = server_x509_name.value.issuer
          name                          = server_x509_name.value.name
        }
      }
    }
  }

  dynamic "tls" {
    for_each = lookup(var.backend[count.index], "tls") == null ? [] : lookup(var.backend[count.index], "tls")
    content {
      validate_certificate_chain = lookup(tls.value, "validate_certificate_chain")
      validate_certificate_name  = lookup(tls.value, "validate_certificate_name")
    }
  }
}