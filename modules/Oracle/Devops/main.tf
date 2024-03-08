resource "oci_devops_build_pipeline" "this" {
  count = length(var.build_pipeline)
  project_id = try(
    element(oci_devops_project.this.*.id, lookup(var.build_pipeline[count.index], "project_id"))
  )
  defined_tags = merge(
    var.defined_tags,
    lookup(var.build_pipeline[count.index], "defined_tags")
  )
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.build_pipeline[count.index], "freeform_tags")
  )
  description  = lookup(var.build_pipeline[count.index], "description")
  display_name = lookup(var.build_pipeline[count.index], "display_name")

  dynamic "build_pipeline_parameters" {
    for_each = lookup(var.build_pipeline[count.index], "build_pipeline_parameters") == null ? [] : ["build_pipeline_parameters"]
    content {
      dynamic "items" {
        for_each = lookup(build_pipeline_parameters.value, "items")
        content {
          default_value = lookup(items.value, "default_value")
          name          = lookup(items.value, "name")
          description   = lookup(items.value, "description")
        }
      }
    }
  }
}

resource "oci_devops_build_pipeline_stage" "this" {
  count = length(var.pipeline_stage) == "0" ? "0" : length(var.build_pipeline)
  build_pipeline_id = try(
    element(oci_devops_build_pipeline.this.*.id, lookup(var.pipeline_stage[count.index], "build_pipeline_id"))
  )
  build_pipeline_stage_type = lookup(var.pipeline_stage[count.index], "build_pipeline_stage_type")
  build_spec_file           = lookup(var.pipeline_stage[count.index], "build_pipeline_stage_type") == "BUILD" ? lookup(var.pipeline_stage[count.index], "build_spec_file") : null
  defined_tags = merge(
    var.defined_tags,
    lookup(var.pipeline_stage[count.index], "defined_tags")
  )
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.pipeline_stage[count.index], "freeform_tags")
  )
  deploy_pipeline_id = lookup(var.pipeline_stage[count.index], "build_pipeline_stage_type") == "TRIGGER_DEPLOYMENT_PIPELINE" ? try(
    element(oci_devops_deploy_pipeline.this.*.id, lookup(var.pipeline_stage[count.index], "deploy_pipeline_id"))
  ) : null
  description                        = lookup(var.pipeline_stage[count.index], "description")
  display_name                       = lookup(var.pipeline_stage[count.index], "display_name")
  image                              = lookup(var.pipeline_stage[count.index], "image")
  is_pass_all_parameters_enabled     = lookup(var.pipeline_stage[count.index], "is_pass_all_parameters_enabled")
  primary_build_source               = lookup(var.pipeline_stage[count.index], "primary_build_source")
  stage_execution_timeout_in_seconds = lookup(var.pipeline_stage[count.index], "stage_execution_timeout_in_seconds")

  dynamic "build_pipeline_stage_predecessor_collection" {
    for_each = lookup(var.pipeline_stage[count.index], "build_pipeline_stage_predecessor_collection")
    content {
      dynamic "items" {
        for_each = lookup(build_pipeline_stage_predecessor_collection.value, "items")
        content {
          id = lookup(items.value, "id")
        }
      }
    }
  }

  dynamic "build_runner_shape_config" {
    for_each = lookup(var.pipeline_stage[count.index], "build_pipeline_stage_type") == "BUILD" ? lookup(var.pipeline_stage[count.index], "build_runner_shape_config") : []
    content {
      build_runner_type = lookup(build_runner_shape_config.value, "build_runner_type")
      memory_in_gbs     = lookup(build_runner_shape_config.value, "memory_in_gbs")
      ocpus             = lookup(build_runner_shape_config.value, "ocpus")
    }
  }

  dynamic "build_source_collection" {
    for_each = lookup(var.pipeline_stage[count.index], "build_pipeline_stage_type") == "BUILD" ? lookup(var.pipeline_stage[count.index], "build_source_collection") : []
    content {
      dynamic "items" {
        for_each = lookup(build_source_collection.value, "items")
        content {
          connection_type = lookup(items.value, "connection_type")
          branch          = lookup(items.value, "branch")
          connection_id   = lookup(items.value, "connection_type") == "BITBUCKET_CLOUD" || "BITBUCKET_SERVER" || "GITHUB" || "GITLAB" || "GITLAB_SERVER" || "VBS" ? lookup(items.value, "connection_id") : null
          name            = lookup(var.pipeline_stage[count.index], "build_pipeline_stage_type") == "BUILD" ? lookup(items.value, "name") : null
          repository_id   = lookup(items.value, "connection_type") == "DEVOPS_CODE_REPOSITORY" ? lookup(items.value, "repository_id") : null
          repository_url  = lookup(var.pipeline_stage[count.index], "build_pipeline_stage_type") == "BUILD" ? lookup(items.value, "repository_url") : null
        }
      }
    }
  }

  dynamic "deliver_artifact_collection" {
    for_each = lookup(var.pipeline_stage[count.index], "build_pipeline_stage_type") == "DELIVER_ARTIFACT" ? lookup(var.pipeline_stage[count.index], "deliver_artifact_collection") : []
    content {
      dynamic "items" {
        for_each = lookup(deliver_artifact_collection.value, "items")
        content {
          artifact_id   = lookup(items.value, "artifact_id")
          artifact_name = lookup(items.value, "artifact_name")
        }
      }
    }
  }

  dynamic "private_access_config" {
    for_each = lookup(var.pipeline_stage[count.index], "build_pipeline_stage_type") == "BUILD" ? lookup(var.pipeline_stage[count.index], "private_access_config") : []
    content {
      network_channel_type = lookup(private_access_config.value, "network_channel_type")
      subnet_id = try(
        data.oci_core_subnet.this.id
      )
      nsg_ids = lookup(private_access_config.value, "nsg_ids")
    }
  }

  dynamic "wait_criteria" {
    for_each = lookup(var.pipeline_stage[count.index], "build_pipeline_stage_type") == "WAIT" ? lookup(var.pipeline_stage[count.index], "wait_criteria") : []
    content {
      wait_duration = lookup(wait_criteria.value, "wait_duration")
      wait_type     = lookup(wait_criteria.value, "wait_type")
    }
  }
}

