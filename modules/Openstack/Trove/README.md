## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.8.3 |
| <a name="requirement_openstack"></a> [openstack](#requirement\_openstack) | 1.54.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_openstack"></a> [openstack](#provider\_openstack) | 1.54.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [openstack_db_configuration_v1.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/db_configuration_v1) | resource |
| [openstack_db_database_v1.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/db_database_v1) | resource |
| [openstack_db_instance_v1.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/db_instance_v1) | resource |
| [openstack_db_user_v1.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/db_user_v1) | resource |
| [openstack_identity_project_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/data-sources/identity_project_v3) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_configuration_v1"></a> [configuration\_v1](#input\_configuration\_v1) | The following arguments are supported:<br>region - (Required) The region in which to create the db instance. Changing this creates a new instance.<br>name - (Required) A unique name for the resource.<br>description - (Optional) Description of the resource.<br>datastore - (Required) An array of database engine type and version. The datastore object structure is documented below. Changing this creates resource.<br>configuration - (Optional) An array of configuration parameter name and value. Can be specified multiple times. The configuration object structure is documented below.<br><br>The datastore block supports:<br>type - (Required) Database engine type to be used with this configuration. Changing this creates a new resource.<br>version - (Required) Version of database engine type to be used with this configuration. Changing this creates a new resource.<br><br>The configuration block supports:<br>name - (Optional) Configuration parameter name. Changing this creates a new resource.<br>value - (Optional) Configuration parameter value. Changing this creates a new resource.<br>string\_type - (Optional) Whether or not to store configuration parameter value as string. Changing this creates a new resource. See the below note for more information. | <pre>list(map(object({<br>    id          = number<br>    description = string<br>    name        = string<br>    datastore = list(object({<br>      type    = string<br>      version = string<br>    }))<br>    configuration = optional(list(object({<br>      name        = string<br>      value       = string<br>      string_type = optional(bool)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_database_v1"></a> [database\_v1](#input\_database\_v1) | The following arguments are supported:<br>name - (Required) A unique name for the resource.<br>instance\_id - (Required) The ID for the database instance. | <pre>list(map(object({<br>    id          = number<br>    instance_id = number<br>    name        = string<br>  })))</pre> | `[]` | no |
| <a name="input_instance_v1"></a> [instance\_v1](#input\_instance\_v1) | The following arguments are supported:<br>region - (Required) The region in which to create the db instance. Changing this creates a new instance.<br>name - (Required) A unique name for the resource.<br>flavor\_id - (Required) The flavor ID of the desired flavor for the instance. Changing this creates new instance.<br>configuration\_id - (Optional) Configuration ID to be attached to the instance. Database instance will be rebooted when configuration is detached.<br>size - (Required) Specifies the volume size in GB. Changing this creates new instance.<br>datastore - (Required) An array of database engine type and version. The datastore object structure is documented below. Changing this creates a new instance.<br>network - (Optional) An array of one or more networks to attach to the instance. The network object structure is documented below. Changing this creates a new instance.<br>user - (Optional) An array of username, password, host and databases. The user object structure is documented below.<br>database - (Optional) An array of database name, charset and collate. The database object structure is documented below.<br><br>The datastore block supports:<br>type - (Required) Database engine type to be used in new instance. Changing this creates a new instance.<br>version - (Required) Version of database engine type to be used in new instance. Changing this creates a new instance.<br><br>The network block supports:<br>uuid - (Required unless port is provided) The network UUID to attach to the instance. Changing this creates a new instance.<br>port - (Required unless uuid is provided) The port UUID of a network to attach to the instance. Changing this creates a new instance.<br>fixed\_ip\_v4 - (Optional) Specifies a fixed IPv4 address to be used on this network. Changing this creates a new instance.<br>fixed\_ip\_v6 - (Optional) Specifies a fixed IPv6 address to be used on this network. Changing this creates a new instance.<br><br>The user block supports:<br>name - (Optional) Username to be created on new instance. Changing this creates a new instance.<br>password - (Optional) User's password. Changing this creates a new instance.<br>host - (Optional) An ip address or % sign indicating what ip addresses can connect with this user credentials. Changing this creates a new instance.<br>databases - (Optional) A list of databases that user will have access to. If not specified, user has access to all databases on th einstance. Changing this creates a new instance.<br><br>The database block supports:<br>name - (Optional) Database to be created on new instance. Changing this creates a new instance.<br>collate - (Optional) Database collation. Changing this creates a new instance.<br>charset - (Optional) Database character set. Changing this creates a new instance. | <pre>list(map(object({<br>    id               = number<br>    name             = string<br>    size             = number<br>    configuration_id = number<br>    datastore = list(object({<br>      type    = string<br>      version = string<br>    }))<br>    network = optional(list(object({<br>      uuid        = optional(string)<br>      port        = optional(string)<br>      fixed_ip_v4 = optional(string)<br>      fixed_ip_v6 = optional(string)<br>    })), [])<br>    user = optional(list(object({<br>      name      = string<br>      password  = optional(string)<br>      host      = optional(string)<br>      databases = optional(list(string))<br>    })), [])<br>    database = optional(list(object({<br>      name    = string<br>      collate = optional(string)<br>      charset = optional(string)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_user_v1"></a> [user\_v1](#input\_user\_v1) | The following arguments are supported:<br>name - (Required) A unique name for the resource.<br>instance\_id - (Required) The ID for the database instance.<br>password - (Required) User's password.<br>databases - (Optional) A list of database user should have access to. | <pre>list(map(object({<br>    id          = number<br>    instance_id = number<br>    name        = string<br>    password    = string<br>    databases   = optional(list(string))<br>  })))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_configuration"></a> [configuration](#output\_configuration) | n/a |
| <a name="output_database"></a> [database](#output\_database) | n/a |
| <a name="output_instance"></a> [instance](#output\_instance) | n/a |
| <a name="output_user"></a> [user](#output\_user) | n/a |
