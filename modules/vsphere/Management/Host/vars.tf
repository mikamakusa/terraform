variable "host" {
  type = map(object({
    password        = string
    username        = string
    datacenter      = optional(string)
    cluster         = optional(string)
    cluster_managed = optional(string)
    thumbprint      = optional(string)
    license         = optional(string)
    force           = optional(bool)
    connected       = optional(bool)
    maintenance     = optional(bool)
    lockdown        = optional(bool)
    tags            = optional(list(string))
  }))
}