resource "oci_devops_build_run" "this" {
  count = length(var.build_run) == "0" ? "0" : length(var.build_pipeline)
  build_pipeline_id = try(
    element(oci_devops_build_pipeline.this.*.id, lookup(var.build_run[count.index], "build_pipeline_id"))
  )
  defined_tags = merge(
    var.defined_tags,
    lookup(var.build_run[count.index], "defined_tags")
  )
  display_name = lookup(var.build_run[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.build_run[count.index], "freeform_tags")
  )

  dynamic "build_run_arguments" {
    for_each = lookup(var.build_run[count.index], "build_run_arguments") == null ? [] : ["build_run_arguments"]
    content {
      dynamic "items" {
        for_each = lookup(build_run_arguments.value, "items")
        content {
          name  = lookup(items.value, "name")
          value = lookup(items.value, "value")
        }
      }
    }
  }

  dynamic "commit_info" {
    for_each = lookup(var.build_run[count.index], "commit_info") == null ? [] : ["commit_info"]
    content {
      commit_hash       = lookup(commit_info.value, "commit_hash")
      repository_branch = lookup(commit_info.value, "repository_branch")
      repository_url    = lookup(commit_info.value, "repository_url")
    }
  }
}

resource "oci_devops_connection" "this" {
  count           = length(var.connection) == "0" ? "0" : length(var.project)
  connection_type = lookup(var.connection[count.index], "connection_type")
  project_id = try(
    element(oci_devops_project.this.*.id, lookup(var.connection[count.index], "project_id"))
  )
  access_token = lookup(var.connection[count.index], "connection_type") == "BITBUCKET_SERVER_ACCESS_TOKEN" || "GITHUB_ACCESS_TOKEN" || "GITLAB_ACCESS_TOKEN" || "GITLAB_SERVER_ACCESS_TOKEN" || "VBS_ACCESS_TOKEN" ? lookup(var.connection[count.index], "access_token") : null
  app_password = lookup(var.connection[count.index], "connection_type") == "BITBUCKET_SERVER_ACCESS_TOKEN" ? lookup(var.connection[count.index], "app_password") : null
  base_url     = lookup(var.connection[count.index], "connection_type") == "BITBUCKET_SERVER_ACCESS_TOKEN" || "GITHUB_ACCESS_TOKEN" || "GITLAB_SERVER_ACCESS_TOKEN" || "VBS_ACCESS_TOKEN" ? lookup(var.connection[count.index], "base_url") : null
  defined_tags = merge(
    var.defined_tags,
    lookup(var.connection[count.index], "defined_tags")
  )
  description  = lookup(var.connection[count.index], "description")
  display_name = lookup(var.connection[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.connection[count.index], "freeform_tags")
  )
  username = lookup(var.connection[count.index], "connection_type") == "BITBUCKET_CLOUD_APP_PASSWORD" ? lookup(var.connection[count.index], "username") : null

  dynamic "tls_verify_config" {
    for_each = lookup(var.connection[count.index], "connection_type") == "BITBUCKET_SERVER_ACCESS_TOKEN" || "GITLAB_SERVER_ACCESS_TOKEN" ? lookup(var.connection[count.index], "tls_verify_config") : []
    content {
      ca_certificate_bundle_id = lookup(tls_verify_config.value, "ca_certificate_bundle_id")
      tls_verify_mode          = lookup(tls_verify_config.value, "tls_verify_mode")
    }
  }
}

