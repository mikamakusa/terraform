resource "aws_ecr_repository" "repository" {
  count                = length(var.repository)
  name                 = lookup(var.repository[count.index], "name")
  image_tag_mutability = lookup(var.repository[count.index], "image_tag_mutability", "MUTABLE")

  dynamic "image_scanning_configuration" {
    for_each = lookup(var.repository[count.index], "image_scanning_configuration")
    content {
      scan_on_push = lookup(image_scanning_configuration.value, "scan_on_push", true)
    }
  }

  tags = var.tags
}