resource "aws_codebuild_project" "codebuild_project" {
  count        = length(var.codebuild_project)
  name         = lookup(var.codebuild_project[count.index], "name")
  service_role = lookup(var.codebuild_project[count.index], "service_role")

  badge_enabled  = lookup(var.codebuild_project[count.index], "badge_enabled", false)
  build_timeout  = lookup(var.codebuild_project[count.index], "build_timeout", null)
  description    = lookup(var.codebuild_project[count.index], "description", null)
  encryption_key = element(var.kms_key_id, lookup(var.codebuild_project[count.index], "encryption_key_id", null))

  dynamic "artifacts" {
    for_each = lookup(var.codebuild_project[count.index], "artifacts")
    content {
      type = lookup(artifacts.value, "type")

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
    for_each = lookup(var.codebuild_project[count.index], "environment")
    content {
      compute_type = lookup(environment.value, "compute_type")
      image        = lookup(environment.value, "image")
      type         = lookup(environment.value, "type")

      image_pull_credentials_type = lookup(environment.value, "image_pull_credentials_type", null)
      certificate                 = lookup(environment.value, "certificate", null)
      privileged_mode             = lookup(environment.value, "privileged_mode", null)

      registry_credential {
        credential          = lookup(environment.value, "credential", null)
        credential_provider = lookup(environment.value, "credential_provider", null)
      }

      environment_variable {
        name  = lookup(environment.value, "name")
        value = lookup(environment.value, "value")
      }
    }
  }

  dynamic "source" {
    for_each = lookup(var.codebuild_project[count.index], "source")
    content {
      type                = lookup(source.value, "type")
      buildspec           = lookup(source.value, "buildspec")
      git_clone_depth     = lookup(source.value, "git_clone_depth")
      insecure_ssl        = lookup(source.value, "insecure_ssl")
      location            = lookup(source.value, "location")
      report_build_status = lookup(source.value, "report_build_status")

      auth {
        type     = lookup(source.value, "auth_type")
        resource = lookup(source.value, "auth_resource")
      }
    }
  }

  dynamic "cache" {
    for_each = lookup(var.codebuild_project[count.index], "cache") == "" ? 0 : lookup(var.codebuild_project[count.index], "cache")
    content {
      type     = lookup(cache.value, "type")
      location = lookup(cache.value, "location")
      modes    = [lookup(cache.value, "modes")]
    }
  }

  dynamic "vpc_config" {
    for_each = lookup(var.codebuild_project[count.index], "vpc_config") == "" ? 0 : lookup(var.codebuild_project[count.index], "vpc_config")
    content {
      security_group_ids = [element(var.security_group_id, lookup(vpc_config.value, "security_group_id"))]
      subnets            = [element(var.subnet_id, lookup(vpc_config.value, "subnet_id"))]
      vpc_id             = element(var.vpc_id, lookup(vpc_config.value, "vpc_id"))
    }
  }

  dynamic "secondary_artifacts" {
    for_each = lookup(var.codebuild_project[count.index], "secondary_artifacts") == "" ? 0 : lookup(var.codebuild_project[count.index], "secondary_artifacts")
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
    for_each = lookup(var.codebuild_project[count.index], "logs_config") == "" ? 0 : lookup(var.codebuild_project[count.index], "logs_config")
    content {
      cloudwatch_logs {
        group_name  = lookup(logs_config.value, "group_name")
        status      = lookup(logs_config.value, "status")
        stream_name = lookup(logs_config.value, "stream_name")
      }
      s3_logs {
        status              = lookup(logs_config.value, "s3_logs_status")
        encryption_disabled = lookup(logs_config.value, "s3_logs_encryption_disabled")
        location            = lookup(logs_config.value, "s3_logs_location")
      }
    }
  }
}

resource "aws_codebuild_source_credential" "codebuild_source_credential" {
  count       = length(var.codebuild_source_credential)
  auth_type   = lookup(var.codebuild_source_credential[count.index], "auth_type")
  server_type = lookup(var.codebuild_source_credential[count.index], "server_type")
  token       = lookup(var.codebuild_source_credential[count.index], "token")
}

resource "aws_codebuild_webhook" "codebuild_webhook" {
  project_name = ""
}