resource "oci_devops_deploy_artifact" "this" {
  count                      = length(var.deploy_artifact) == "0" ? "0" : length(var.project)
  argument_substitution_mode = ""
  deploy_artifact_type       = ""
  project_id = try(
    element(oci_devops_project.this.*.id, lookup(var.deploy_artifact[count.index], "project_id"))
  )
  defined_tags = merge(
    var.defined_tags,
    lookup(var.deploy_artifact[count.index], "defined_tags")
  )
  description  = ""
  display_name = ""
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.deploy_artifact[count.index], "freeform_tags")
  )

  dynamic "deploy_artifact_source" {
    for_each = lookup(var.deploy_artifact[count.index], "deploy_artifact_source")
    content {
      deploy_artifact_source_type = lookup(deploy_artifact_source.value, "deploy_artifact_source_type")
      base64encoded_content       = lookup(deploy_artifact_source.value, "deploy_artifact_source_type") == "INLINE" ? lookup(deploy_artifact_source.value, "base64encoded_content") : null
      chart_url                   = lookup(deploy_artifact_source.value, "deploy_artifact_source_type") == "HELM" ? lookup(deploy_artifact_source.value, "chart_url") : null
      deploy_artifact_path        = lookup(deploy_artifact_source.value, "deploy_artifact_source_type") == "GENERIC_ARTIFACT" ? lookup(deploy_artifact_source.value, "chart_url") : null
      deploy_artifact_version     = lookup(deploy_artifact_source.value, "deploy_artifact_source_type") == "GENERIC_ARTIFACT" ? lookup(deploy_artifact_source.value, "chart_url") : null
      image_digest                = lookup(deploy_artifact_source.value, "deploy_artifact_source_type") == "OCIR" ? lookup(deploy_artifact_source.value, "image_digest") : null
      image_uri                   = lookup(deploy_artifact_source.value, "deploy_artifact_source_type") == "OCIR" ? lookup(deploy_artifact_source.value, "image_uri") : null
      repository_id               = lookup(deploy_artifact_source.value, "deploy_artifact_source_type") == "GENERIC_ARTIFACT" ? lookup(deploy_artifact_source.value, "repository_id") : null

      dynamic "helm_verification_key_source" {
        for_each = lookup(deploy_artifact_source.value, "deploy_artifact_source_type") == "HELM" ? lookup(deploy_artifact_source.value, "helm_verification_key_source") : []
        content {
          verification_key_source_type = lookup(helm_verification_key_source.value, "verification_key_source_type")
          current_public_key           = lookup(helm_verification_key_source.value, "current_public_key")
          previous_public_key          = lookup(helm_verification_key_source.value, "previous_public_key")
          vault_secret_id              = lookup(helm_verification_key_source.value, "vault_secret_id")
        }
      }
    }
  }
}

resource "oci_devops_deploy_environment" "this" {
  count                   = length(var.deploy_environment) == "0" ? "0" : length(var.project)
  deploy_environment_type = lookup(var.deploy_environment[count.index], "deploy_environment_type")
  project_id = try(
    element(oci_devops_project.this.*.id, lookup(var.deploy_environment[count.index], "project_id"))
  )
  cluster_id = lookup(var.deploy_environment[count.index], "deploy_environment_type") == "OKE_CLUSTER" ? lookup(var.deploy_environment[count.index], "cluster_id") : null
  defined_tags = merge(
    var.defined_tags,
    lookup(var.deploy_environment[count.index], "defined_tags")
  )
  description  = lookup(var.deploy_environment[count.index], "description")
  display_name = lookup(var.deploy_environment[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.deploy_environment[count.index], "freeform_tags")
  )
  function_id = try(data.oci_functions_function.this.id)

  dynamic "compute_instance_group_selectors" {
    for_each = lookup(var.deploy_environment[count.index], "deploy_environment_type") == "COMPUTE_INSTANCE_GROUP" ? lookup(var.deploy_environment[count.index], "compute_instance_group_selectors") : []
    content {
      dynamic "items" {
        for_each = lookup(compute_instance_group_selectors.value, "items")
        content {
          selector_type        = lookup(items.value, "selector_type")
          compute_instance_ids = lookup(items.value, "compute_instance_ids")
          query                = lookup(items.value, "query")
          region               = lookup(items.value, "region")
        }
      }
    }
  }

  dynamic "network_channel" {
    for_each = lookup(var.deploy_environment[count.index], "deploy_environment_type") == "OKE_CLUSTER" ? lookup(var.deploy_environment[count.index], "network_channel") : []
    content {
      network_channel_type = lookup(network_channel.value, "network_channel_type")
      subnet_id            = try(data.oci_core_subnet.this.id)
      nsg_ids              = lookup(network_channel.value, "nsg_ids")
    }
  }
}

