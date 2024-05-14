variable "project_name" {
  type = string
}

variable "recordset_v2" {
  type = list(map(object({
    id                   = number
    name                 = string
    records              = list(string)
    zone_id              = number
    type                 = optional(string)
    ttl                  = optional(number)
    description          = optional(string)
    value_specs          = optional(map(string))
    disable_status_check = optional(bool)
  })))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Optional) The region in which to obtain the V2 DNS client. If omitted, the region argument of the provider is used. Changing this creates a new DNS record set.
zone_id - (Required) The ID of the zone in which to create the record set. Changing this creates a new DNS record set.
name - (Required) The name of the record set. Note the . at the end of the name. Changing this creates a new DNS record set.
project_id - (Optional) The ID of the project DNS zone is created for, sets X-Auth-Sudo-Tenant-ID header (requires an assigned user role in target project)
type - (Optional) The type of record set. Examples: "A", "MX". Changing this creates a new DNS record set.
ttl - (Optional) The time to live (TTL) of the record set.
description - (Optional) A description of the record set.
records - (Required) An array of DNS records.
value_specs - (Optional) Map of additional options. Changing this creates a new record set.
disable_status_check - (Optional) Disable wait for recordset to reach ACTIVE status. This argumen is disabled by default. If it is set to true, the recordset will be considered as created/updated/deleted if OpenStack request returned success.
  EOF
}

variable "transfer_accept_v2" {
  type = list(map(object({
    id                   = number
    zone_id              = number
    value_specs          = optional(map(string))
    disable_status_check = optional(bool)
  })))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Optional) The region in which to obtain the V2 Compute client. Keypairs are associated with accounts, but a Compute client is needed to create one. If omitted, the region argument of the provider is used. Changing this creates a new DNS zone.
zone_transfer_request_id - (Required) The ID of the zone transfer request.
key - (Required) The transfer key.
value_specs - (Optional) Map of additional options. Changing this creates a new transfer accept.
disable_status_check - (Optional) Disable wait for zone to reach ACTIVE status. The check is enabled by default. If this argument is true, zone will be considered as created/updated if OpenStack accept returned success.
  EOF
}

variable "transfer_request_v2" {
  type = list(map(object({
    id                   = number
    zone_id              = number
    target_project_id    = optional(number)
    description          = optional(string)
    value_specs          = optional(map(string))
    disable_status_check = optional(bool)
  })))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Optional) The region in which to obtain the V2 Compute client. Keypairs are associated with accounts, but a Compute client is needed to create one. If omitted, the region argument of the provider is used. Changing this creates a new DNS zone.
zone_id - (Required) The ID of the zone for which to create the transfer request.
target_project_id - (Optional) The target Project ID to transfer to.
description - (Optional) A description of the zone tranfer request.
value_specs - (Optional) Map of additional options. Changing this creates a new transfer request.
disable_status_check - (Optional) Disable wait for zone to reach ACTIVE status. The check is enabled by default. If this argument is true, zone will be considered as created/updated if OpenStack request returned success.
  EOF
}

variable "zone_v2" {
  type = list(map(object({
    id                   = number
    name                 = string
    email                = optional(string)
    type                 = optional(string)
    attributes           = optional(map(string))
    ttl                  = optional(number)
    description          = optional(string)
    masters              = optional(list(string))
    value_specs          = optional(map(string))
    disable_status_check = optional(bool)
  })))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Optional) The region in which to obtain the V2 Compute client. Keypairs are associated with accounts, but a Compute client is needed to create one. If omitted, the region argument of the provider is used. Changing this creates a new DNS zone.
name - (Required) The name of the zone. Note the . at the end of the name. Changing this creates a new DNS zone.
project_id - (Optional) The ID of the project DNS zone is created for, sets X-Auth-Sudo-Tenant-ID header (requires an assigned user role in target project)
email - (Optional) The email contact for the zone record.
type - (Optional) The type of zone. Can either be PRIMARY or SECONDARY. Changing this creates a new zone.
attributes - (Optional) Attributes for the DNS Service scheduler. Changing this creates a new zone.
ttl - (Optional) The time to live (TTL) of the zone.
description - (Optional) A description of the zone.
masters - (Optional) An array of master DNS servers. For when type is SECONDARY.
value_specs - (Optional) Map of additional options. Changing this creates a new zone.
disable_status_check - (Optional) Disable wait for zone to reach ACTIVE status. The check is enabled by default. If this argument is true, zone will be considered as created/updated if OpenStack request returned success.
  EOF
}
