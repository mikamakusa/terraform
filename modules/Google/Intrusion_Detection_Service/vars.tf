variable "labels" {
  type    = map(string)
  default = {}
}

variable "network" {
  type = string
}

variable "global_address" {
  type = list(map(object({
    id            = number
    name          = string
    address       = optional(string)
    description   = optional(string)
    labels        = optional(map(string))
    ip_version    = optional(string)
    prefix_length = optional(number)
    address_type  = optional(string)
    purpose       = optional(string)
  })))
  default     = []
  description = <<EOF
Represents a Global Address resource. Global addresses are used for HTTP(S) load balancing.
EOF
}

variable "networking_connection" {
  type = list(map(object({
    id         = number
    service_id = number
    service    = string
  })))
  default     = []
  description = <<EOF
Manages a private VPC connection with a GCP service provider
EOF
}

variable "ids_endpoint" {
  type = list(map(object({
    id                = number
    location          = string
    name              = string
    severity          = string
    description       = optional(string)
    threat_exceptions = optional(list(string))
  })))
  default     = []
  description = <<EOF
Cloud IDS is an intrusion detection service that provides threat detection for intrusions, malware, spyware, and command-and-control attacks on your network.
EOF
}