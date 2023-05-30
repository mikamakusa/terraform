variable "resource_pool" {
  type = map(object({
      cpu_min = optional(number)
      cpu_max = optional(number)
      cpu_max_shares = optional(number)
      mem_min = optional(number)
      mem_max = optional(number)
      mem_shares = optional(number)
    }))
}
variable "virtual_disk" {
  type = map(object({
      virtual_disk_disk_store = string
      virtual_disk_dir = string
      virtual_disk_size = optional(number)
      virtual_disk_type = optional(string)
    }))
}
variable "guest" {
  type = map(object({
      boot_disk_type = optional(string)
      boot_disk_size = optional(number)
      guestos = optional(string)
      boot_firmware = optional(string)
      clone_from_vm = optional(string)
      disk_store = string
      resource_pool_name = optional(string)
      memsize = optional(number)
      numvcpus = optional(number)
      network_interfaces = optional(object({
        virtual_network = string
        mac_address = optional(string)
        nic_type = optional(string)
      }))
      virtual_disks = optional(object({
        virtual_disk_id = string
        slot = string
      }))
    }))
}