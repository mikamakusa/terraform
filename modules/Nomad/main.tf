resource "nomad_acl_auth_method" "this" {
  count          = length(var.acl_auth_method)
  max_token_ttl  = lookup(var.acl_auth_method[count.index], "max_token_ttl")
  name           = lookup(var.acl_auth_method[count.index], "name")
  token_locality = lookup(var.acl_auth_method[count.index], "token_locality")
  type           = lookup(var.acl_auth_method[count.index], "type")
  default        = lookup(var.acl_auth_method[count.index], "default")

  dynamic "config" {
    for_each = try(lookup(var.acl_auth_method[count.index], "config")) == null ? [] : ["config"]
    content {
      allowed_redirect_uris = lookup(config.value, "allowed_redirect_uris")
      oidc_client_id        = lookup(config.value, "oidc_client_id")
      oidc_client_secret    = lookup(config.value, "oidc_client_secret")
      oidc_discovery_url    = lookup(config.value, "oidc_discovery_url")
      oidc_scopes           = lookup(config.value, "oidc_scopes")
      bound_audiences       = lookup(config.value, "bound_audiences")
      signing_algs          = lookup(config.value, "signing_algs")
      discovery_ca_pem      = lookup(config.value, "discovery_ca_pem")
      claim_mappings        = lookup(config.value, "claim_mappings")
      list_claim_mappings   = lookup(config.value, "list_claim_mappings")
    }
  }
}

resource "nomad_acl_binding_rule" "this" {
  count       = length(var.acl_binding_rule) == "0" ? "0" : length(var.acl_auth_method)
  auth_method = try(element(nomad_acl_auth_method.this.*.name, lookup(var.acl_binding_rule[count.index], "auth_method_id")))
  bind_type   = lookup(var.acl_binding_rule[count.index], "bind_type")
  description = lookup(var.acl_binding_rule[count.index], "description")
  selector    = lookup(var.acl_binding_rule[count.index], "selector")
  bind_name   = lookup(var.acl_binding_rule[count.index], "bind_name")
}

resource "nomad_acl_policy" "this" {
  count       = length(var.acl_policy)
  name        = lookup(var.acl_policy[count.index], "name")
  rules_hcl   = file(join("/", [path.cwd, "rules", lookup(var.acl_policy[count.index], "rules_hcl")]))
  description = lookup(var.acl_policy[count.index], "description")

  dynamic "job_acl" {
    for_each = try(lookup(var.acl_policy[count.index], "job_acl")) == null ? [] : ["job_acl"]
    content {
      job_id    = try(element(nomad_job.this.*.id, lookup(job_acl.value, "job_id")))
      namespace = try(element(nomad_namespace.this.*.id, lookup(job_acl.value, "namespace_id")))
      group     = lookup(job_acl.value, "group")
      task      = lookup(job_acl.value, "task")
    }
  }
}

resource "nomad_acl_role" "this" {
  count       = length(var.acl_role)
  name        = lookup(var.acl_role[count.index], "name")
  description = lookup(var.acl_role[count.index], "description")

  dynamic "policy" {
    for_each = lookup(var.acl_role[count.index], "policy")
    content {
      name = try(element(nomad_acl_policy.this.*.name, lookup(policy.value, "policy_id")))
    }
  }
}

resource "nomad_acl_token" "this" {
  count          = length(var.acl_token)
  type           = lookup(var.acl_token[count.index], "type")
  name           = lookup(var.acl_token[count.index], "name")
  policies       = lookup(var.acl_token[count.index], "policies")
  global         = lookup(var.acl_token[count.index], "global")
  expiration_ttl = lookup(var.acl_token[count.index], "expiration_ttl")

  dynamic "role" {
    for_each = try(lookup(var.acl_token[count.index], "role")) == null ? [] : ["role"]
    content {
      id = try(element(nomad_acl_role.this.*.id, lookup(role.value, "id")))
    }
  }
}