resource "oci_devops_deploy_pipeline" "this" {
  count = length(var.deploy_pipeline) == "0" ? "0" : length(var.project)
  project_id = try(
    element(oci_devops_project.this.*.id, lookup(var.deploy_pipeline[count.index], "project_id"))
  )
  defined_tags = merge(
    var.defined_tags,
    lookup(var.deploy_pipeline[count.index], "defined_tags")
  )
  description  = lookup(var.deploy_pipeline[count.index], "description")
  display_name = lookup(var.deploy_pipeline[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.deploy_pipeline[count.index], "freeform_tags")
  )

  dynamic "deploy_pipeline_parameters" {
    for_each = lookup(var.deploy_pipeline[count.index], "deploy_pipeline_parameters") == null ? [] : ["deploy_pipeline_parameters"]
    content {
      dynamic "items" {
        for_each = lookup(deploy_pipeline_parameters.value, "items")
        content {
          name          = lookup(items.value, "name")
          default_value = lookup(items.value, "default_value")
          description   = lookup(items.value, "description")
        }
      }
    }
  }
}

resource "oci_devops_deploy_stage" "this" {
  count = length(var.deploy_stage) == "0" ? "0" : length(var.project)
  deploy_pipeline_id = try(
    element(oci_devops_deploy_pipeline.this.*.id, lookup(var.deploy_stage[count.index], "deploy_pipeline_id"))
  )
  deploy_stage_type                                            = lookup(var.deploy_stage[count.index], "deploy_stage_type")
  are_hooks_enabled                                            = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_HELM_CHART_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "are_hooks_enabled") : null
  command_spec_deploy_artifact_id                              = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "SHELL" ? lookup(var.deploy_stage[count.index], "failure_policy") : null
  compute_instance_group_blue_green_deployment_deploy_stage_id = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "COMPUTE_INSTANCE_GROUP_BLUE_GREEN_TRAFFIC_SHIFT" ? lookup(var.deploy_stage[count.index], "compute_instance_group_blue_green_deployment_deploy_stage_id") : null
  compute_instance_group_canary_deploy_stage_id                = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "COMPUTE_INSTANCE_GROUP_CANARY_TRAFFIC_SHIFT" ? lookup(var.deploy_stage[count.index], "compute_instance_group_canary_deploy_stage_id") : null
  compute_instance_group_canary_traffic_shift_deploy_stage_id  = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "COMPUTE_INSTANCE_GROUP_CANARY_APPROVAL" ? lookup(var.deploy_stage[count.index], "compute_instance_group_canary_traffic_shift_deploy_stage_id") : null
  compute_instance_group_deploy_environment_id                 = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "COMPUTE_INSTANCE_GROUP_CANARY_DEPLOYMENT" || "COMPUTE_INSTANCE_GROUP_ROLLING_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "compute_instance_group_deploy_environment_id") : null
  config                                                       = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "DEPLOY_FUNCTION" ? lookup(var.deploy_stage[count.index], "config") : null
  defined_tags = merge(
    var.defined_tags,
    lookup(var.deploy_stage[count.index], "defined_tags")
  )
  deploy_artifact_id                 = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "INVOKE_FUNCTION" ? lookup(var.deploy_stage[count.index], "deploy_artifact_id") : null
  deploy_artifact_ids                = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "COMPUTE_INSTANCE_GROUP_BLUE_GREEN_DEPLOYMENT" || "COMPUTE_INSTANCE_GROUP_CANARY_DEPLOYMENT" || "COMPUTE_INSTANCE_GROUP_ROLLING_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "deploy_artifact_ids") : null
  deploy_environment_id_a            = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "COMPUTE_INSTANCE_GROUP_BLUE_GREEN_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "deploy_environment_id_a") : null
  deploy_environment_id_b            = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "COMPUTE_INSTANCE_GROUP_BLUE_GREEN_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "deploy_environment_id_b") : null
  deployment_spec_deploy_artifact_id = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "COMPUTE_INSTANCE_GROUP_BLUE_GREEN_DEPLOYMENT" || "COMPUTE_INSTANCE_GROUP_CANARY_DEPLOYMENT" || "COMPUTE_INSTANCE_GROUP_ROLLING_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "deployment_spec_deploy_artifact_id") : null
  docker_image_deploy_artifact_id    = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "DEPLOY_FUNCTION" ? lookup(var.deploy_stage[count.index], "docker_image_deploy_artifact_id") : null
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.deploy_stage[count.index], "freeform_tags")
  )
  function_deploy_environment_id           = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "DEPLOY_FUNCTION" || "INVOKE_FUNCTION" ? lookup(var.deploy_stage[count.index], "function_deploy_environment_id") : null
  function_timeout_in_seconds              = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "DEPLOY_FUNCTION" ? lookup(var.deploy_stage[count.index], "function_timeout_in_seconds") : null
  helm_chart_deploy_artifact_id            = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_HELM_CHART_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "helm_chart_deploy_artifact_id") : null
  is_async                                 = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "INVOKE_FUNCTION" ? lookup(var.deploy_stage[count.index], "is_async") : null
  is_debug_enabled                         = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_HELM_CHART_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "is_debug_enabled") : null
  is_force_enabled                         = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_HELM_CHART_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "is_force_enabled") : null
  is_validation_enabled                    = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "INVOKE_FUNCTION" ? lookup(var.deploy_stage[count.index], "is_validation_enabled") : null
  kubernetes_manifest_deploy_artifact_ids  = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_BLUE_GREEN_DEPLOYMENT" || "OKE_CANARY_DEPLOYMENT" || "OKE_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "kubernetes_manifest_deploy_artifact_ids") : null
  max_history                              = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_HELM_CHART_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "max_history") : null
  max_memory_in_mbs                        = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "DEPLOY_FUNCTION" ? lookup(var.deploy_stage[count.index], "max_memory_in_mbs") : null
  namespace                                = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_DEPLOYMENT" || "OKE_HELM_CHART_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "namespace") : null
  oke_blue_green_deploy_stage_id           = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_BLUE_GREEN_TRAFFIC_SHIFT" ? lookup(var.deploy_stage[count.index], "oke_blue_green_deploy_stage_id") : null
  oke_canary_deploy_stage_id               = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_BLUE_GREEN_TRAFFIC_SHIFT" ? lookup(var.deploy_stage[count.index], "oke_canary_deploy_stage_id") : null
  oke_canary_traffic_shift_deploy_stage_id = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_CANARY_TRAFFIC_SHIFT" ? lookup(var.deploy_stage[count.index], "oke_canary_traffic_shift_deploy_stage_id") : null
  oke_cluster_deploy_environment_id        = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_BLUE_GREEN_DEPLOYMENT" || "OKE_CANARY_DEPLOYMENT" || "OKE_DEPLOYMENT" || "OKE_HELM_CHART_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "oke_cluster_deploy_environment_id") : null
  release_name                             = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_HELM_CHART_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "release_name") : null
  should_cleanup_on_fail                   = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_HELM_CHART_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "should_cleanup_on_fail") : null
  should_not_wait                          = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_HELM_CHART_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "should_not_wait") : null
  should_reset_values                      = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_HELM_CHART_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "should_reset_values") : null
  should_reuse_values                      = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_HELM_CHART_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "should_reuse_values") : null
  should_skip_crds                         = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_HELM_CHART_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "should_skip_crds") : null
  should_skip_render_subchart_notes        = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_HELM_CHART_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "should_skip_render_subchart_notes") : null
  timeout_in_seconds                       = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "SHELL" || "OKE_HELM_CHART_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "timeout_in_seconds") : null
  traffic_shift_target                     = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "LOAD_BALANCER_TRAFFIC_SHIFT" ? lookup(var.deploy_stage[count.index], "traffic_shift_target") : null
  values_artifact_ids                      = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_HELM_CHART_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "values_artifact_ids") : null

  dynamic "deploy_stage_predecessor_collection" {
    for_each = lookup(var.deploy_stage[count.index], "deploy_stage_predecessor_collection")
    content {
      dynamic "items" {
        for_each = lookup(deploy_stage_predecessor_collection.value, "items")
        content {
          id = lookup(items.value, "id")
        }
      }
    }
  }

  dynamic "approval_policy" {
    for_each = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "COMPUTE_INSTANCE_GROUP_CANARY_APPROVAL" || "MANUAL_APPROVAL" || "OKE_CANARY_APPROVAL" ? lookup(var.deploy_stage[count.index], "approval_policy") : []
    content {
      approval_policy_type         = lookup(approval_policy.value, "approval_policy_type")
      number_of_approvals_required = lookup(approval_policy.value, "number_of_approvals_required")
    }
  }

  dynamic "blue_backend_ips" {
    for_each = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "LOAD_BALANCER_TRAFFIC_SHIFT" ? lookup(var.deploy_stage[count.index], "blue_backend_ips") : []
    content {
      items = lookup(blue_backend_ips.value, "items")
    }
  }

  dynamic "blue_green_strategy" {
    for_each = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_BLUE_GREEN_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "blue_green_strategy") : []
    content {
      ingress_name  = lookup(blue_green_strategy.value, "ingress_name")
      namespace_a   = lookup(blue_green_strategy.value, "namespace_a")
      namespace_b   = lookup(blue_green_strategy.value, "namespace_b")
      strategy_type = lookup(blue_green_strategy.value, "strategy_type")
    }
  }

  dynamic "canary_strategy" {
    for_each = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_CANARY_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "canary_strategy") : []
    content {
      ingress_name  = lookup(canary_strategy.value, "ingress_name")
      namespace     = lookup(canary_strategy.value, "namespace")
      strategy_type = lookup(canary_strategy.value, "strategy_type")
    }
  }

  dynamic "container_config" {
    for_each = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "SHELL" ? lookup(var.deploy_stage[count.index], "container_config") : []
    content {
      container_config_type = lookup(container_config.value, "container_config_type")
      shape_name            = lookup(container_config.value, "shape_name")
      availability_domain   = lookup(container_config.value, "availability_domain")
      compartment_id        = lookup(container_config.value, "compartment_id")

      dynamic "network_channel" {
        for_each = lookup(container_config.value, "network_channel")
        content {
          network_channel_type = lookup(network_channel.value, "network_channel_type")
          subnet_id = try(
            data.oci_core_subnet.this.id,
            lookup(network_channel.value, "subnet_id")
          )
          nsg_ids = lookup(network_channel.value, "nsg_ids")
        }
      }
      dynamic "shape_config" {
        for_each = lookup(container_config.value, "shape_config")
        content {
          ocpus         = lookup(shape_config.value, "ocpus")
          memory_in_gbs = lookup(shape_config.value, "memory_in_gbs")
        }
      }
    }
  }

  dynamic "failure_policy" {
    for_each = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "COMPUTE_INSTANCE_GROUP_BLUE_GREEN_DEPLOYMENT" || "COMPUTE_INSTANCE_GROUP_ROLLING_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "failure_policy") : []
    content {
      policy_type        = lookup(failure_policy.value, "policy_type")
      failure_count      = lookup(failure_policy.value, "failure_count")
      failure_percentage = lookup(failure_policy.value, "failure_percentage")
    }
  }

  dynamic "green_backend_ips" {
    for_each = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "LOAD_BALANCER_TRAFFIC_SHIFT" ? lookup(var.deploy_stage[count.index], "green_backend_ips") : []
    content {
      items = lookup(green_backend_ips.value, "items")
    }
  }

  dynamic "load_balancer_config" {
    for_each = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "LOAD_BALANCER_TRAFFIC_SHIFT" || "COMPUTE_INSTANCE_GROUP_ROLLING_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "load_balancer_config") : []
    content {
      backend_port     = lookup(load_balancer_config.value, "backend_port")
      listener_name    = lookup(load_balancer_config.value, "listener_name")
      load_balancer_id = lookup(load_balancer_config.value, "load_balancer_id")
    }
  }

  dynamic "production_load_balancer_config" {
    for_each = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "COMPUTE_INSTANCE_GROUP_BLUE_GREEN_DEPLOYMENT" || "COMPUTE_INSTANCE_GROUP_CANARY_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "production_load_balancer_config") : []
    content {
      backend_port     = lookup(production_load_balancer_config.value, "backend_port")
      listener_name    = lookup(production_load_balancer_config.value, "listener_name")
      load_balancer_id = lookup(production_load_balancer_config.value, "load_balancer_id")
    }
  }

  dynamic "rollback_policy" {
    for_each = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "LOAD_BALANCER_TRAFFIC_SHIFT" || "OKE_DEPLOYMENT" || "OKE_HELM_CHART_DEPLOYMENT" || "COMPUTE_INSTANCE_GROUP_ROLLING_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "rollback_policy") : []
    content {
      policy_type = lookup(rollback_policy.value, "policy_type")
    }
  }

  dynamic "rollout_policy" {
    for_each = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "COMPUTE_INSTANCE_GROUP_BLUE_GREEN_DEPLOYMENT" || "COMPUTE_INSTANCE_GROUP_ROLLING_DEPLOYMENT" || "COMPUTE_INSTANCE_GROUP_CANARY_DEPLOYMENT" || "COMPUTE_INSTANCE_GROUP_CANARY_TRAFFIC_SHIFT" || "LOAD_BALANCER_TRAFFIC_SHIFT" || "OKE_CANARY_TRAFFIC_SHIFT" ? lookup(var.deploy_stage[count.index], "rollout_policy") : []
    content {
      policy_type            = lookup(rollout_policy.value, "policy_type")
      batch_count            = lookup(rollout_policy.value, "batch_count")
      batch_delay_in_seconds = lookup(rollout_policy.value, "batch_delay_in_seconds")
      batch_percentage       = lookup(rollout_policy.value, "batch_percentage")
      ramp_limit_percent     = lookup(rollout_policy.value, "ramp_limit_percent")
    }
  }

  dynamic "set_string" {
    for_each = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_HELM_CHART_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "set_string") : []
    content {
      dynamic "items" {
        for_each = lookup(set_string.value, "items")
        content {
          name  = lookup(items.value, "name")
          value = lookup(items.value, "value")
        }
      }
    }
  }

  dynamic "set_values" {
    for_each = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "OKE_HELM_CHART_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "set_values") : []
    content {
      dynamic "items" {
        for_each = lookup(set_values.value, "items")
        content {
          name  = lookup(items.value, "name")
          value = lookup(items.value, "value")
        }
      }
    }
  }

  dynamic "test_load_balancer_config" {
    for_each = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "COMPUTE_INSTANCE_GROUP_BLUE_GREEN_DEPLOYMENT" || "COMPUTE_INSTANCE_GROUP_CANARY_DEPLOYMENT" ? lookup(var.deploy_stage[count.index], "test_load_balancer_config") : []
    content {
      backend_port     = lookup(test_load_balancer_config.value, "backend_port")
      listener_name    = lookup(test_load_balancer_config.value, "listener_name")
      load_balancer_id = lookup(test_load_balancer_config.value, "load_balancer_id")
    }
  }

  dynamic "wait_criteria" {
    for_each = lookup(var.deploy_stage[count.index], "deploy_stage_type") == "WAIT" ? lookup(var.deploy_stage[count.index], "wait_criteria") : []
    content {
      wait_duration = lookup(wait_criteria.value, "wait_duration")
      wait_type     = lookup(wait_criteria.value, "wait_type")
    }
  }
}

