variable "defined_tags" {
  type        = map(string)
  default     = {}
  description = "Defined tags"
}

variable "freeform_tags" {
  type        = map(string)
  default     = {}
  description = "Freeform tags"
}

variable "compartment_id" {
  type        = string
  description = "Compartment id - mandatory - to be used as data source"
}

variable "access_policy" {
  type = list(map(object({
    id            = number
    mesh_id       = number
    name          = string
    defined_tags  = optional(map(string))
    description   = optional(string)
    freeform_tags = optional(map(string))
    rules = list(object({
      action = string
      destination = list(object({
        type               = string
        hostnames          = optional(list(string))
        ingress_gateway_id = optional(string)
        ip_addresses       = optional(list(string))
        ports              = optional(list(string))
        protocol           = optional(string)
        virtual_service_id = optional(string)
      }))
      source = list(object({
        type               = string
        ingress_gateway_id = optional(string)
        ip_addresses       = optional(list(string))
        ports              = optional(list(string))
        protocol           = optional(string)
        virtual_service_id = optional(string)
      }))
    }))
  })))
  default     = []
  description = <<EOF
This resource provides the Access Policy resource in Oracle Cloud Infrastructure Service Mesh service.
  EOF
}

variable "ingress_gateway" {
  type = list(map(object({
    id            = number
    mesh_id       = number
    name          = string
    defined_tags  = optional(map(string))
    description   = optional(string)
    freeform_tags = optional(map(string))
    hosts = list(object({
      name      = string
      hostnames = optional(list(string))
      listeners = optional(list(object({
        port     = number
        protocol = optional(string)
        tls = optional(list(object({
          mode = string
          client_validation = optional(list(object({
            subject_alternate_names = optional(list(string))
            trusted_ca_bundle = optional(list(object({
              type         = string
              ca_bundle_id = optional(string)
              secret_name  = optional(string)
            })), [])
          })), [])
        })), [])
      })), [])
    }))
    access_logging = optional(list(object({
      is_enabled = optional(bool)
    })), [])
    mtls = optional(list(object({
      maximum_validity = optional(number)
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Ingress Gateway resource in Oracle Cloud Infrastructure Service Mesh service.
  EOF
}

variable "ingress_gateway_route_table" {
  type = list(map(object({
    id                 = number
    ingress_gateway_id = number
    name               = string
    defined_tags       = optional(map(string))
    description        = optional(string)
    freeform_tags      = optional(map(string))
    priority           = optional(number)
    route_rules = list(object({
      type                    = string
      is_grpc                 = optional(bool)
      is_host_rewrite_enabled = optional(bool)
      is_path_rewrite_enabled = optional(bool)
      path                    = optional(string)
      path_type               = optional(string)
      request_timeout_in_ms   = optional(string)
      destinations = list(object({
        virtual_service_id = string
        port               = optional(number)
        weight             = optional(number)
      }))
      ingress_gateway_host = optional(list(object({
        name = optional(string)
        port = optional(number)
      })), [])
    }))
  })))
  default     = []
  description = <<EOF
This resource provides the Ingress Gateway Route Table resource in Oracle Cloud Infrastructure Service Mesh service.
  EOF
}

variable "mesh" {
  type = list(map(object({
    id            = number
    display_name  = string
    defined_tags  = optional(map(string))
    description   = optional(string)
    freeform_tags = optional(map(string))
    certificate_authorities = list(object({
      id = string
    }))
    mtls = optional(list(object({
      minimum = string
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Mesh resource in Oracle Cloud Infrastructure Service Mesh service.
  EOF
}

variable "virtual_deployment" {
  type = list(map(object({
    id                 = number
    name               = string
    virtual_service_id = string
    defined_tags       = optional(map(string))
    description        = optional(string)
    freeform_tags      = optional(map(string))
    listeners = optional(list(object({
      port                  = number
      protocol              = string
      idle_timeout_in_ms    = optional(string)
      request_timeout_in_ms = optional(string)
    })), [])
    service_discovery = optional(list(object({
      type     = string
      hostname = optional(string)
    })), [])
    access_logging = optional(list(object({
      is_enabled = optional(bool)
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Virtual Deployment resource in Oracle Cloud Infrastructure Service Mesh service.
  EOF
}

variable "virtual_service" {
  type = list(map(object({
    id            = number
    mesh_id       = number
    name          = string
    defined_tags  = optional(map(string))
    description   = optional(string)
    freeform_tags = optional(map(string))
    hosts         = optional(string)
    default_routing_policy = optional(list(object({
      type = string
    })), [])
    mtls = optional(list(object({
      mode             = string
      maximum_validity = optional(number)
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Virtual Service resource in Oracle Cloud Infrastructure Service Mesh service.
  EOF
}

variable "virtual_service_route_table" {
  type = list(map(object({
    id                 = number
    name               = string
    virtual_service_id = number
    defined_tags       = optional(map(string))
    description        = optional(string)
    freeform_tags      = optional(map(string))
    priority           = optional(number)
    route_rules = list(object({
      type                    = string
      is_grpc                 = optional(bool)
      path                    = optional(string)
      path_type               = optional(string)
      request_timeout_in_ms   = optional(string)
      destinations = list(object({
        virtual_service_id = string
        port               = optional(number)
        weight             = optional(number)
      }))
    }))
  })))
  default     = []
  description = <<EOF
This resource provides the Virtual Service Route Table resource in Oracle Cloud Infrastructure Service Mesh service.
  EOF
}
