variable "defined_tags" {
  type    = map(string)
  default = {}
}

variable "freeform_tags" {
  type    = map(string)
  default = {}
}

variable "compartment_id" {
  type        = string
  description = <<EOF
This data source provides details about a specific Compartment resource in Oracle Cloud Infrastructure Identity service.
Gets the specified compartment's information.
EOF
}

variable "subnet_id" {
  type    = string
  default = null
}

variable "function_id" {
  type    = string
  default = null
}

variable "build_pipeline" {
  type = list(map(object({
    id            = number
    project_id    = number
    defined_tags  = optional(map(string))
    freeform_tags = optional(map(string))
    description   = optional(string)
    display_name  = optional(string)
    build_pipeline_parameters = optional(list(object({
      items = list(object({
        default_value = string
        name          = string
        description   = optional(string)
      }))
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Build Pipeline resource in Oracle Cloud Infrastructure Devops service.
EOF
}

variable "pipeline_stage" {
  type = list(map(object({
    id                                 = number
    build_pipeline_id                  = number
    build_pipeline_stage_type          = string
    build_spec_file                    = optional(string)
    defined_tags                       = optional(map(string))
    freeform_tags                      = optional(map(string))
    deploy_pipeline_id                 = optional(number)
    description                        = optional(string)
    display_name                       = optional(string)
    image                              = optional(string)
    is_pass_all_parameters_enabled     = optional(bool)
    primary_build_source               = optional(string)
    stage_execution_timeout_in_seconds = optional(number)
    build_pipeline_stage_predecessor_collection = list(object({
      items = list(object({
        id = string
      }))
    }))
    build_runner_shape_config = optional(list(object({
      build_runner_type = string
      memory_in_gbs     = number
      ocpus             = number
    })), [])
    build_source_collection = optional(list(object({
      items = list(object({
        connection_type = string
        branch          = optional(string)
        connection_id   = optional(string)
        name            = optional(string)
        repository_id   = optional(string)
        repository_url  = optional(string)
      }))
    })), [])
    deliver_artifact_collection = optional(list(object({
      items = list(object({
        artifact_id   = string
        artifact_name = string
      }))
    })), [])
    private_access_config = optional(list(object({
      network_channel_type = string
      nsg_ids              = optional(list(string))
    })), [])
    wait_criteria = optional(list(object({
      wait_duration = string
      wait_type     = string
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Build Pipeline Stage resource in Oracle Cloud Infrastructure Devops service.
EOF
}

variable "build_run" {
  type = list(map(object({
    id                = number
    build_pipeline_id = number
    defined_tags      = optional(map(string))
    display_name      = optional(string)
    freeform_tags     = optional(map(string))
    build_run_arguments = optional(list(object({
      items = list(object({
        name  = string
        value = string
      }))
    })), [])
    commit_info = optional(list(object({
      commit_hash       = string
      repository_branch = string
      repository_url    = string
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Build Run resource in Oracle Cloud Infrastructure Devops service.
EOF
}

variable "connection" {
  type = list(map(object({
    id              = number
    connection_type = string
    project_id      = number
    access_token    = optional(string)
    app_password    = optional(string)
    base_url        = optional(string)
    defined_tags    = optional(map(string))
    description     = optional(string)
    display_name    = optional(string)
    freeform_tags   = optional(map(string))
    username        = optional(string)
    tls_verify_config = optional(list(object({
      ca_certificate_bundle_id = string
      tls_verify_mode          = string
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Connection resource in Oracle Cloud Infrastructure Devops service.
EOF
}

variable "deploy_artifact" {
  type = list(map(object({
    id                         = number
    argument_substitution_mode = string
    deploy_artifact_type       = string
    project_id                 = number
    defined_tags               = optional(map(string))
    description                = optional(string)
    display_name               = optional(string)
    freeform_tags              = optional(map(string))
    deploy_artifact_source = optional(list(object({
      deploy_artifact_source_type = string
      base64encoded_content       = optional(string)
      chart_url                   = optional(string)
      deploy_artifact_path        = optional(string)
      deploy_artifact_version     = optional(string)
      image_digest                = optional(string)
      image_uri                   = optional(string)
      repository_id               = optional(string)
      helm_verification_key_source = optional(list(object({
        verification_key_source_type = string
        current_public_key           = optional(string)
        previous_public_key          = optional(string)
        vault_secret_id              = optional(string)
      })), [])
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Deploy Artifact resource in Oracle Cloud Infrastructure Devops service.
EOF
}

variable "deploy_environment" {
  type = list(map(object({
    id                      = number
    deploy_environment_type = string
    project_id              = number
    cluster_id              = optional(string)
    defined_tags            = optional(map(string))
    description             = optional(string)
    display_name            = optional(string)
    freeform_tags           = optional(map(string))
    function_id             = optional(string)
    compute_instance_group_selectors = optional(list(object({
      items = optional(list(object({
        selector_type        = string
        compute_instance_ids = optional(list(string))
        query                = optional(string)
        region               = optional(string)
      })), [])
    })), [])
    network_channel = optional(list(object({
      network_channel_type = string
      nsg_ids              = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Deploy Environment resource in Oracle Cloud Infrastructure Devops service.
EOF
}

variable "deploy_pipeline" {
  type = list(map(object({
    id            = number
    project_id    = number
    defined_tags  = optional(map(string))
    description   = optional(string)
    display_name  = optional(string)
    freeform_tags = optional(map(string))
    deploy_pipeline_parameters = optional(list(object({
      items = optional(list(object({
        name          = string
        default_value = optional(string)
        description   = optional(string)
      })), [])
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Deploy Pipeline resource in Oracle Cloud Infrastructure Devops service.
EOF
}

variable "deploy_stage" {
  type = list(map(object({
    id                                                           = number
    deploy_pipeline_id                                           = number
    deploy_stage_type                                            = string
    are_hooks_enabled                                            = optional(bool)
    command_spec_deploy_artifact_id                              = optional(string)
    compute_instance_group_blue_green_deployment_deploy_stage_id = optional(string)
    compute_instance_group_canary_deploy_stage_id                = optional(string)
    compute_instance_group_canary_traffic_shift_deploy_stage_id  = optional(string)
    compute_instance_group_deploy_environment_id                 = optional(string)
    config                                                       = optional(map(string))
    defined_tags                                                 = optional(map(string))
    deploy_artifact_id                                           = optional(string)
    deploy_artifact_ids                                          = optional(list(string))
    deploy_environment_id_a                                      = optional(string)
    deploy_environment_id_b                                      = optional(string)
    deployment_spec_deploy_artifact_id                           = optional(string)
    docker_image_deploy_artifact_id                              = optional(string)
    freeform_tags                                                = optional(map(string))
    function_deploy_environment_id                               = optional(string)
    function_timeout_in_seconds                                  = optional(number)
    helm_chart_deploy_artifact_id                                = optional(string)
    is_async                                                     = optional(bool)
    is_debug_enabled                                             = optional(bool)
    is_force_enabled                                             = optional(bool)
    is_validation_enabled                                        = optional(bool)
    kubernetes_manifest_deploy_artifact_ids                      = optional(list(string))
    max_history                                                  = optional(number)
    max_memory_in_mbs                                            = optional(string)
    namespace                                                    = optional(string)
    oke_blue_green_deploy_stage_id                               = optional(string)
    oke_canary_deploy_stage_id                                   = optional(string)
    oke_canary_traffic_shift_deploy_stage_id                     = optional(string)
    oke_cluster_deploy_environment_id                            = optional(string)
    release_name                                                 = optional(string)
    should_cleanup_on_fail                                       = optional(bool)
    should_not_wait                                              = optional(bool)
    should_reset_values                                          = optional(bool)
    should_reuse_values                                          = optional(bool)
    should_skip_crds                                             = optional(bool)
    should_skip_render_subchart_notes                            = optional(bool)
    timeout_in_seconds                                           = optional(number)
    traffic_shift_target                                         = optional(string)
    values_artifact_ids                                          = optional(list(string))
    deploy_stage_predecessor_collection = optional(list(object({
      items = optional(list(object({
        id = string
      })), [])
    })), [])
    approval_policy = optional(list(object({
      approval_policy_type         = string
      number_of_approvals_required = number
    })), [])
    blue_backend_ips = optional(list(object({
      items = optional(list(string))
    })), [])
    blue_green_strategy = optional(list(object({
      ingress_name  = string
      namespace_a   = string
      namespace_b   = string
      strategy_type = string
    })), [])
    canary_strategy = optional(list(object({
      ingress_name  = string
      namespace     = string
      strategy_type = string
    })), [])
    container_config = optional(list(object({
      container_config_type = string
      shape_name            = string
      availability_domain   = optional(string)
      compartment_id        = optional(string)
      network_channel = optional(list(object({
        network_channel_type = string
        subnet_id            = string
        nsg_ids              = optional(list(string))
      })), [])
      shape_config = optional(list(object({
        ocpus         = number
        memory_in_gbs = optional(number)
      })), [])
    })), [])
    failure_policy = optional(list(object({
      policy_type        = string
      failure_count      = optional(number)
      failure_percentage = optional(number)
    })), [])
    green_backend_ips = optional(list(object({
      items = list(string)
    })), [])
    load_balancer_config = optional(list(object({
      backend_port     = number
      listener_name    = optional(string)
      load_balancer_id = optional(string)
    })), [])
    production_load_balancer_config = optional(list(object({
      backend_port     = optional(number)
      listener_name    = optional(string)
      load_balancer_id = optional(string)
    })), [])
    rollback_policy = optional(list(object({
      policy_type = string
    })), [])
    rollout_policy = optional(list(object({
      policy_type            = string
      batch_count            = number
      batch_delay_in_seconds = optional(number)
      batch_percentage       = optional(number)
      ramp_limit_percent     = optional(number)
    })), [])
    set_string = optional(list(object({
      items = optional(list(object({
        name  = optional(string)
        value = optional(string)
      })), [])
    })), [])
    set_values = optional(list(object({
      items = optional(list(object({
        name  = optional(string)
        value = optional(string)
      })), [])
    })), [])
    test_load_balancer_config = optional(list(object({
      backend_port     = optional(number)
      listener_name    = optional(string)
      load_balancer_id = optional(string)
    })), [])
    wait_criteria = optional(list(object({
      wait_duration = string
      wait_type     = string
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Deploy Stage resource in Oracle Cloud Infrastructure Devops service.
EOF
}

variable "deployment" {
  type = list(map(object({
    id                            = number
    deploy_pipeline_id            = number
    deployment_type               = string
    defined_tags                  = optional(map(string))
    deploy_stage_id               = optional(string)
    display_name                  = optional(string)
    freeform_tags                 = optional(map(string))
    previous_deployment_id        = optional(string)
    trigger_new_devops_deployment = optional(bool)
    deploy_artifact_override_arguments = optional(list(object({
      items = optional(list(object({
        deploy_artifact_id = optional(string)
        name               = optional(string)
        value              = optional(string)
      })), [])
    })), [])
    deploy_stage_override_arguments = optional(list(object({
      items = optional(list(object({
        deploy_artifact_id = optional(string)
        name               = optional(string)
        value              = optional(string)
      })), [])
    })), [])
    deployment_arguments = optional(list(object({
      items = optional(list(object({
        name  = optional(string)
        value = optional(string)
      })), [])
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Deployment resource in Oracle Cloud Infrastructure Devops service.
EOF
}

variable "project" {
  type = list(map(object({
    id            = number
    name          = string
    defined_tags  = optional(map(string))
    description   = optional(string)
    freeform_tags = optional(map(string))
    notification_config = optional(list(object({
      topic_id = string
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Project resource in Oracle Cloud Infrastructure Devops service.
EOF
}

variable "repository" {
  type = list(map(object({
    id              = number
    name            = string
    project_id      = number
    repository_type = string
    default_branch  = optional(string)
    defined_tags    = optional(map(string))
    freeform_tags   = optional(map(string))
    mirror_repository_config = optional(list(object({
      connector_id   = string
      repository_url = optional(string)
      trigger_schedule = optional(list(object({
        schedule_type   = string
        custom_schedule = optional(string)
      })), [])
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Repository resource in Oracle Cloud Infrastructure Devops service.
EOF
}

variable "repository_mirror" {
  type = list(map(object({
    id            = number
    repository_id = number
  })))
  default     = []
  description = <<EOF
This resource provides the Repository Mirror resource in Oracle Cloud Infrastructure Devops service.
EOF
}

variable "repository_ref" {
  type = list(map(object({
    id            = number
    ref_name      = string
    ref_type      = string
    repository_id = number
    commit_id     = optional(string)
    object_id     = optional(string)
  })))
  default     = []
  description = <<EOF
This resource provides the Repository Ref resource in Oracle Cloud Infrastructure Devops service.
EOF
}

variable "trigger" {
  type = list(map(object({
    id             = number
    project_id     = string
    trigger_source = string
    connection_id  = optional(string)
    defined_tags   = optional(map(string))
    description    = optional(string)
    display_name   = optional(string)
    freeform_tags  = optional(map(string))
    repository_id  = optional(number)
    actions = list(object({
      build_pipeline_id = string
      type              = string
      filter = optional(list(object({
        trigger_source = string
        events         = optional(list(string))
        exclude = optional(list(object({
          file_filter = optional(list(object({
            file_paths = list(string)
          })), [])
        })), [])
        include = optional(list(object({
          base_ref        = optional(string)
          head_ref        = optional(string)
          repository_name = optional(string)
          file_filter = optional(list(object({
            file_paths = list(string)
          })), [])
        })), [])
      })), [])
    }))
  })))
  default     = []
  description = <<EOF
This resource provides the Trigger resource in Oracle Cloud Infrastructure Devops service.
EOF
}