resource "oci_devops_deployment" "this" {
  count = length(var.deployment) == "0" ? "0" : length(var.deploy_pipeline)
  deploy_pipeline_id = try(
    element(oci_devops_deploy_pipeline.this.*.id, lookup(var.deployment[count.index], "deploy_pipeline_id"))
  )
  deployment_type = lookup(var.deployment[count.index], "deployment_type")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.deployment[count.index], "defined_tags")
  )
  deploy_stage_id = lookup(var.deployment[count.index], "deployment_type") == "PIPELINE_DEPLOYMENT" || "SINGLE_STAGE_REDEPLOYMENT" ? lookup(var.deployment[count.index], "previous_deployment_id") : null
  display_name    = lookup(var.deployment[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.deployment[count.index], "freeform_tags")
  )
  previous_deployment_id        = lookup(var.deployment[count.index], "deployment_type") == "PIPELINE_REDEPLOYMENT" || "SINGLE_STAGE_REDEPLOYMENT" ? lookup(var.deployment[count.index], "previous_deployment_id") : null
  trigger_new_devops_deployment = lookup(var.deployment[count.index], "trigger_new_devops_deployment")

  dynamic "deploy_artifact_override_arguments" {
    for_each = lookup(var.deployment[count.index], "deployment_type") == "PIPELINE_DEPLOYMENT" || "SINGLE_STAGE_DEPLOYMENT" ? lookup(var.deployment[count.index], "deploy_artifact_override_arguments") : []
    content {
      dynamic "items" {
        for_each = ""
        content {
          deploy_artifact_id = lookup(deploy_artifact_override_arguments.value, "deploy_artifact_id")
          name               = lookup(deploy_artifact_override_arguments.value, "name")
          value              = lookup(deploy_artifact_override_arguments.value, "value")
        }

      }
    }
  }

  dynamic "deploy_stage_override_arguments" {
    for_each = lookup(var.deployment[count.index], "deployment_type") == "PIPELINE_DEPLOYMENT" || "SINGLE_STAGE_DEPLOYMENT" ? lookup(var.deployment[count.index], "deploy_stage_override_arguments") : []
    content {
      items {
        deploy_stage_id = lookup(deploy_stage_override_arguments.value, "deploy_stage_id")
        name            = lookup(deploy_stage_override_arguments.value, "name")
        value           = lookup(deploy_stage_override_arguments.value, "value")
      }
    }
  }

  dynamic "deployment_arguments" {
    for_each = lookup(var.deployment[count.index], "deployment_type") == "PIPELINE_DEPLOYMENT" || "SINGLE_STAGE_DEPLOYMENT" ? lookup(var.deployment[count.index], "deployment_arguments") : []
    content {
      items {
        name  = lookup(deployment_arguments.value, "name")
        value = lookup(deployment_arguments.value, "value")
      }
    }
  }
}

