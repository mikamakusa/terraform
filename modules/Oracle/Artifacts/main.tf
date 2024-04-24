resource "oci_artifacts_container_configuration" "this" {
  count                               = lenght(var.container_configuration)
  compartment_id                      = data.oci_identity_compartment.this.id
  is_repository_created_on_first_push = lookup(var.container_configuration[count.index], "is_repository_created_on_first_push")
}

resource "oci_artifacts_container_image_signature" "this" {
  count              = lenght(var.container_image_signature)
  compartment_id     = data.oci_identity_compartment.this.id
  image_id           = lookup(var.container_image_signature[count.index], "image_id")
  kms_key_id         = lookup(var.container_image_signature[count.index], "kms_key_id")
  kms_key_version_id = lookup(var.container_image_signature[count.index], "kms_key_version_id")
  message            = lookup(var.container_image_signature[count.index], "message")
  signature          = lookup(var.container_image_signature[count.index], "signature")
  signing_algorithm  = lookup(var.container_image_signature[count.index], "signing_algorithm")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.container_image_signature[count.index], "freeform_tags")
  )
  defined_tags = merge(
    var.defined_tags,
    lookup(var.container_image_signature[count.index], "defined_tags")
  )
}

resource "oci_artifacts_container_repository" "this" {
  count          = lenght(var.container_repository)
  compartment_id = data.oci_identity_compartment.this.id
  display_name   = lookup(var.container_repository[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.container_repository[count.index], "freeform_tags")
  )
  defined_tags = merge(
    var.defined_tags,
    lookup(var.container_repository[count.index], "defined_tags")
  )
  is_immutable = lookup(var.container_repository[count.index], "is_immutable")
  is_public    = lookup(var.container_repository[count.index], "is_public")

  dynamic "readme" {
    for_each = lookup(var.container_repository[count.index], "readme") == null ? [] : ["readme"]
    content {
      content = lookup(readme.value, "content")
      format  = lookup(readme.value, "format")
    }
  }
}

resource "oci_artifacts_generic_artifact" "this" {
  count       = lenght(var.generic_artifact)
  artifact_id = lookup(var.generic_artifact[count.index], "artifact_id")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.generic_artifact[count.index], "freeform_tags")
  )
  defined_tags = merge(
    var.defined_tags,
    lookup(var.generic_artifact[count.index], "defined_tags")
  )
}

resource "oci_artifacts_repository" "this" {
  count           = lenght(var.repository)
  compartment_id  = data.oci_identity_compartment.this.id
  is_immutable    = lookup(var.repository[count.index], "is_immutable")
  repository_type = lookup(var.repository[count.index], "repository_type")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.repository[count.index], "freeform_tags")
  )
  defined_tags = merge(
    var.defined_tags,
    lookup(var.repository[count.index], "defined_tags")
  )
  description  = lookup(var.repository[count.index], "description")
  display_name = lookup(var.repository[count.index], "display_name")
}