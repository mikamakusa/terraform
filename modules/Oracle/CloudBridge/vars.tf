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

variable "agent" {
  type = list(map(object({
    id             = number
    agent_type     = string
    agent_version  = string
    display_name   = string
    environment_id = number
    os_version     = string
    defined_tags   = optional(map(string))
    freeform_tags  = optional(map(string))
  })))
  default     = []
  description = <<EOF
This resource provides the Agent resource in Oracle Cloud Infrastructure Cloud Bridge service.
  EOF
}

variable "agent_dependency" {
  type = list(map(object({
    id                 = number
    bucket             = string
    dependency_name    = string
    display_name       = string
    namespace          = string
    object             = string
    defined_tags       = optional(map(string))
    freeform_tags      = optional(map(string))
    dependency_version = optional(string)
    description        = optional(string)
    system_tags        = optional(map(string))
  })))
  default     = []
  description = <<EOF
This resource provides the Agent Dependency resource in Oracle Cloud Infrastructure Cloud Bridge service.
  EOF
}

variable "agent_plugin" {
  type = list(map(object({
    id            = number
    agent_id      = number
    plugin_name   = string
    desired_state = optional(string)
  })))
  default     = []
  description = <<EOF
This resource provides the Agent Plugin resource in Oracle Cloud Infrastructure Cloud Bridge service.
  EOF
}

variable "asset" {
  type = list(map(object({
    id                 = number
    asset_type         = string
    external_asset_key = string
    inventory_id       = number
    source_key         = string
    asset_source_ids   = optional(list(string))
    defined_tags       = optional(map(string))
    freeform_tags      = optional(map(string))
    display_name       = optional(string)
    compute = optional(list(object({
      connected_networks         = optional(number)
      cores_count                = optional(number)
      cpu_model                  = optional(string)
      description                = optional(string)
      disks_count                = optional(number)
      dns_name                   = optional(string)
      firmware                   = optional(string)
      gpu_devices_count          = optional(number)
      guest_state                = optional(string)
      hardware_version           = optional(string)
      host_name                  = optional(string)
      is_pmem_enabled            = optional(bool)
      is_tpm_enabled             = optional(bool)
      latency_sensitivity        = optional(string)
      memory_in_mbs              = optional(string)
      nics_count                 = optional(number)
      operating_system           = optional(string)
      operating_system_version   = optional(string)
      pmem_in_mbs                = optional(string)
      power_state                = optional(string)
      primary_ip                 = optional(string)
      storage_provisioned_in_mbs = optional(string)
      threads_per_core_count     = optional(number)
      disks = optional(list(object({
        boot_order      = optional(number)
        location        = optional(string)
        name            = optional(string)
        persistent_mode = optional(string)
        size_in_mbs     = optional(string)
        uuid            = optional(string)
        uuid_lun        = optional(string)
      })), [])
      nvdimm_controller = optional(list(object({
        bus_number = optional(number)
        label      = optional(string)
      })), [])
      nvdimms = optional(list(object({
        controller_key = optional(number)
        label          = optional(string)
        unit_number    = optional(number)
      })), [])
      gpu_devices = optional(list(object({
        cores_count   = optional(number)
        description   = optional(string)
        manufacturer  = optional(string)
        memory_in_mbs = optional(string)
        name          = optional(string)
      })), [])
      nics = optional(list(object({
        ip_addresses     = optional(list(string))
        label            = optional(string)
        mac_address      = optional(string)
        mac_address_type = optional(string)
        network_name     = optional(string)
        switch_name      = optional(string)
      })), [])
      scsi_controller = optional(list(object({
        label       = optional(string)
        shared_bus  = optional(string)
        unit_number = optional(number)
      })), [])
    })), [])
    vm = optional(list(object({
      hypervisor_host    = optional(string)
      hypervisor_vendor  = optional(string)
      hypervisor_version = optional(string)
    })), [])
    vmware_vcenter = optional(list(object({
      data_center     = optional(string)
      vcenter_key     = optional(string)
      vcenter_version = optional(string)
    })), [])
    vmware_vm = optional(list(object({
      cluster                           = optional(string)
      customer_fields                   = optional(list(string))
      fault_tolerance_bandwidth         = optional(number)
      fault_tolerance_secondary_latency = optional(number)
      fault_tolerance_state             = optional(string)
      instance_uuid                     = optional(string)
      is_disks_cbt_enabled              = optional(bool)
      is_disks_uuid_enabled             = optional(bool)
      path                              = optional(string)
      vmware_tools_status               = optional(string)
      customer_tags = optional(list(object({
        description = optional(string)
        name        = optional(string)
      })), [])
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Asset resource in Oracle Cloud Infrastructure Cloud Bridge service.
  EOF
}

variable "asset_source" {
  type = list(map(object({
    id                               = number
    assets_compartment_id            = string
    environment_id                   = number
    inventory_id                     = number
    type                             = string
    vcenter_endpoint                 = string
    are_historical_metrics_collected = optional(bool)
    are_realtime_metrics_collected   = optional(bool)
    defined_tags                     = optional(map(string))
    freeform_tags                    = optional(map(string))
    discovery_schedule_id            = optional(string)
    display_name                     = optional(string)
    system_tags                      = optional(map(string))
    discovery_credentials = list(object({
      secret_id = string
      type      = string
    }))
    replication_credentials = list(object({
      secret_id = string
      type      = string
    }))
  })))
  default     = []
  description = <<EOF
This resource provides the Asset Source resource in Oracle Cloud Infrastructure Cloud Bridge service.
  EOF
}

variable "discovery_schedule" {
  type = list(map(object({
    id                    = number
    execution_recurrences = string
    defined_tags          = optional(map(string))
    freeform_tags         = optional(map(string))
    display_name          = optional(string)
  })))
  default     = []
  description = <<EOF
This resource provides the Discovery Schedule resource in Oracle Cloud Infrastructure Cloud Bridge service.
  EOF
}

variable "environment" {
  type = list(map(object({
    id            = number
    defined_tags  = optional(map(string))
    freeform_tags = optional(map(string))
    display_name  = optional(string)
  })))
  default     = []
  description = <<EOF
This resource provides the Environment resource in Oracle Cloud Infrastructure Cloud Bridge service.
  EOF
}

variable "inventory" {
  type = list(map(object({
    id            = number
    defined_tags  = optional(map(string))
    freeform_tags = optional(map(string))
    display_name  = optional(string)
  })))
  default     = []
  description = <<EOF
This resource provides the Inventory resource in Oracle Cloud Infrastructure Cloud Bridge service.
  EOF
}
