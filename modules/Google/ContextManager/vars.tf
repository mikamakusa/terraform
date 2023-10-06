variable "access_level" {
  type = object({
    name        = string
    parent      = string
    title       = string
    description = optional(string)
    basic       = optional(object({}))
    custom      = optional(object({}))
    basic = optional(object({
      combining_function = optional(string)
      conditions = optional(object({
        ip_subnetworks         = optional(list(string))
        required_access_levels = optional(list(string))
        members                = optional(string)
        negate                 = optional(bool)
        regions                = optional(list(string))
        device_policy = optional(object({
          require_screen_lock              = optional(bool)
          allowed_encryption_statuses      = optional(list(string))
          allowed_device_management_levels = optional(list(string))
          require_admin_approval           = optional(bool)
          require_corp_owned               = optional(bool)
          os_constraints = optional(object({
            minimum_version             = optional(string)
            os_type                     = optional(string)
            required_verified_chrome_os = optional(bool)
          }))
        }))
      }))
    }))
  })
  default     = null
  description = "An AccessLevel is a label that can be applied to requests to GCP Services, along with a list of requirements necessary for the label to be applied."
}

variable "access_policy" {
  type = object({
    parent = string
    title  = string
    scopes = optional(list(string))
  })
  default     = null
  description = "It's a container for AccessLevels and Service Perimeters. It's globally visibile within an organization, and the restrictions it specifies apply to all projects within an organization."
}

variable "members" {
  type    = list(string)
  default = []
}

variable "authorized_orgs_desc" {
  type = object({
    name                    = string
    authorization_direction = optional(string)
    asset_type              = optional(string)
    orgs                    = list(string)
  })
  default = null
  description = "An authorized organizations description describes a list of organizations that have been authorized to use certain asset data owned by different organizations at the enforcement points, or with certain asset (device, for example) have been authorized to access the resource in another organization at the enforcement points."
}

variable "user_access_binding" {
  type = object({
    group_key       = string
    organization_id = string
    access_levels   = list(string)
  })
  default = null
  description = "Restricts access to Cloud Console and Google Cloud APIs for a set of users."
}

variable "service_perimeter" {
  type = object({
    title                       = string
    parent                      = string
    name                        = string
    description                 = optional(string)
    perimeter_type              = optional(string)
    use_explicitly_dry_run_spec = optional(string)
    status = optional(object({
      resources           = optional(list(string))
      access_levels       = optional(list(string))
      restricted_services = optional(list(string))
      vpc_accessible_services = optional(object({
        enable_restrictions = optional(bool)
        allowed_services    = optional(list(string))
      }))
      ingress_policies = optional(object({
        ingress_from = optional(object({
          identity_type = optional(string)
          identities    = optional(list(string))
          sources = optional(object({
            access_level = optional(string)
            resource     = optional(string)
          }))
        }))
        ingress_to = optional(object({
          resources = list(string)
          operations = optional(object({
            service_name = optional(string)
            method_selectors = optional(object({
              method     = optional(string)
              permission = optional(string)
            }))
          }))
        }))
      }))
      egress_policies = optional(object({
        egress_from = optional(object({
          identity_type = optional(string)
          identities    = optional(list(string))
        }))
        egress_to = optional(object({
          external_resources = optional(list(string))
          resources          = optional(list(string))
          operations = optional(object({
            service_name = optional(string)
            method_selectors = optional(object({
              method     = optional(string)
              permission = optional(string)
            }))
          }))
        }))
      }))
    }))
  })
  default = null
  description = "Describe a set of GCP resources which can freely import and export data amongst themselves, but not export outside of the service perimeter."
}

variable "perimeter_resource" {
  type = object({
    resource       = string
    perimeter_name = string
  })
  default = null
  description = "Allows configuring a single GCP resource that should be inside a service perimeter"
}