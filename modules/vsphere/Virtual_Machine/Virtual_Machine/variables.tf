variable "network" {
  type        = string
  default     = ""
  description = "Name of the network to be attached to the Virtual Machine"
}

variable "cluster" {
  type        = string
  description = "Name of the Cluster"
  default     = ""
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

variable "vsphere_host" {
  type        = string
  description = "Vsphere host on which the template is store or on which the virtual machine will be deployed"
  default     = ""
}

variable "datastore" {
  type        = string
  description = "Name of the datastore to deploy the virtual machine"
  default     = ""
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
  default     = ""
  description = "Name of the folder in which the virtual machine will be stored"
}

variable "storage_policy" {
  type        = string
  default     = ""
  description = "The storage policy to be sassigned to the virtual machine home directory"
}

variable "instances" {
  type        = number
  default     = 1
  description = "Number of virtual machine needed to be deployed"
}

variable "template_name" {
  type        = string
  description = "Name of the template for the VM to be deployed"
  default     = ""
}

variable "ovf_template" {
  type = list(object({
    name              = string
    disk_provisioning = optional(string)
    remote_ovf_url    = optional(string)
    local_ovf_url     = optional(string)
    ovf_network_map   = optional(list(string))
  }))

  default = []
}

variable "vm" {
  type = map(object({
    num_cpus   = optional(number)
    memory     = optional(number)
    guest_id   = optional(string)
    disk_size  = optional(number)
    disk_value = optional(string)
  }))

  default = {}
}

variable "clone_linux" {
  type = map(object({
    domain       = string
    ipv4_address = optional(string)
    ipv4_netmask = optional(number)
  }))

  default = {}

  description = <<EOF
For Linux - Building on the above example, the below configuration creates a virtual machine by cloning it from a template, fetched using the vsphere_virtual_machine data source. This option allows you to locate the UUID of the template to clone, along with settings for network interface type, SCSI bus type, and disk attributes.
EOF
}

variable "clone_windows" {
  type = map(object({
    computer_name = string
    ipv4_address  = optional(string)
    ipv4_netmask  = optional(number)
  }))

  default = {}

  description = <<EOF
For Windows - Building on the above example, the below configuration creates a virtual machine by cloning it from a template, fetched using the vsphere_virtual_machine data source. This option allows you to locate the UUID of the template to clone, along with settings for network interface type, SCSI bus type, and disk attributes.
EOF
}

variable "from_ovf" {
  type = map(object({
    vapp = optional(list(string))
  }))

  default = {}

  description = "Variable to instance in order to deploy a virtual machine from OVA/OVF file."
}