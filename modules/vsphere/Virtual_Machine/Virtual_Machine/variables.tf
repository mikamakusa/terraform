variable "network" {
  type    = map(list(string))
  default = {}
}

variable "datacenter" {
  type        = string
  description = "Name of the datacenter"
  default     = ""
}

variable "datastore_cluster" {
  type        = string
  description = "Name of the datastore cluster to deploy the virtual machine"
  default     = ""
}

variable "datastore" {
  type        = string
  description = "Name of the datastore to deploy the virtual machine"
  default     = ""
}

variable "resource_pool" {
  type        = string
  description = "Resource pool on which the virtual machine will be deployed"
}

variable "tags" {
  type        = map(any)
  description = "The name of the tags to attach to the resource"
  default     = null
}

variable "tags_ids" {
  type        = list(any)
  description = "The ids of the tags to attache to the resource"
  default     = null
}

variable "folder" {
  type        = string
  default     = null
  description = "Name of the folder in which the virtual machine will be stored"
}

variable "storage_policy" {
  type        = string
  default     = null
  description = "The storage policy to be sassigned to the virtual machine home directory"
}

variable "instances" {
  type        = number
  default     = 1
  description = "Number of virtual machine needed to be deployed"
}

variable "vmname" {
  type        = string
  description = "The name of the virtual machine used to deploy"
}

variable "template_name" {
  type        = string
  description = "Name of the template for the VM to be deployed"
  default     = ""
}

variable "general_options" {
  type = object({
    scsi_controller       = optional(number)
    firmware              = optional(string)
    memory                = optional(number)
    num_cpus              = optional(number)
    num_cores_per_socket  = optional(number)
    cpu_share_level       = optional(string)
    cpu_share_count       = optional(number)
    cpu_limit             = optional(number)
    cpu_reservation       = optional(number)
    memory_limit          = optional(number)
    memory_reservation    = optional(number)
    memory_share_count    = optional(number)
    memory_share_level    = optional(string)
    ignored_guest_ips     = list(string)
    hv_mode               = optional(string)
    ept_rvi_mode          = optional(string)
    latency_sensitivity   = optional(string)
    swap_placement_policy = optional(string)
    scsi_bus_sharing      = optional(string)
    scsi_type             = optional(string)
  })
  validation {
    condition     = var.general_options.scsi_controller < 5 && var.general_options.scsi_controller > -1
    error_message = "The SCSI controller number must be beween 0 and 4."
  }
  validation {
    condition     = contains(["bios", "efi"], var.general_options.firmware)
    error_message = "The firmware options must be 'bios' or 'efi'."
  }
  validation {
    condition     = var.general_options.memory > 1024
    error_message = "The memory value must be above 1024."
  }
  validation {
    condition     = var.general_options.num_cpus > 0
    error_message = "The num_cpus value must be above 0."
  }
  validation {
    condition     = var.general_options.num_cores_per_socket > 0
    error_message = "The num_cores_per_socket value must be above 0."
  }
  validation {
    condition     = contains(["high", "low", "normal", "custom"], var.general_options.cpu_share_level)
    error_message = "The cpu share level must be one of 'high', 'low', 'normal' or 'custom'."
  }
  validation {
    condition     = contains(["high", "low", "normal", "custom"], var.general_options.memory_share_level)
    error_message = "The memory share level must be one of 'high', 'low', 'normal' or 'custom'."
  }
  validation {
    condition     = contains(["hvAuto", "hvOn", "hvOff"], var.general_options.hv_mode)
    error_message = "The hvmode must be one of 'hvAuto', 'hvOn' or 'hvOff'."
  }
  validation {
    condition     = contains(["automatic", "on", "off"], var.general_options.ept_rvi_mode)
    error_message = "The ept rvi mode must be one of 'hvAuto', 'hvOn' or 'hvOff'."
  }
  validation {
    condition     = contains(["low", "normal", "medium", "high"], var.general_options.latency_sensitivity)
    error_message = "The latency sensitivity must be one of 'low', 'normal', 'medium' or 'high'."
  }
  validation {
    condition     = contains(["inherit", "hostlocal", "vmDirectory"], var.general_options.swap_placement_policy)
    error_message = "The swap placement policy must be one of 'inherit', 'hostlocal' or 'vmDirectory'."
  }
  validation {
    condition     = contains(["physicalSharing", "virtualSharing", "noSharing"], var.general_options.scsi_bus_sharing)
    error_message = "The SCSI bus sharing value must be one of 'physicalSharing', 'virtualSharing' or 'noSharing'."
  }
  validation {
    condition     = contains(["lsilogic", "pvscsi"], var.general_options.scsi_type)
    error_message = "The SCSI controller type value must be one of 'lsilogic' or 'pvscsi'."
  }
}

variable "disk" {
  type = map(object({
    size             = optional(number)
    unit_number      = optional(number)
    thin_provisioned = optional(bool)
    eagerly_scrub    = optional(bool)
    io_reservation   = optional(number)
    io_share_level   = optional(string)
    io_share_count   = optional(string)
    disk_sharing     = optional(string)
    disk_mode        = optional(string)
    controller_type  = optional(string)
  }))
  validation {
    condition     = contains(["scsi", "sata", "ide"], var.disk.controller_type)
    error_message = "The disk controller type value must be one of 'scsi' or 'sata' or 'ide'."
  }
  validation {
    condition     = contains(["low", "normal", "high", "custom"], var.disk.io_share_level)
    error_message = "The IO share level value must be one of 'low' , 'normal', 'high' or 'custom'."
  }
  validation {
    condition     = contains(["sharingMultiWriter", "sharingNone"], var.disk.disk_sharing)
    error_message = "The disk sharing value must be one of 'sharingMultiWriter' or 'sharingNone'."
  }
  validation {
    condition     = contains(["append", "independent_nonpersistent", "independent_persistent", "nonpersistent", "persistent", "undoable"], var.disk.disk_mode)
    error_message = "The disk mode must be one of 'append', 'independent_nonpersistent', 'independent_persistent', 'nonpersistent', 'persistent', 'undoable'."
  }
}

variable "clone" {
  type = object({
    network_address = string
    netmask         = number
  })
}

variable "linux" {
  type = bool
}

variable "windows" {
  type = bool
}

variable "domain" {
  type = string
}

variable "admin_password" {
  type        = string
  description = "Administrator password for Windows virtual machine"
  sensitive   = true
  default     = null
}

variable "workgroup" {
  type        = string
  description = "Workgroup of the Windows virtual machine"
  default     = null
}

variable "dns_server_list" {
  type    = list(string)
  default = null
}

variable "dns_suffix_list" {
  type        = list(string)
  description = "A list of DNS search domains to add to the DNS configuration on the virtual machine"
  default     = null
}

variable "ipv4_gateway" {
  type        = any
  default     = null
  description = "Virtual Machine Gateway to set"
}

variable "custom_attributes" {
  type    = map(any)
  default = null
}

variable "extra_config" {
  type        = map(any)
  description = "Extra configuration data for this virtual machine"
  default     = null
}