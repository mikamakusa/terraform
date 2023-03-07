variable "target_id" {
  type = string
}

variable "container_id" {
  type = string
}

variable "start" {
  type = object({
    action = optional(string)
    delay = optional(number)
    order = optional(number)
  })
  default = {}
}

variable "stop" {
  type = object({
    action = optional(string)
    delay = optional(number)
  })
  default = {}
}

variable "wait_for_guest" {
  type = bool
}