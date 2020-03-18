resource "aws_codepipeline" "pipeline" {
  count    = length(var.pipeline)
  name     = lookup(var.pipeline[count.index], "name")
  role_arn = element(var.role_arn, lookup(var.pipeline[count.index], "role_id"))

  dynamic "artifact_store" {
    for_each = [for artifact in lookup(var.pipeline[count.index], "artifact_store") : {
      location       = artifact.location
      type           = artifact.type
      encryption_key = lookup(artifact, "encryption_key", null)
    }]
    content {
      location = artifact_store.value.location
      type     = artifact_store.value.type

      dynamic "encryption_key" {
        for_each = artifact_store.value.encryption_key == null ? [] : [for key in artifact_store.value.encryption_key : {
          id   = key.id
          type = key.type
        }]
        content {
          id   = encryption_key.value.id
          type = encryption_key.value.type
        }
      }
    }
  }

  dynamic "stage" {
    for_each = [for stage in lookup(var.pipeline[count.index], "stage") : {
      name          = stage.name
      action        = lookup(stage, "action")
      configuration = lookup(stage, "configuration", null)
    }]
    content {
      name = stage.value.name
      dynamic "action" {
        for_each = [for actions in stage.value.action : {
          category      = actions.category
          name          = actions.name
          owner         = actions.owner
          provider      = actions.provider
          version       = actions.version
          input         = actions.input_artifacts
          output        = actions.output_artifacts
          role_id       = actions.role_id
          run_order     = actions.run_order
          configuration = lookup(actions, "configuration", null)
        }]
        content {
          category         = action.value.category
          name             = action.value.name
          owner            = action.value.owner
          provider         = action.value.provider
          version          = action.value.version
          input_artifacts  = action.value.input
          output_artifacts = action.value.output
          role_arn         = element(var.role_arn, action.value.role_id)
          run_order        = action.value.run_order

          configuration {
            variables = action.value.configuration
          }
        }
      }
    }
  }

  tags = var.tags
}