resource "oci_devops_project" "this" {
  count          = length(var.project)
  compartment_id = data.oci_identity_compartment.this.id
  name           = lookup(var.project[count.index], "name")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.project[count.index], "defined_tags")
  )
  description = lookup(var.project[count.index], "description")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.project[count.index], "freeform_tags")
  )

  dynamic "notification_config" {
    for_each = lookup(var.project[count.index], "notification_config") == null ? [] : ["notification_config"]
    content {
      topic_id = lookup(notification_config.value, "topic_i")
    }
  }
}

resource "oci_devops_repository" "this" {
  count = length(var.repository) == "0" ? "0" : length(var.project)
  name  = lookup(var.repository[count.index], "name")
  project_id = try(
    element(oci_devops_project.this.*.id, lookup(var.repository[count.index], "project_id"))
  )
  repository_type = lookup(var.repository[count.index], "repository_type")
  default_branch  = lookup(var.repository[count.index], "default_branch")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.repository[count.index], "defined_tags")
  )
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.repository[count.index], "freeform_tags")
  )

  dynamic "mirror_repository_config" {
    for_each = lookup(var.repository[count.index], "mirror_repository_config") == null ? [] : ["mirror_repository_config"]
    content {
      connector_id   = lookup(mirror_repository_config.value, "connector_id")
      repository_url = lookup(mirror_repository_config.value, "repository_url")

      dynamic "trigger_schedule" {
        for_each = lookup(mirror_repository_config.value, "trigger_schedule") == null ? [] : ["trigger_schedule"]
        content {
          schedule_type   = lookup(trigger_schedule.value, "schedule_type")
          custom_schedule = lookup(trigger_schedule.value, "custom_schedule")
        }

      }
    }
  }
}

