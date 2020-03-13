resource "aws_appmesh_virtual_service" "virtual_service" {
  count     = length(var.virtual_service)
  mesh_name = element(var.mesh_name, lookup(var.virtual_service[count.index], "mesh_id"))
  name      = lookup(var.virtual_service[count.index], "name")

  dynamic "spec" {
    for_each = [for i in lookup(var.virtual_service[count.index], "spec") : {
      provider = lookup(i, "provider", null)
    }]
    content {
      dynamic "provider" {
        for_each = spec.value.provider == "" ? null : [for i in spec.value.provider : {
          virtual_node  = lookup(i, "virtual_node", null)
          virual_router = lookup(i, "virtual_router", null)
        }]
        content {
          dynamic "virtual_node" {
            for_each = provider.value.virtual_node == "" ? null : [for i in provider.value.virtual_node : {
              id = i.id
            }]
            content {
              virtual_node_name = element(var.virtual_node_name, virtual_node.value.id)
            }
          }
          dynamic "virtual_router" {
            for_each = provider.value.virtual_router == "" ? null : [for i in provider.value.virtual_router : {
              id = i.id
            }]
            content {
              virtual_router_name = element(var.virtual_router_name, virtual_router.value.id)
            }
          }
        }
      }
    }
  }

  tags = var.tags
}