resource "nomad_csi_volume" "this" {
  count        = length(var.csi_volume)
  name         = lookup(var.csi_volume[count.index], "name")
  plugin_id    = data.nomad_plugin.this.id
  volume_id    = lookup(var.csi_volume[count.index], "volume_id")
  namespace    = try(element(nomad_namespace.this.*.id, lookup(var.csi_volume[count.index], "namespace_id")))
  snapshot_id  = lookup(var.csi_volume[count.index], "snapshot_id")
  clone_id     = lookup(var.csi_volume[count.index], "clone_id")
  capacity_min = lookup(var.csi_volume[count.index], "capacity_min")
  capacity_max = lookup(var.csi_volume[count.index], "capacity_max")
  secrets      = sensitive(lookup(var.csi_volume[count.index], "secrets"))
  parameters   = lookup(var.csi_volume[count.index], "parameters")

  dynamic "capability" {
    for_each = try(lookup(var.csi_volume[count.index], "capability")) == null ? [] : ["capability"]
    content {
      access_mode     = lookup(capability.value, "access_mode")
      attachment_mode = lookup(capability.value, "attachment_mode")
    }
  }

  dynamic "mount_options" {
    for_each = try(lookup(var.csi_volume[count.index], "mount_options")) == null ? [] : ["mount_options"]
    content {
      fs_type     = lookup(mount_options.value, "fs_type")
      mount_flags = lookup(mount_options.value, "mount_flags")
    }
  }

  dynamic "topology_request" {
    for_each = try(lookup(var.csi_volume[count.index], "topology_request")) == null ? [] : ["topology_request"]
    content {
      dynamic "required" {
        for_each = try(lookup(topology_request.value, "required")) == null ? [] : ["required"]
        content {
          dynamic "topology" {
            for_each = try(lookup(required.value, "topology")) == null ? [] : ["topology"]
            content {
              segments = lookup(topology.value, "segments")
            }
          }
        }
      }
      dynamic "preferred" {
        for_each = try(lookup(topology_request.value, "preferred")) == null ? [] : ["preferred"]
        content {
          dynamic "topology" {
            for_each = try(lookup(preferred.value, "topology")) == null ? [] : ["topology"]
            content {
              segments = lookup(topology.value, "segments")
            }
          }
        }
      }
    }
  }
}

resource "nomad_csi_volume_registration" "this" {
  count                 = length(var.csi_volume_registration) == "0" ? "0" : length(var.csi_volume)
  external_id           = lookup(var.csi_volume_registration[count.index], "external_id")
  name                  = lookup(var.csi_volume_registration[count.index], "name")
  plugin_id             = data.nomad_plugin.this.id
  volume_id             = try(element(nomad_csi_volume.this.*.id, lookup(var.csi_volume_registration[count.index], "volume_id")))
  namespace             = try(element(nomad_namespace.this.*.id, lookup(var.csi_volume_registration[count.index], "namespace_id")))
  capacity_min          = lookup(var.csi_volume_registration[count.index], "capacity_min")
  capacity_max          = lookup(var.csi_volume_registration[count.index], "capacity_max")
  secrets               = sensitive(lookup(var.csi_volume_registration[count.index], "secrets"))
  parameters            = lookup(var.csi_volume_registration[count.index], "parameters")
  context               = lookup(var.csi_volume_registration[count.index], "context")
  deregister_on_destroy = lookup(var.csi_volume_registration[count.index], "deregister_on_destroy")

  dynamic "capability" {
    for_each = try(lookup(var.csi_volume_registration[count.index], "capability")) == null ? [] : ["capability"]
    content {
      access_mode     = lookup(capability.value, "access_mode")
      attachment_mode = lookup(capability.value, "attachment_mode")
    }
  }

  dynamic "mount_options" {
    for_each = try(lookup(var.csi_volume_registration[count.index], "mount_options")) == null ? [] : ["mount_options"]
    content {
      fs_type     = lookup(mount_options.value, "fs_type")
      mount_flags = lookup(mount_options.value, "mount_flags")
    }
  }

  dynamic "topology_request" {
    for_each = try(lookup(var.csi_volume_registration[count.index], "topology_request")) == null ? [] : ["topology_request"]
    content {
      dynamic "required" {
        for_each = try(lookup(topology_request.value, "required")) == null ? [] : ["required"]
        content {
          dynamic "topology" {
            for_each = try(lookup(required.value, "topology")) == null ? [] : ["topology"]
            content {
              segments = lookup(topology.value, "segments")
            }
          }
        }
      }
      dynamic "preferred" {
        for_each = try(lookup(topology_request.value, "preferred")) == null ? [] : ["preferred"]
        content {
          dynamic "topology" {
            for_each = try(lookup(preferred.value, "topology")) == null ? [] : ["topology"]
            content {
              segments = lookup(topology.value, "segments")
            }
          }
        }
      }
    }
  }
}

resource "nomad_external_volume" "this" {
  count        = length(var.external_volume) == "0" ? "0" : length(var.csi_volume)
  name         = lookup(var.external_volume[count.index], "name")
  plugin_id    = data.nomad_plugin.this.id
  volume_id    = try(element(nomad_csi_volume.this.*.id, "volume_id"))
  type         = lookup(var.external_volume[count.index], "type")
  namespace    = try(element(nomad_namespace.this.*.id, lookup(var.external_volume[count.index], "namespace_id")))
  capacity_max = lookup(var.external_volume[count.index], "capacity_max")
  capacity_min = lookup(var.external_volume[count.index], "capacity_min")
  clone_id     = lookup(var.external_volume[count.index], "clone_id")
  snapshot_id  = lookup(var.external_volume[count.index], "snapshot_id")
  secrets      = sensitive(lookup(var.external_volume[count.index], "secrets"))
  parameters   = lookup(var.external_volume[count.index], "parameters")

  dynamic "capability" {
    for_each = try(lookup(var.external_volume[count.index], "capability")) == null ? [] : ["capability"]
    content {
      access_mode     = lookup(capability.value, "access_mode")
      attachment_mode = lookup(capability.value, "attachment_mode")
    }
  }

  dynamic "mount_options" {
    for_each = try(lookup(var.external_volume[count.index], "mount_options")) == null ? [] : ["mount_options"]
    content {
      fs_type     = lookup(mount_options.value, "fs_type")
      mount_flags = lookup(mount_options.value, "mount_flags")
    }
  }

  dynamic "topology_request" {
    for_each = try(lookup(var.external_volume[count.index], "topology_request")) == null ? [] : ["topology_request"]
    content {
      dynamic "required" {
        for_each = try(lookup(topology_request.value, "required")) == null ? [] : ["required"]
        content {
          dynamic "topology" {
            for_each = try(lookup(required.value, "topology")) == null ? [] : ["topology"]
            content {
              segments = lookup(topology.value, "segments")
            }
          }
        }
      }
      dynamic "preferred" {
        for_each = try(lookup(topology_request.value, "preferred")) == null ? [] : ["preferred"]
        content {
          dynamic "topology" {
            for_each = try(lookup(preferred.value, "topology")) == null ? [] : ["topology"]
            content {
              segments = lookup(topology.value, "segments")
            }
          }
        }
      }
    }
  }
}