resource "oci_devops_repository_mirror" "this" {
  count = length(var.repository_mirror) == "0" ? "0" : length(var.repository)
  repository_id = try(
    element(oci_devops_repository.this.*.id, lookup(var.repository_mirror[count.index], "repository_id"))
  )
}

resource "oci_devops_repository_ref" "this" {
  count    = length(var.repository_ref) == "0" ? "0" : length(var.repository)
  ref_name = lookup(var.repository_ref[count.index], "ref_name")
  ref_type = lookup(var.repository_ref[count.index], "ref_type")
  repository_id = try(
    element(oci_devops_repository.this.*.id, lookup(var.repository_ref[count.index], "repository_id"))
  )
  commit_id = lookup(var.repository_ref[count.index], "ref_type") == "BRANCH" ? lookup(var.repository_ref[count.index], "commit_id") : null
  object_id = lookup(var.repository_ref[count.index], "ref_type") == "TAG" ? lookup(var.repository_ref[count.index], "object_id") : null
}

resource "oci_devops_trigger" "this" {
  count = length(var.trigger) == "0" ? "0" : length(var.project)
  project_id = try(
    element(oci_devops_project.this.*.id, lookup(var.trigger[count.index], "project_id"))
  )
  trigger_source = lookup(var.trigger[count.index], "trigger_source")
  connection_id  = lookup(var.trigger[count.index], "connection_id")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.trigger[count.index], "defined_tags")
  )
  description  = lookup(var.trigger[count.index], "description")
  display_name = lookup(var.trigger[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.trigger[count.index], "freeform_tags")
  )
  repository_id = try(
    element(oci_devops_repository.this.*.id, lookup(var.trigger[count.index], "repository_id"))
  )

  dynamic "actions" {
    for_each = lookup(var.trigger[count.index], "actions")
    content {
      build_pipeline_id = lookup(actions.value, "build_pipeline_id")
      type              = lookup(actions.value, "type")

      dynamic "filter" {
        for_each = lookup(actions.value, "filter") == null ? [] : ["filter"]
        content {
          trigger_source = lookup(filter.value, "trigger_source")
          events         = lookup(filter.value, "events")
          dynamic "exclude" {
            for_each = lookup(filter.value, "trigger_source") == "BITBUCKET_CLOUD" || "DEVOPS_CODE_REPOSITORY" || "GITHUB" || "GITLAB" || "GITLAB_SERVER" ? lookup(filter.value, "exclude") : []
            content {
              dynamic "file_filter" {
                for_each = lookup(exclude.value, "file_filter")
                content {
                  file_paths = lookup(file_filter.value, "file_paths")
                }
              }
            }
          }

          dynamic "include" {
            for_each = lookup(filter.value, "include") == null ? [] : ["include"]
            content {
              base_ref        = lookup(filter.value, "trigger_source") == "BITBUCKET_CLOUD" || "DEVOPS_CODE_REPOSITORY" || "GITHUB" || "GITLAB" || "GITLAB_SERVER" || "VBS" ? lookup(include.value, "base_ref") : null
              head_ref        = lookup(include.value, "head_ref")
              repository_name = lookup(include.value, "repository_name")

              dynamic "file_filter" {
                for_each = lookup(filter.value, "trigger_source") == "BITBUCKET_CLOUD" || "DEVOPS_CODE_REPOSITORY" || "GITHUB" || "GITLAB" || "GITLAB_SERVER" || "VBS" ? lookup(filter.value, "file_filter") : []
                content {
                  file_paths = lookup(file_filter.value, "file_paths")
                }
              }
            }
          }
        }
      }
    }
  }
}