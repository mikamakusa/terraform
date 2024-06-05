variable "nomad_plugin" {
  type    = string
  default = null
}

variable "acl_auth_method" {
  type = list(object({
    id             = number
    max_token_ttl  = string
    name           = string
    token_locality = string
    type           = string
    default        = optional(bool)
    config = optional(list(object({
      allowed_redirect_uris = list(string)
      oidc_client_id        = string
      oidc_client_secret    = string
      oidc_discovery_url    = string
      oidc_scopes           = optional(list(string))
      bound_audiences       = optional(list(string))
      signing_algs          = optional(list(string))
      discovery_ca_pem      = optional(list(string))
      claim_mappings        = optional(map(string))
      list_claim_mappings   = optional(map(string))
    })), [])
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
name (string: <required>) - The identifier of the ACL Auth Method.
type (string: <required>) - ACL Auth Method SSO workflow type. Valid values, are OIDC and JWT.
token_locality (string: <required>) - Defines whether the ACL Auth Method creates a local or global token when performing SSO login. This field must be set to either local or global.
max_token_ttl (string: <required>) - Defines the maximum life of a token created by this method and is specified as a time duration such as "15h".
token_name_format (string:) - Defines the token name format for the generated tokens.
default (bool: false) - Defines whether this ACL Auth Method is to be set as default.
config: (block: <required>) - Configuration specific to the auth method provider.
jwt_validation_pub_keys: ([]string: <optional>) - List of PEM-encoded public keys to use to authenticate signatures locally.
jwks_url: (string: <optional>) - JSON Web Key Sets url for authenticating signatures.
jwks_ca_cert: (string: <optional>) - PEM encoded CA cert for use by the TLS client used to talk with the JWKS server.
oidc_discovery_url: (string: <optional>) - The OIDC Discovery URL, without any .well-known component (base path).
oidc_client_id: (string: <optional>) - The OAuth Client ID configured with the OIDC provider.
oidc_client_secret: (string: <optional>) - The OAuth Client Secret configured with the OIDC provider.
oidc_scopes: ([]string: <optional>) - List of OIDC scopes.
oidc_disable_userinfo: (bool: false) - When set to true, Nomad will not make a request to the identity provider to get OIDC UserInfo. You may wish to set this if your identity provider doesn't send any additional claims from the UserInfo endpoint.
bound_audiences: ([]string: <optional>) - List of auth claims that are valid for login.
bound_issuer: ([]string: <optional>) - The value against which to match the iss claim in a JWT.
allowed_redirect_uris: ([]string: <optional>) - A list of allowed values that can be used for the redirect URI.
discovery_ca_pem: ([]string: <optional>) - PEM encoded CA certs for use by the TLS client used to talk with the OIDC Discovery URL.
signing_algs: ([]string: <optional>) - A list of supported signing algorithms.
expiration_leeway: (string: <optional>) - Duration of leeway when validating expiration of a JWT in the form of a time duration such as "5m" or "1h".
not_before_leeway: (string: <optional>) - Duration of leeway when validating not before values of a token in the form of a time duration such as "5m" or "1h".
clock_skew_leeway: (string: <optional>) - Duration of leeway when validating all claims in the form of a time duration such as "5m" or "1h".
claim_mappings: (map[string]string: <optional>) - Mappings of claims (key) that will be copied to a metadata field (value).
list_claim_mappings: (map[string]string: <optional>) - Mappings of list claims (key) that will be copied to a metadata field (value).
  EOF
}

variable "acl_binding_rule" {
  type = list(object({
    id             = number
    auth_method_id = number
    bind_type      = string
    description    = optional(string)
    selector       = optional(string)
    bind_name      = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
description (string: "") - Description for this ACL binding rule.
auth_method (string: <required>) - Name of the auth method for which this rule applies to.
selector (string: "") - A boolean expression that matches against verified identity attributes returned from the auth method during login.
bind_type (string: <required>) - Adjusts how this binding rule is applied at login time. Valid values are role, policy, and management.
bind_name (string: <optional>) - Target of the binding. If bind_type is role or policy then bind_name is required. If bind_type is management than bind_name must not be defined.
  EOF
}

variable "acl_policy" {
  type = list(object({
    id          = number
    name        = string
    rules_hcl   = string
    description = optional(string)
    job_acl = optional(list(object({
      job_id       = number
      namespace_id = optional(number)
      group        = optional(string)
      task         = optional(string)
    })), [])
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
name (string: <required>) - A unique name for the policy.
rules_hcl (string: <required>) - The contents of the policy to register, as HCL or JSON.
description (string: "") - A description of the policy.
job_acl: (JobACL: <optional>) - Options for assigning the ACL rules to a job, group, or task.
  EOF
}

variable "acl_role" {
  type = list(object({
    id          = number
    name        = string
    description = optional(string)
    policy = list(object({
      policy_id = number
    }))
  }))
  default     = []
  description = <<EOF
  The following arguments are supported:
name (string: <required>) - A human-friendly name for this ACL Role.
description (string: "") - A description of the ACL Role.
policy (set: <required>) - A set of policy names to associate with this ACL Role. It may be used multiple times.
  EOF
}

variable "acl_token" {
  type = list(object({
    id             = number
    type           = string
    name           = optional(string)
    policies       = optional(list(string))
    global         = optional(bool)
    expiration_ttl = optional(string)
    role = optional(list(object({
      id = number
    })))
  }))
  default     = []
  description = <<EOF
  The following arguments are supported:
type (string: <required>) - The type of token this is. Use client for tokens that will have policies associated with them. Use management for tokens that can perform any action.
name (string: "") - A human-friendly name for this token.
policies (set: []) - A set of policy names to associate with this token. Must be set on client-type tokens, must not be set on management-type tokens. Policies do not need to exist before being used here.
role (set: []) - The list of roles attached to the token. Each entry has name and id attributes. It may be used multiple times.
global (bool: false) - Whether the token should be replicated to all regions, or if it will only be used in the region it was created in.
expiration_ttl (string: "") - Provides a TTL for the token in the form of a time duration such as "5m" or "1h".
In addition to the above arguments, the following attributes are exported and can be referenced:
accessor_id (string) - A non-sensitive identifier for this token that can be logged and shared safely without granting any access to the cluster.
secret_id (string) - The token value itself, which is presented for access to the cluster.
create_time (string) - The timestamp the token was created.
expiration_time (string) - The timestamp after which the token is considered expired and eligible for destruction.
  EOF
}

variable "csi_volume" {
  type = list(object({
    id           = number
    name         = string
    volume_id    = string
    namespace_id = optional(number)
    snapshot_id  = optional(string)
    clone_id     = optional(string)
    capacity_min = optional(string)
    capacity_max = optional(string)
    secrets      = optional(map(string))
    parameters   = optional(map(string))
    capability = optional(list(object({
      access_mode     = string
      attachment_mode = string
    })), [])
    mount_options = optional(list(object({
      fs_type     = optional(string)
      mount_flags = optional(list(string))
    })), [])
    topology_request = optional(list(object({
      required = optional(list(object({
        topology = optional(list(object({
          segments = map(string)
        })), [])
      })), [])
      preferred = optional(list(object({
        topology = optional(list(object({
          segments = map(string)
        })), [])
      })), [])
    })), [])
  }))
  default     = []
  description = <<EOF
  The following arguments are supported:
namespace: (string: "default") - The namespace in which to register the volume.
volume_id: (string: <required>) - The unique ID of the volume.
name: (string: <required>) - The display name for the volume.
plugin_id: (string: <required>) - The ID of the Nomad plugin for registering this volume.
snapshot_id: (string: <optional>) - The external ID of a snapshot to restore. If ommited, the volume will be created from scratch. Conflicts with clone_id.
clone_id: (string: <optional>) - The external ID of an existing volume to restore. If ommited, the volume will be created from scratch. Conflicts with snapshot_id.
capacity_min: (string: <optional>) - Option to signal a minimum volume size. This may not be supported by all storage providers.
capacity_max: (string: <optional>) - Option to signal a maximum volume size. This may not be supported by all storage providers.
capability: (Capability: <required>) - Options for validating the capability of a volume.
topology_request: (TopologyRequest: <optional>) - Specify locations (region, zone, rack, etc.) where the provisioned volume is accessible from.
mount_options: (block: optional) Options for mounting block-device volumes without a pre-formatted file system.
fs_type: (string: optional) - The file system type.
mount_flags: []string: optional - The flags passed to mount.
secrets: (map[string]string: optional) An optional key-value map of strings used as credentials for publishing and unpublishing volumes.
parameters: (map[string]string: optional) An optional key-value map of strings passed directly to the CSI plugin to configure the volume.

Capability
access_mode: (string: <required>) - Defines whether a volume should be available concurrently. Possible values are:
single-node-reader-only
single-node-writer
multi-node-reader-only
multi-node-single-writer
multi-node-multi-writer
attachment_mode: (string: <required>) - The storage API that will be used by the volume. Possible values are:
block-device
file-system

Topology Request
required: (Topology: <optional>) - Required topologies indicate that the volume must be created in a location accessible from all the listed topologies.
preferred: (Topology: <optional>) - Preferred topologies indicate that the volume should be created in a location accessible from some of the listed topologies.
Topology
topology: (List of segments: <required>) - Defines the location for the volume.
segments: (map[string]string) - Define the attributes for the topology request.
  EOF
}

variable "csi_volume_registration" {
  type = list(object({
    id                    = number
    external_id           = string
    name                  = string
    volume_id             = number
    namespace_id          = optional(number)
    capacity_min          = optional(string)
    capacity_max          = optional(string)
    secrets               = optional(map(string))
    parameters            = optional(map(string))
    context               = optional(map(string))
    deregister_on_destroy = optional(bool)
    capability = optional(list(object({
      access_mode     = string
      attachment_mode = string
    })), [])
    mount_options = optional(list(object({
      fs_type     = optional(string)
      mount_flags = optional(list(string))
    })), [])
    topology_request = optional(list(object({
      required = optional(list(object({
        topology = optional(list(object({
          segments = map(string)
        })), [])
      })), [])
      preferred = optional(list(object({
        topology = optional(list(object({
          segments = map(string)
        })), [])
      })), [])
    })), [])
  }))
  default     = []
  description = <<EOF
  The following arguments are supported:
namespace: (string: "default") - The namespace in which to register the volume.
volume_id: (string: <required>) - The unique ID of the volume.
name: (string: <required>) - The display name for the volume.
plugin_id: (string: <required>) - The ID of the Nomad plugin for registering this volume.
external_id: (string: <required>) - The ID of the physical volume from the storage provider.
capacity_min: (string: <optional>) - Option to signal a minimum volume size. This may not be supported by all storage providers.
capacity_max: (string: <optional>) - Option to signal a maximum volume size. This may not be supported by all storage providers.
capability: (Capability: <required>) - Options for validating the capability of a volume.
topology_request: (TopologyRequest: <optional>) - Specify locations (region, zone, rack, etc.) where the provisioned volume is accessible from.
mount_options: (block: <optional>) Options for mounting block-device volumes without a pre-formatted file system.
fs_type: (string: <optional>) - The file system type.
mount_flags: ([]string: <optional>) - The flags passed to mount.
secrets: (map[string]string: <optional>) - An optional key-value map of strings used as credentials for publishing and unpublishing volumes.
parameters: (map[string]string: <optional>) - An optional key-value map of strings passed directly to the CSI plugin to configure the volume.
context: (map[string]string: <optional>) - An optional key-value map of strings passed directly to the CSI plugin to validate the volume.
deregister_on_destroy: (boolean: true) - If true, the volume will be deregistered on destroy.

Capability
access_mode: (string: <required>) - Defines whether a volume should be available concurrently. Possible values are:
single-node-reader-only
single-node-writer
multi-node-reader-only
multi-node-single-writer
multi-node-multi-writer
attachment_mode: (string: <required>) - The storage API that will be used by the volume. Possible values are:
block-device
file-system

Topology Request
required: (Topology: <optional>) - Required topologies indicate that the volume must be created in a location accessible from all the listed topologies.
Topology
topology: (List of segments: <required>) - Defines the location for the volume.
segments: (map[string]string) - Define the attributes for the topology request.
  EOF
}

variable "external_volume" {
  type = list(object({
    id           = number
    name         = string
    volume_id    = number
    namespace_id = optional(number)
    snapshot_id  = optional(string)
    clone_id     = optional(string)
    capacity_min = optional(string)
    capacity_max = optional(string)
    secrets      = optional(map(string))
    parameters   = optional(map(string))
    capability = optional(list(object({
      access_mode     = string
      attachment_mode = string
    })), [])
    mount_options = optional(list(object({
      fs_type     = optional(string)
      mount_flags = optional(list(string))
    })), [])
    topology_request = optional(list(object({
      required = optional(list(object({
        topology = optional(list(object({
          segments = map(string)
        })), [])
      })), [])
      preferred = optional(list(object({
        topology = optional(list(object({
          segments = map(string)
        })), [])
      })), [])
    })), [])
  }))
  default     = []
  description = <<EOF
  The following arguments are supported:
type: (string: <required>) - The type of the volume. Currently, only csi is supported.
namespace: (string: "default") - The namespace in which to register the volume.
volume_id: (string: <required>) - The unique ID of the volume.
name: (string: <required>) - The display name for the volume.
plugin_id: (string: <required>) - The ID of the Nomad plugin for registering this volume.
snapshot_id: (string: <optional>) - The external ID of a snapshot to restore. If ommited, the volume will be created from scratch. Conflicts with clone_id.
clone_id: (string: <optional>) - The external ID of an existing volume to restore. If ommited, the volume will be created from scratch. Conflicts with snapshot_id.
capacity_min: (string: <optional>) - Option to signal a minimum volume size. This may not be supported by all storage providers.
capacity_max: (string: <optional>) - Option to signal a maximum volume size. This may not be supported by all storage providers.
capability: (Capability: <required>) - Options for validating the capability of a volume.
topology_request: (TopologyRequest: <optional>) - Specify locations (region, zone, rack, etc.) where the provisioned volume is accessible from.
mount_options: (block: optional) Options for mounting block-device volumes without a pre-formatted file system.
fs_type: (string: optional) - The file system type.
mount_flags: []string: optional - The flags passed to mount.
secrets: (map[string]string: optional) An optional key-value map of strings used as credentials for publishing and unpublishing volumes.
parameters: (map[string]string: optional) An optional key-value map of strings passed directly to the CSI plugin to configure the volume.

Capability
access_mode: (string: <required>) - Defines whether a volume should be available concurrently. Possible values are:
single-node-reader-only
single-node-writer
multi-node-reader-only
multi-node-single-writer
multi-node-multi-writer
attachment_mode: (string: <required>) - The storage API that will be used by the volume. Possible values are:
block-device
file-system

Topology Request
required: (Topology: <optional>) - Required topologies indicate that the volume must be created in a location accessible from all the listed topologies.
preferred: (Topology: <optional>) - Preferred topologies indicate that the volume should be created in a location accessible from some of the listed topologies.
Topology
topology: (List of segments: <required>) - Defines the location for the volume.
segments: (map[string]string) - Define the attributes for the topology request.
  EOF
}

variable "job" {
  type = list(object({
    id                      = number
    jobspec                 = string
    consul_token            = optional(string)
    deregister_on_destroy   = optional(bool)
    deregister_on_id_change = optional(bool)
    detach                  = optional(bool)
    hcl1                    = optional(bool)
    json                    = optional(bool)
    policy_override         = optional(bool)
    purge_on_destroy        = optional(bool)
    vault_token             = optional(string)
    hcl2 = optional(list(object({
      allow_fs = optional(bool)
      vars     = optional(map(string))
    })))
  }))
  default     = []
  description = <<EOF
  The following arguments are supported:
jobspec (string: <required>) - The contents of the jobspec to register.
deregister_on_destroy (boolean: true) - Determines if the job will be deregistered when this resource is destroyed in Terraform.
purge_on_destroy (boolean: false) - Set this to true if you want the job to be purged when the resource is destroyed.
deregister_on_id_change (boolean: true) - Determines if the job will be deregistered if the ID of the job in the jobspec changes.
rerun_if_dead (boolean: false) - Set this to true to force the job to run again if its status is dead.
detach (boolean: true) - If true, the provider will return immediately after creating or updating, instead of monitoring.
policy_override (boolean: false) - Determines if the job will override any soft-mandatory Sentinel policies and register even if they fail.
json (boolean: false) - Set this to true if your jobspec is structured with JSON instead of the default HCL.
hcl1 (boolean: false) - Set this to true to use the previous HCL1 parser. This option is provided for backwards compatibility only and should not be used unless absolutely necessary.
hcl2 (block: optional) - Options for the HCL2 jobspec parser.
enabled (boolean: false) - Deprecated All HCL jobs are parsed as HCL2 by default.
allow_fs (boolean: false) - Set this to true to be able to use HCL2 filesystem functions
consul_token (string: <optional>) - Consul token used when registering this job. Will fallback to the value declared in Nomad provider configuration, if any.
vault_token (string: <optional>) - Vault token used when registering this job. Will fallback to the value declared in Nomad provider configuration, if any.
  EOF
}

variable "namespace" {
  type = list(object({
    id          = number
    name        = string
    description = optional(string)
    quota_id    = optional(number)
    meta        = optional(map(string))
    capabilities = optional(list(object({
      enabled_task_drivers  = optional(list(string))
      disabled_task_drivers = optional(list(string))
    })), [])
    node_pool_config = optional(list(object({
      default = optional(string)
      allowed = optional(list(string))
      denied  = optional(list(string))
    })), [])
  }))
  default     = []
  description = <<EOF
  The following arguments are supported:

name (string: <required>) - A unique name for the namespace.
description (string: "") - A description of the namespace.
quota (string: "") - A resource quota to attach to the namespace.
meta (map[string]string: <optional>) - Specifies arbitrary KV metadata to associate with the namespace.
capabilities (block: <optional>) - A block of capabilities for the namespace. Can't be repeated. See below for the structure of this block.
node_pool_config (block: <optional>) - A block with node pool configuration for the namespace (Nomad Enterprise only).

capabilities blocks
The capabilities block describes the capabilities of the namespace. It supports the following arguments:
enabled_task_drivers ([]string: <optional>) - Task drivers enabled for the namespace.
disabled_task_drivers ([]string: <optional>) - Task drivers disabled for the namespace.

node_pool_config blocks
The node_pool_config block describes the node pool configuration for the namespace.
default (string: <optional>) - The default node pool for jobs that don't define one.
allowed ([]string: <optional>) - The list of node pools that are allowed to be used in this namespace.
denied ([]string: <optional>) - The list of node pools that are not allowed to be used in this namespace.
  EOF
}

variable "node_pool" {
  type = list(object({
    id          = number
    name        = string
    description = optional(string)
    meta        = optional(map(string))
    scheduler_config = optional(list(object({
      scheduler_algorithm     = optional(string)
      memory_oversubscription = optional(string)
    })), [])
  }))
  default     = []
  description = <<EOF
  The following arguments are supported:
name (string) - The name of the node pool.
description (string) - The description of the node pool.
meta (map[string]string) - Arbitrary KV metadata associated with the node pool.
scheduler_config (block) - Scheduler configuration for the node pool.
scheduler_algorithm (string) - The scheduler algorithm used in the node pool. Possible values are binpack or spread. If not defined the global cluster configuration is used.
memory_oversubscription (string) - Whether or not memory oversubscription is enabled in the node pool. Possible values are "enabled" or "disabled". If not defined the global cluster configuration is used.
  EOF
}

variable "quota_specification" {
  type = list(object({
    id          = number
    name        = string
    description = optional(string)
    limits = list(object({
      region = string
      region_limit = list(object({
        cpu       = optional(number)
        memory_mb = optional(number)
      }))
    }))
  }))
  default     = []
  description = <<EOF
  The following arguments are supported:
name (string: <required>) - A unique name for the quota specification.
description (string: "") - A description of the quota specification.
limits (block: <required>) - A block of quota limits to enforce. Can be repeated. See below for the structure of this block.

limits blocks
The limits block describes the quota limits to be enforced. It supports the following arguments:
region (string: <required>) - The region these limits should apply to.
region_limit (block: <required>) - The limits to enforce. This block may only be specified once in the limits block. Its structure is documented below.
region_limit blocks

The region_limit block describes the quota limits to be enforced on a region. It supports the following arguments:
cpu (int: 0) - The amount of CPU to limit allocations to. A value of zero is treated as unlimited, and a negative value is treated as fully disallowed.
memory_mb (int: 0) - The amount of memory (in megabytes) to limit allocations to. A value of zero is treated as unlimited, and a negative value is treated as fully disallowed.
  EOF
}

variable "scheduler_config" {
  type = list(object({
    id                              = number
    scheduler_algorithm             = optional(bool)
    memory_oversubscription_enabled = optional(string)
    preemption_config               = optional(map(string))
  }))
  default     = []
  description = <<EOF
  The following arguments are supported:
memory_oversubscription_enabled (bool: false) - When true, tasks may exceed their reserved memory limit.
scheduler_algorithm (string: "binpack") - Specifies whether scheduler binpacks or spreads allocations on available nodes. Possible values are binpack and spread.
preemption_config (map[string]bool) - Options to enable preemption for various schedulers.
system_scheduler_enabled (bool: true) - Specifies whether preemption for system jobs is enabled. Note that if this is set to true, then system jobs can preempt any other jobs.
batch_scheduler_enabled (bool: false") - Specifies whether preemption for batch jobs is enabled. Note that if this is set to true, then batch jobs can preempt any other jobs.
service_scheduler_enabled (bool: false) - Specifies whether preemption for service jobs is enabled. Note that if this is set to true, then service jobs can preempt any other jobs.
sysbatch_scheduler_enabled (bool: false) - Specifies whether preemption for sysbatch (system batch) jobs is enabled. Note that if this is set to true, then system batch jobs can preempt any other jobs.
  EOF
}

variable "sentinel_policy" {
  type = list(object({
    id                = number
    enforcement_level = string
    name              = string
    policy            = string
    scope             = string
    description       = optional(string)
  }))
  default     = []
  description = <<EOF
  The following arguments are supported:
name (string: <required>) - A unique name for the policy.
policy (string: <required>) - The contents of the policy to register.
enforcement_level (strings: <required>) - The enforcement level for this policy.
scope (strings: <required>) - The scope for this policy.
description (string: "") - A description of the policy.
  EOF
}

variable "variable" {
  type = list(object({
    id            = number
    items         = map(string)
    path          = string
    namespace_id  = optional(number)
  }))
  default     = []
  description = <<EOF
path (string: <required>) - A unique path to create the variable at.
namespace (string: "default") - The namepsace to create the variable in.
items (map[string]string: <required>) - An arbitrary map of items to create in the variable.
  EOF
}

variable "volume" {
  type = list(object({
    id                    = number
    external_id           = string
    name                  = string
    volume_id             = string
    namespace_id          = optional(number)
    secrets               = optional(map(string))
    parameters            = optional(map(string))
    context               = optional(map(string))
    deregister_on_destroy = optional(bool)
    capability            = optional(list(object({
      access_mode = string
      attachment_mode = string
    })), [])
    topology_request      = optional(list(object({
      required = optional(list(object({
        topology = optional(list(object({
          segments = optional(map(string))
        })), [])
      })), [])
    })), [])
    mount_options         = optional(list(object({
      fs_type     = optional(string)
      mount_flags = optional(string)
    })), [])
  }))
  default     = []
  description = <<EOF
  The following arguments are supported:

type: (string: <required>) - The type of the volume. Currently, only csi is supported.
namespace: (string: "default") - The namespace in which to register the volume.
volume_id: (string: <required>) - The unique ID of the volume.
name: (string: <required>) - The display name for the volume.
plugin_id: (string: <required>) - The ID of the Nomad plugin for registering this volume.
external_id: (string: <required>) - The ID of the physical volume from the storage provider.
capability: (Capability: <required>) - Options for validating the capability of a volume.
topology_request: (TopologyRequest: <optional>) - Specify locations (region, zone, rack, etc.) where the provisioned volume is accessible from.
mount_options: (block: <optional>) Options for mounting block-device volumes without a pre-formatted file system.
fs_type: (string: <optional>) - The file system type.
mount_flags: ([]string: <optional>) - The flags passed to mount.
secrets: (map[string]string: <optional>) - An optional key-value map of strings used as credentials for publishing and unpublishing volumes.
parameters: (map[string]string: <optional>) - An optional key-value map of strings passed directly to the CSI plugin to configure the volume.
context: (map[string]string: <optional>) - An optional key-value map of strings passed directly to the CSI plugin to validate the volume.
deregister_on_destroy: (boolean: true) - If true, the volume will be deregistered on destroy.
access_mode: (string: <optional>) - Deprecated. Use capability block instead. Defines whether a volume should be available concurrently. Possible values are:
single-node-reader-only
single-node-writer
multi-node-reader-only
multi-node-single-writer
multi-node-multi-writer
attachment_mode: (string: <otional>) - Deprecated. Use capability block instead. The storage API that will be used by the volume.

Capability
access_mode: (string: <required>) - Defines whether a volume should be available concurrently. Possible values are:
single-node-reader-only
single-node-writer
multi-node-reader-only
multi-node-single-writer
multi-node-multi-writer
attachment_mode: (string: <required>) - The storage API that will be used by the volume. Possible values are:
block-device
file-system

Topology Request
required: (Topology: <optional>) - Required topologies indicate that the volume must be created in a location accessible from all the listed topologies.
Topology
topology: (List of segments: <required>) - Defines the location for the volume.
segments: (map[string]string) - Define the attributes for the topology request.
  EOF
}