resource "nomad_job" "this" {
  count                   = length(var.job)
  jobspec                 = file(join("/", [path.cwd, "jobs", lookup(var.job[count.index], "jobspec")]))
  consul_token            = sensitive(lookup(var.job[count.index], "consul_token"))
  deregister_on_destroy   = lookup(var.job[count.index], "deregister_on_destroy")
  deregister_on_id_change = lookup(var.job[count.index], "deregister_on_id_change")
  detach                  = lookup(var.job[count.index], "detach")
  hcl1                    = lookup(var.job[count.index], "hcl1")
  json                    = lookup(var.job[count.index], "json")
  policy_override         = lookup(var.job[count.index], "policy_override")
  purge_on_destroy        = lookup(var.job[count.index], "purge_on_destroy")
  vault_token             = sensitive(lookup(var.job[count.index], "vault_token"))

  dynamic "hcl2" {
    for_each = try(lookup(var.job[count.index], "hcl2")) == null ? [] : ["hcl2"]
    content {
      allow_fs = lookup(hcl2.value, "allow_fs")
      vars     = lookup(hcl2.value, "vars")
    }
  }
}

resource "nomad_namespace" "this" {
  count       = length(var.namespace)
  name        = lookup(var.namespace[count.index], "name")
  description = lookup(var.namespace[count.index], "description")
  quota       = try(element(nomad_quota_specification.this.*.name, lookup(var.namespace[count.index], "quota_id")))
  meta        = lookup(var.namespace[count.index], "meta")

  dynamic "capabilities" {
    for_each = try(lookup(var.namespace[count.index], "capabilities")) == null ? [] : ["capabilities"]
    content {
      enabled_task_drivers  = lookup(capabilities.value, "enabled_task_drivers")
      disabled_task_drivers = lookup(capabilities.value, "disabled_task_drivers")
    }
  }

  dynamic "node_pool_config" {
    for_each = try(lookup(var.namespace[count.index], "node_pool_config")) == null ? [] : ["node_pool_config"]
    content {
      default = lookup(node_pool_config.value, "default")
      allowed = lookup(node_pool_config.value, "allowed")
      denied  = lookup(node_pool_config.value, "denied")
    }
  }
}

resource "nomad_node_pool" "this" {
  count       = length(var.node_pool)
  name        = lookup(var.node_pool[count.index], "name")
  description = lookup(var.node_pool[count.index], "description")
  meta        = lookup(var.node_pool[count.index], "meta")

  dynamic "scheduler_config" {
    for_each = try(lookup(var.node_pool[count.index], "scheduler_config")) == null ? [] : ["scheduler_config"]
    content {
      scheduler_algorithm     = lookup(scheduler_config.value, "scheduler_algorithm")
      memory_oversubscription = lookup(scheduler_config.value, "memory_oversubscription")
    }
  }
}

resource "nomad_quota_specification" "this" {
  count       = length(var.quota_specification)
  name        = lookup(var.quota_specification[count.index], "name")
  description = lookup(var.quota_specification[count.index], "description")

  dynamic "limits" {
    for_each = lookup(var.quota_specification[count.index], "limits")
    content {
      region = lookup(limits.value, "region")
      dynamic "region_limit" {
        for_each = lookup(limits.value, "region_limit")
        content {
          cpu       = lookup(region_limit.value, "cpu")
          memory_mb = lookup(region_limit.value, "memory_mb")
        }
      }
    }
  }
}

resource "nomad_scheduler_config" "this" {
  count = length(var.scheduler_config)
}

resource "nomad_sentinel_policy" "this" {
  count             = length(var.sentinel_policy)
  enforcement_level = ""
  name              = ""
  policy            = ""
  scope             = ""
}

resource "nomad_variable" "this" {
  count = length(var.variable)
  items = {}
  path  = ""
}

resource "nomad_volume" "this" {
  count       = length(var.volume)
  external_id = ""
  name        = ""
  plugin_id   = ""
  volume_id   = ""
}