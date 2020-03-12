resource "aws_appmesh_mesh" "mesh" {
  count = length(var.mesh)
  name  = lookup(var.mesh[count.index], "name")

  dynamic "spec" {
    for_each = lookup(var.mesh[count.index], "spec") == "" ? null : [for i in lookup(var.mesh[count.index], "spec") : {
      egress = lookup(i, "egress_filter")
    }]
    content {
      dynamic "egress_filter" {
        for_each = spec.value.egress == "" ? null : [for i in spec.value.egress : {
          type = i.type
        }]
        content {
          type = egress_filter.value.type
        }
      }
    }
  }

  tags = var.tags
}