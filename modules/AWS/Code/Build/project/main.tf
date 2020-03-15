resource "aws_codebuild_project" "project" {
  count          = length(var.project)
  name           = lookup(var.project[count.index], "name")
  service_role   = lookup(var.project[count.index], "service_role")
  badge_enabled  = lookup(var.project[count.index], "badge_enabled", false)
  build_timeout  = lookup(var.project[count.index], "build_timeout", null)
  description    = lookup(var.project[count.index], "description", null)
  encryption_key = var.kms_key_id

  dynamic "artifacts" {
    for_each = lookup(var.project[count.index], "artifacts")
    content {
      type                   = lookup(artifacts.value, "type")
      artifact_identifier    = lookup(artifacts.value, "artifact_identifier", null)
      encryption_disabled    = lookup(artifacts.value, "encryption_disabled", null)
      override_artifact_name = lookup(artifacts.value, "override_artifact_name", null)
      location               = lookup(artifacts.value, "location", null)
      name                   = lookup(artifacts.value, "name", null)
      namespace_type         = lookup(artifacts.value, "namespace_type", null)
      packaging              = lookup(artifacts.value, "packaging", null)
      path                   = lookup(artifacts.value, "path", null)
    }
  }

  dynamic "environment" {
    for_each = [for i in lookup(var.project[count.index], "environment") : {
      compute              = i.compute_type
      image                = i.image
      type                 = i.type
      pull                 = i.image_pull_credentials_type
      certificate          = i.certificate
      privileged           = i.privileged_mode
      registry_credential  = lookup(i, "registry_credential")
      environment_variable = lookup(i, "environment_variable")
    }]
    content {
      compute_type                = environment.value.compute
      image                       = environment.value.image
      type                        = environment.value.type
      image_pull_credentials_type = environment.value.pull
      certificate                 = environment.value.certificate
      privileged_mode             = environment.value.privileged

      dynamic "registry_credential" {
        for_each = environment.value.registry_credential == null ? [] : [for i in environment.value.registry_credential : {
          credential          = i.credential
          credential_provider = i.credential_provider
        }]
        content {
          credential          = registry_credential.value.credential
          credential_provider = registry_credential.value.credential_provider
        }
      }

      dynamic "environment_variable" {
        for_each = environment.value.environment_variable == null ? [] : [for i in environment.value.environment_variable : {
          name  = i.name
          value = i.value
        }]
        content {
          name  = environment_variable.value.name
          value = environment_variable.value.value
        }
      }
    }
  }

  dynamic "source" {
    for_each = [for i in lookup(var.project[count.index], "source") : {
      type                = i.type
      buildspec           = i.buildspec
      git_clone_depth     = i.git_clone_depth
      insecure_ssl        = i.insecure_ssl
      location            = i.location
      report_build_status = i.report_build_status
      auth                = lookup(i, "auth", null)
    }]
    content {
      type                = source.value.type
      buildspec           = source.value.buildspec
      git_clone_depth     = source.value.git_clone_depth
      insecure_ssl        = source.value.insecure_ssl
      location            = source.value.location
      report_build_status = source.value.report_build_status

      dynamic "auth" {
        for_each = source.value.auth == null ? [] : [for i in source.value.auth : {
          type     = i.type
          resource = i.resource
        }]
        content {
          type     = auth.value.type
          resource = auth.value.resource
        }
      }
    }
  }

  dynamic "cache" {
    for_each = lookup(var.project[count.index], "cache") == null ? [] : lookup(var.project[count.index], "cache")
    content {
      type     = lookup(cache.value, "type")
      location = lookup(cache.value, "location")
      modes    = [lookup(cache.value, "modes")]
    }
  }

  dynamic "vpc_config" {
    for_each = lookup(var.project[count.index], "vpc_config") == null ? [] : lookup(var.project[count.index], "vpc_config")
    content {
      security_group_ids = [element(var.security_group_id, lookup(vpc_config.value, "security_group_id"))]
      subnets            = [element(var.subnet_id, lookup(vpc_config.value, "subnet_id"))]
      vpc_id             = element(var.vpc_id, lookup(vpc_config.value, "vpc_id"))
    }
  }

  dynamic "secondary_artifacts" {
    for_each = lookup(var.project[count.index], "secondary_artifacts") == null ? [] : lookup(var.project[count.index], "secondary_artifacts")
    content {
      artifact_identifier    = lookup(secondary_artifacts.value, "artifact_identifier")
      type                   = lookup(secondary_artifacts.value, "type")
      encryption_disabled    = lookup(secondary_artifacts.value, "encryption_disabled")
      override_artifact_name = lookup(secondary_artifacts.value, "override_artifact_name")
      location               = lookup(secondary_artifacts.value, "location")
      name                   = lookup(secondary_artifacts.value, "name")
      namespace_type         = lookup(secondary_artifacts.value, "namespace_type")
      packaging              = lookup(secondary_artifacts.value, "packaging")
      path                   = lookup(secondary_artifacts.value, "path")
    }
  }

  dynamic "logs_config" {
    for_each = lookup(var.project[count.index], "logs_config") == null ? [] : [for i in lookup(var.project[count.index], "logs_config") : {
      cloudwatch_logs = lookup(i, "cloudwatch_logs", null)
      s3_logs         = lookup(i, "s3_logs", null)
    }]
    content {
      dynamic "cloudwatch_logs" {
        for_each = [for i in logs_config.value.cloudwatch_logs : {
          group_name  = i.group_name
          status      = i.status
          stream_name = i.stream_name
        }]
        content {
          group_name  = cloudwatch_logs.value.group_name
          status      = cloudwatch_logs.value.status
          stream_name = cloudwatch_logs.value.stream_name
        }
      }
      dynamic "s3_logs" {
        for_each = [for i in logs_config.value.s3_logs : {
          status              = i.status
          encryption_disabled = i.encryption_disabled
          location            = i.location
        }]
        content {
          status              = s3_logs.value.status
          encryption_disabled = s3_logs.value.encryption_disabled
          location            = s3_logs.value.location
        }
      }
    }
  }
}