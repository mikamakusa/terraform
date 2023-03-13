variable "disk" {
  type = map(object({
    vmdk_path          = string
    datastore          = string
    size               = number
    datacenter         = optional(string)
    type               = optional(string)
    create_directories = optional(bool)
  }))
}