resource "aws_appmesh_virtual_node" "virtual_node" {
  count     = length(var.virtual_node)
  mesh_name = lookup(var.virtual_node[count.index], "mesh_name")
  name      = lookup(var.virtual_node[count.index], "name")

  dynamic "spec" {
    for_each = [for i in lookup(var.virtual_node[count.index], "spec") : {
      backend   = lookup(i, "backend", null)
      listener  = lookup(i, "listener", null)
      logging   = lookup(i, "logging", null)
      discovery = lookup(i, "discovery", null)
    }]
    content {
      dynamic "backend" {
        for_each = spec.value.backend == "" ? null : [for i in spec.value.backend : {
          virtual_service = lookup(i, "virtual_service")
        }]
        content {
          dynamic "virtual_service" {
            for_each = [for i in backend.value.virtual_service : {
              name = i.virtual_service_name
            }]
            content {
              virtual_service_name = virtual_service.value.name
            }
          }
        }
      }
      dynamic "listener" {
        for_each = spec.value.listener == "" ? null : [for i in spec.value.listener : {
          port_mapping = lookup(i, "port_mapping")
          health_check = lookup(i, "health_check", null)
        }]
        content {
          dynamic "port_mapping" {
            for_each = [for i in listener.value.port_mapping : {
              port     = i.port
              protocol = i.protocol
            }]
            content {
              port     = port_mapping.value.port
              protocol = port_mapping.value.protocol
            }
          }
          dynamic "health_check" {
            for_each = listener.value.health_check == "" ? null : [for i in listener.value.health_check : {
              healthy_threshold   = i.healthy
              interval_millis     = i.interval
              protocol            = i.protocol
              timeout_millis      = i.timeout
              unhealthy_threshold = i.unhealthy
              path                = i.path
              port                = i.port
            }]
            content {
              healthy_threshold   = health_check.value.healthy
              interval_millis     = health_check.value.interval
              protocol            = health_check.value.protocol
              timeout_millis      = health_check.value.timeout
              unhealthy_threshold = health_check.value.unhealthy
              path                = health_check.value.path
              port                = health_check.value.port
            }
          }
        }
      }
      dynamic "logging" {
        for_each = spec.value.logging == "" ? null : [for i in spec.value.logging : {
          access_log = lookup(i, "access_log", null)
        }]
        content {
          dynamic "access_log" {
            for_each = logging.value.access_log == "" ? null : [for i in logging.value.access_log : {
              file = lookup(i, "file", null)
            }]
            content {
              dynamic "file" {
                for_each = access_log.value.file == "" ? null : [for i in access_log.value.file : {
                  path = i.path
                }]
                content {
                  path = file.value.path
                }
              }
            }
          }
        }
      }
      dynamic "service_discovery" {
        for_each = spec.value.discovery == "" ? null : [for i in spec.value.discovery : {
          aws_cloud_map = lookup(i, "aws_cloud_map", null)
          dns           = lookup(i, "dns", null)
        }]
        content {
          dynamic "aws_cloud_map" {
            for_each = service_discovery.value.aws_cloud_map == "" ? null : [for i in service_discovery.value.aws_cloud_map : {
              namespace = i.namespace
              service   = i.service
            }]
            content {
              namespace_name = aws_cloud_map.value.namespace
              service_name   = aws_cloud_map.value.service
            }
          }
          dynamic "dns" {
            for_each = service_discovery.value.dns == "" ? null : [for i in service_discovery.value.dns : {
              hostname = i.hostname
            }]
            content {
              hostname = dns.value.hostname
            }
          }
        }
      }
    }
  }
}