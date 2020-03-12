resource "aws_appmesh_virtual_router" "virtual_router" {
  count     = length(var.virtual_router)
  mesh_name = element(var.mesh_name, lookup(var.virtual_router[count.index], "mesh_id"))
  name      = lookup(var.virtual_router[count.index], "name")

  dynamic "spec" {
    for_each = [for i in lookup(var.virtual_router[count.index], "spec") : {
      listener = lookup(i, "listener")
    }]
    content {
      dynamic "listener" {
        for_each = [for i in spec.value.listener : {
          port_mapping = lookup(i, "port_mapping")
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
        }
      }
    }
  }
}