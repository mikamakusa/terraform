resource "aws_appmesh_route" "route" {
  count               = length(var.route)
  mesh_name           = element(var.mesh_name, lookup(var.route[count.index], "mesh_id"))
  name                = lookup(var.route[count.index], "name")
  virtual_router_name = element(var.virtual_router_name, lookup(var.route[count.index], "virtual_router_id"))

  dynamic "spec" {
    for_each = lookup(var.route[count.index], "route") == "" ? null : [for i in lookup(var.route[count.index], "spec") : {
      http     = lookup(i, "http_route", null)
      tcp      = lookup(i, "tcp", null)
      priority = i.priority
    }]
    content {
      dynamic "http_route" {
        for_each = spec.value.http == "" ? null : [for i in spec.value.http : {
          action = lookup(i, "action")
          match  = lookup(i, "match")
        }]
        content {
          dynamic "action" {
            for_each = http_route.value.action == "" ? null : [for i in http_route.value.action : {
              weighted_target = lookup(i, "weighted_target")
            }]
            content {
              dynamic "weighted_target" {
                for_each = [for i in action.value.weighted_target : {
                  virtual_node_id = i.virtual_node_id
                  weigth          = i.weigth
                }]
                content {
                  virtual_node = element(var.virtual_node, weighted_target.value.virtual_node_id)
                  weight       = weighted_target.value.weigth
                }
              }
            }
          }
          dynamic "match" {
            for_each = [for i in http_route.value.match : {
              prefix = i.prefix
              header = i.header
              method = i.method
              scheme = i.scheme
            }]
            content {
              prefix = match.value.prefix
              header = match.value.header
              method = match.value.method
              scheme = match.value.scheme
            }
          }
        }
      }
      dynamic "tcp_route" {
        for_each = [for i in spec.value.tcp : {
          action = lookup(i, "action")
        }]
        content {
          dynamic "action" {
            for_each = [for i in tcp_route.value.action : {
              weighted_target = lookup(i, "weighted_target")
            }]
            content {
              dynamic "weighted_target" {
                for_each = [for i in action.value.weighted_target : {
                  virtual_node_id = i.virtual_node_id
                  weight          = i.weight
                }]
                content {
                  virtual_node = element(var.virtual_node, lookup(var.route[count.index], "virtual_node_id"))
                  weight       = weighted_target.value.weight
                }
              }
            }
          }
        }
      }
      priority = spec.value.priority
    }
  }
}