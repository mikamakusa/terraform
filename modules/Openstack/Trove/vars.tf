variable "project_name" {
  type = string
}

variable "configuration_v1" {
  type = list(map(object({
    id          = number
    description = string
    name        = string
    datastore = list(object({
      type    = string
      version = string
    }))
    configuration = optional(list(object({
      name        = string
      value       = string
      string_type = optional(bool)
    })), [])
  })))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Required) The region in which to create the db instance. Changing this creates a new instance.
name - (Required) A unique name for the resource.
description - (Optional) Description of the resource.
datastore - (Required) An array of database engine type and version. The datastore object structure is documented below. Changing this creates resource.
configuration - (Optional) An array of configuration parameter name and value. Can be specified multiple times. The configuration object structure is documented below.

The datastore block supports:
type - (Required) Database engine type to be used with this configuration. Changing this creates a new resource.
version - (Required) Version of database engine type to be used with this configuration. Changing this creates a new resource.

The configuration block supports:
name - (Optional) Configuration parameter name. Changing this creates a new resource.
value - (Optional) Configuration parameter value. Changing this creates a new resource.
string_type - (Optional) Whether or not to store configuration parameter value as string. Changing this creates a new resource. See the below note for more information.
  EOF
}

variable "database_v1" {
  type = list(map(object({
    id          = number
    instance_id = number
    name        = string
  })))
  default     = []
  description = <<EOF
The following arguments are supported:
name - (Required) A unique name for the resource.
instance_id - (Required) The ID for the database instance.
  EOF
}

variable "instance_v1" {
  type = list(map(object({
    id               = number
    name             = string
    size             = number
    configuration_id = number
    datastore = list(object({
      type    = string
      version = string
    }))
    network = optional(list(object({
      uuid        = optional(string)
      port        = optional(string)
      fixed_ip_v4 = optional(string)
      fixed_ip_v6 = optional(string)
    })), [])
    user = optional(list(object({
      name      = string
      password  = optional(string)
      host      = optional(string)
      databases = optional(list(string))
    })), [])
    database = optional(list(object({
      name    = string
      collate = optional(string)
      charset = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Required) The region in which to create the db instance. Changing this creates a new instance.
name - (Required) A unique name for the resource.
flavor_id - (Required) The flavor ID of the desired flavor for the instance. Changing this creates new instance.
configuration_id - (Optional) Configuration ID to be attached to the instance. Database instance will be rebooted when configuration is detached.
size - (Required) Specifies the volume size in GB. Changing this creates new instance.
datastore - (Required) An array of database engine type and version. The datastore object structure is documented below. Changing this creates a new instance.
network - (Optional) An array of one or more networks to attach to the instance. The network object structure is documented below. Changing this creates a new instance.
user - (Optional) An array of username, password, host and databases. The user object structure is documented below.
database - (Optional) An array of database name, charset and collate. The database object structure is documented below.

The datastore block supports:
type - (Required) Database engine type to be used in new instance. Changing this creates a new instance.
version - (Required) Version of database engine type to be used in new instance. Changing this creates a new instance.

The network block supports:
uuid - (Required unless port is provided) The network UUID to attach to the instance. Changing this creates a new instance.
port - (Required unless uuid is provided) The port UUID of a network to attach to the instance. Changing this creates a new instance.
fixed_ip_v4 - (Optional) Specifies a fixed IPv4 address to be used on this network. Changing this creates a new instance.
fixed_ip_v6 - (Optional) Specifies a fixed IPv6 address to be used on this network. Changing this creates a new instance.

The user block supports:
name - (Optional) Username to be created on new instance. Changing this creates a new instance.
password - (Optional) User's password. Changing this creates a new instance.
host - (Optional) An ip address or % sign indicating what ip addresses can connect with this user credentials. Changing this creates a new instance.
databases - (Optional) A list of databases that user will have access to. If not specified, user has access to all databases on th einstance. Changing this creates a new instance.

The database block supports:
name - (Optional) Database to be created on new instance. Changing this creates a new instance.
collate - (Optional) Database collation. Changing this creates a new instance.
charset - (Optional) Database character set. Changing this creates a new instance.
  EOF
}

variable "user_v1" {
  type = list(map(object({
    id          = number
    instance_id = number
    name        = string
    password    = string
    databases   = optional(list(string))
  })))
  default     = []
  description = <<EOF
The following arguments are supported:
name - (Required) A unique name for the resource.
instance_id - (Required) The ID for the database instance.
password - (Required) User's password.
databases - (Optional) A list of database user should have access to.
  EOF
}
