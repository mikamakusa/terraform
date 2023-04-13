variable "static_route" {
  type = map(object({
    prefix = string
    mask   = string
    device = optional(string)
    next_hops = optional(list(object({
      next_hop  = optional(string)
      metric    = optional(number)
      global    = optional(bool)
      name      = optional(string)
      permanent = optional(bool)
      tag       = optional(number)
    })))
  }))

  default = {}

  description = "This resource can manage the Static Route configuration."
}