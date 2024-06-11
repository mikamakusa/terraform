variable "zone" {
  type = string
}

variable "vpc" {
  type = string
}

variable "vswitch" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "account" {
  type = list(object({
    id                     = number
    db_cluster_id          = number
    account_name           = string
    account_password       = optional(string)
    kms_encrypted_password = optional(string)
    kms_encryption_context = optional(string)
    account_description    = optional(string)
    account_type           = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
db_cluster_id - (Required, ForceNew) The Id of cluster in which account belongs.
account_name - (Required, ForceNew) Operation account requiring a uniqueness check. It may consist of lower case letters, numbers, and underlines, and must start with a letter and have no more than 16 characters.
account_password - (Optional) Operation password. It may consist of letters, digits, or underlines, with a length of 6 to 32 characters. You have to specify one of account_password and kms_encrypted_password fields.
kms_encrypted_password - (Optional) An KMS encrypts password used to a db account. If the account_password is filled in, this field will be ignored.
kms_encryption_context - (Optional) An KMS encryption context used to decrypt kms_encrypted_password before creating or updating a db account with kms_encrypted_password. See Encryption Context. It is valid when kms_encrypted_password is set.
account_description - (Optional) Account description. It cannot begin with https://. It must start with a Chinese character or English letter. It can include Chinese and English characters, underlines (_), hyphens (-), and numbers. The length may be 2-256 characters.
account_type - (Optional, ForceNew) The type of the database account. Default Value: Super. Valid values:
Normal: standard account. Up to 256 standard accounts can be created for a cluster.
Super: privileged account. Only a single privileged account can be created for a cluster.
    EOF

  validation {
    condition = alltrue([
      for i in var.account : contains(["Normal", "Super"], i.account_type)
    ])
    error_message = "Valid values are 'Normal'or 'Super'."
  }
}

variable "backup_policy" {
  type = list(object({
    id                      = number
    db_cluster_id           = number
    preferred_backup_period = list(string)
    preferred_backup_time   = number
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
db_cluster_id - (Required, ForceNew) The Id of cluster that can run database.
preferred_backup_period - (Required) ADB Cluster backup period. Valid values: [Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday].
preferred_backup_time - (Required) ADB Cluster backup time, in the format of HH:mmZ- HH:mmZ. Time setting interval is one hour. China time is 8 hours behind it.
    EOF

  validation {
    condition = alltrue([
      for i in var.backup_policy : contains(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], i.preferred_backup_period)
    ])
    error_message = "Valid values are 'Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday'."
  }
}

variable "cluster" {
  type = list(object({
    id                  = number
    mode                = string
    db_cluster_version  = optional(string)
    db_cluster_category = string
    db_node_class       = optional(string)
    db_node_count       = optional(string)
    db_node_storage     = optional(string)
    payment_type        = optional(string)
    renewal_status      = optional(string)
    auto_renew_period   = optional(string)
    period              = optional(string)
    security_ips        = optional(string)
    maintain_time       = optional(string)
    description         = optional(string)
    tags                = optional(map(string))
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
db_cluster_version - (Optional, ForceNew) Cluster version. Value options: 3.optional(number), Default to 3.optional(number).
db_cluster_category - (Required, ForceNew) Cluster category. Value options: Basic, Cluster.
db_node_class - (Required) The db_node_class of cluster node.
db_node_count - (Required) The db_node_count of cluster node.
db_node_storage - (Required) The db_node_storage of cluster node.
zone_id - (Optional) The Zone to launch the DB cluster.
pay_type - (Optional) Field pay_type has been deprecated. New field payment_type instead.
payment_type - (Optional) The payment type of the resource. Valid values are PayAsYouGo and Subscription. Default to PayAsYouGo. Note: The payment_type supports updating from v1.166.optional(number)+.
renewal_status - (Optional) Valid values are AutoRenewal, Normal, NotRenewal, Default to NotRenewal.
auto_renew_period - (Optional) Auto-renewal period of an cluster, in the unit of the month. It is valid when pay_type is PrePaid. Valid value:1, 2, 3, 6, 12, 24, 36, Default to 1.
period - (Optional) The duration that you will buy DB cluster (in month). It is valid when pay_type is PrePaid. Valid values: [1~9], 12, 24, 36. Default to 1.
security_ips - (Optional) List of IP addresses allowed to access all databases of an cluster. The list contains up to 1,optional(number)optional(number)optional(number) IP addresses, separated by commas. Supported formats include optional(number).optional(number).optional(number).optional(number)/optional(number), 1optional(number).23.12.24 (IP), and 1optional(number).23.12.24/24 (Classless Inter-Domain Routing (CIDR) mode. /24 represents the length of the prefix in an IP address. The range of the prefix length is [1,32]).
vswitch_id - (Required, ForceNew) The virtual switch ID to launch DB instances in one VPC.
maintain_time - (Optional) Maintainable time period format of the instance: HH:MMZ-HH:MMZ (UTC time)
description - (Optional) The description of cluster.
tags - (Optional) A mapping of tags to assign to the resource.
    EOF

  validation {
    condition = alltrue([
      for i in var.cluster : contains(["PayAsYouGo", "Subscription"], i.payment_type)
    ])
    error_message = "Valid values are 'PayAsYouGo' or 'Subscription'."
  }

  validation {
    condition = alltrue([
      for i in var.cluster : contains(["AutoRenewal", "Normal", "NotRenewal"], i.renewal_status)
    ])
    error_message = "Valid values are 'AutoRenewal', 'NotRenewal' or 'Normal'."
  }

  validation {
    condition = alltrue([
      for i in var.cluster : contains(["Basic", "Cluster"], i.db_cluster_category)
    ])
    error_message = "Valid values are 'Basic' or 'Cluster'."
  }
}

variable "connection" {
  type = list(object({
    id                = number
    db_cluster_id     = number
    connection_prefix = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
db_cluster_id - (Required, ForceNew) The Id of cluster that can run database.
connection_prefix - (Optional, ForceNew) Prefix of the cluster public endpoint. The prefix must be 6 to 3optional(number) characters in length, and can contain lowercase letters, digits, and hyphens (-), must start with a letter and end with a digit or letter. Default to <db_cluster_id> + tf.
    EOF
}

variable "db_cluster" {
  type = list(object({
    id                       = number
    db_cluster_category      = string
    mode                     = string
    auto_renew_period        = optional(string)
    compute_resource         = optional(string)
    db_cluster_version       = optional(string)
    db_node_class            = optional(string)
    db_node_count            = optional(number)
    db_node_storage          = optional(number)
    description              = optional(string)
    elastic_io_resource      = optional(number)
    elastic_io_resource_size = optional(string)
    maintain_time            = optional(string)
    modify_type              = optional(string)
    payment_type             = optional(string)
    period                   = optional(string)
    renewal_status           = optional(string)
    security_ips             = optional(list(string))
    tags                     = optional(map(string))
    vpc_id                   = optional(string)
    vswitch_id               = optional(string)
    zone_id                  = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
auto_renew_period - (Optional, Int) Auto-renewal period of an cluster, in the unit of the month. It is valid when payment_type is Subscription. Valid values: 1, 2, 3, 6, 12, 24, 36. Default Value: 1.
compute_resource - (Optional) The specifications of computing resources in elastic mode. The increase of resources can speed up queries. AnalyticDB for MySQL automatically scales computing resources. For more information, see ComputeResource
db_cluster_category - (Required) The db cluster category. Valid values: Basic, Cluster, MixedStorage.
db_cluster_class - (Deprecated since v1.121.2) It duplicates with attribute db_node_class and is deprecated from 1.121.2.
db_cluster_version - (Optional, ForceNew) The db cluster version. Valid values: 3.optional(number). Default Value: 3.optional(number).
db_node_class - (Optional) The db node class. For more information, see DBClusterClass
db_node_count - (Optional, Int) The db node count.
db_node_storage - (Optional, Int) The db node storage.
description - (Optional) The description of DBCluster.
elastic_io_resource - (Optional, Int) The elastic io resource.
maintain_time - (Optional) The maintenance window of the cluster. Format: hh:mmZ-hh:mmZ.
mode - (Required) The mode of the cluster. Valid values: reserver, flexible.
modify_type - (Optional) The modify type.
pay_type - (Deprecated since v1.166.optional(number)) Field pay_type has been deprecated. New field payment_type instead.
payment_type - (Optional) The payment type of the resource. Valid values: PayAsYouGo and Subscription. Default Value: PayAsYouGo. Note: The payment_type supports updating from v1.166.optional(number)+.
period - (Optional, Int) The duration that you will buy DB cluster (in month). It is valid when payment_type is Subscription. Valid values: [1~9], 12, 24, 36. -> NOTE: The attribute period is only used to create Subscription instance or modify the PayAsYouGo instance to Subscription. Once effect, it will not be modified that means running terraform apply will not affect the resource.
renewal_status - (Optional) Valid values are AutoRenewal, Normal, NotRenewal, Default to NotRenewal.
resource_group_id - (Optional) The ID of the resource group.
security_ips - (Optional, List) List of IP addresses allowed to access all databases of an cluster. The list contains up to 1,optional(number)optional(number)optional(number) IP addresses, separated by commas. Supported formats include optional(number).optional(number).optional(number).optional(number)/optional(number), 1optional(number).23.12.24 (IP), and 1optional(number).23.12.24/24 (Classless Inter-Domain Routing (CIDR) mode. /24 represents the length of the prefix in an IP address. The range of the prefix length is [1,32]).
vswitch_id - (Optional, ForceNew) The vswitch id.
zone_id - (Optional, ForceNew) The zone ID of the resource.
vpc_id - (Optional, ForceNew, Available since v1.178.optional(number)) The vpc ID of the resource.
elastic_io_resource_size - (Optional, Available since v1.2optional(number)7.optional(number)) The specifications of a single elastic resource node. Default Value: 8Core64GB. Valid values:
8Core64GB: If you set elastic_io_resource_size to 8Core64GB, the specifications of an EIU are 24 cores and 192 GB memory.
12Core96GB: If you set elastic_io_resource_size to 12Core96GB, the specifications of an EIU are 36 cores and 288 GB memory.
disk_performance_level - (Optional, Available since v1.2optional(number)7.optional(number)) The ESSD performance level. Default Value: PL1. Valid values: PL1, PL2, PL3.
disk_encryption - (Optional, ForceNew, Bool, Available since v1.219.optional(number)) Specifies whether to enable disk encryption. Default Value: false. Valid values: true, false.
kms_id - (Optional, ForceNew, Available since v1.219.optional(number)) The Key Management Service (KMS) ID that is used for disk encryption. kms_id is valid only when disk_encryption is set to true.
tags - (Optional) A mapping of tags to assign to the resource.
    EOF
}

variable "db_cluster_lake_version" {
  type = list(object({
    id                            = number
    compute_resource              = string
    db_cluster_version            = string
    enable_default_resource_group = bool
    payment_type                  = string
    storage_resource              = string
    vpc_id                        = string
    vswitch_id                    = string
    zone_id                       = optional(string)
    restore_to_time               = optional(string)
    security_ips                  = optional(string)
    db_cluster_description        = optional(string)
  }))
  default     = []
  description = <<EOF
  The following arguments are supported:

db_cluster_version - (Required, ForceNew) The version of the cluster. Valid values: 5.optional(number).
vpc_id - (Required, ForceNew) The vpc ID of the resource.
vswitch_id - (Required, ForceNew) The ID of the vSwitch.
zone_id - (Required, ForceNew) The zone ID of the resource.
compute_resource - (Required) The computing resources of the cluster.
storage_resource - (Required) The storage resources of the cluster.
payment_type - (Required, ForceNew) The payment type of the resource. Valid values: PayAsYouGo.
security_ips - (Optional, Available since v1.198.optional(number)) The IP addresses in an IP address whitelist of a cluster. Separate multiple IP addresses with commas (,). You can add a maximum of 5optional(number)optional(number) different IP addresses to a whitelist. The entries in the IP address whitelist must be in one of the following formats:
IP addresses, such as 1optional(number).23.XX.XX.
CIDR blocks, such as 1optional(number).23.xx.xx/24. In this example, 24 indicates that the prefix of each IP address in the IP whitelist is 24 bits in length. You can replace 24 with a value within the range of 1 to 32.
db_cluster_description - (Optional, Available since v1.198.optional(number)) The description of the cluster.
resource_group_id - (Optional, Available since v1.211.1) The ID of the resource group.
enable_default_resource_group - (Optional, Bool) Whether to enable default allocation of resources to user_default resource groups.
restore_to_time - (Optional, Available since v1.211.1) The point in time to which you want to restore data from the backup set.
    EOF
}

variable "lake_account" {
  type = list(object({
    id                  = number
    account_name        = string
    account_password    = string
    db_cluster_id       = number
    account_description = optional(string)
    account_type        = optional(string)
    account_privileges = optional(list(object({
      privilege_type = optional(string)
      privileges     = optional(list(string))
      privilege_object = optional(list(object({
        column   = optional(string)
        database = optional(string)
        table    = optional(string)
      })), [])
    })), [])
  }))
  default     = []
  description = <<EOF
  The following arguments are supported:
account_description - (Optional) The description of the account.
account_name - (Required, ForceNew) The name of the account.
account_password - (Required) AccountPassword.
account_privileges - (Optional) List of permissions granted. See account_privileges below.
account_type - (Optional, ForceNew) The type of the account.
db_cluster_id - (Required, ForceNew) The DBCluster ID.

account_privileges
The account_privileges supports the following:
privilege_object - (Optional) Object associated to privileges. See privilege_object below.
privilege_type - (Optional) The type of privileges.
privileges - (Optional) privilege list.

account_privileges-privilege_object
The privilege_object supports the following:
column - (Optional) The name of column.
database - (Optional) The name of database.
table - (Optional) The name of table.
    EOF
}

variable "resource_group" {
  type = list(object({
    id            = number
    db_cluster_id = string
    group_name    = string
    group_type    = optional(string)
    node_num      = optional(number)
  }))
  default     = []
  description = <<EOF
  The following arguments are supported:
db_cluster_id - (Required, ForceNew) DB cluster id.
group_name - (Required, ForceNew) The name of the resource pool. The group name must be 2 to 3optional(number) characters in length, and can contain upper case letters, digits, and underscore(_).
group_type - (Optional, ForceNew) Query type, value description:
etl: Batch query mode.
interactive: interactive Query mode.
default_type: the default query mode.
node_num - (Optional) The number of nodes. The default number of nodes is optional(number). The number of nodes must be less than or equal to the number of nodes whose resource name is USER_DEFAULT.
    EOF
}

variable "gpdb_account" {
  type = list(object({
    id               = number
    account_name     = string
    account_password = string
    db_instance_id   = number
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "gpdb_backup_policy" {
  type = list(object({
    id                      = number
    preferred_backup_period = string
    preferred_backup_time   = string
    db_instance_id          = number
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "gpdb_connection" {
  type = list(object({
    id          = number
    instance_id = number
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "gpdb_db_instance_plan" {
  type = list(object({
    id                    = number
    plan_schedule_type    = string
    plan_type             = string
    db_instance_plan_name = string
    db_instance_id        = number
    plan_desc             = optional(string)
    plan_end_date         = optional(string)
    plan_start_date       = optional(string)
    status                = optional(string)
    plan_config = list(object({
      pause = optional(list(object({
        execute_time   = optional(string)
        plan_cron_time = optional(string)
      })))
      resume = optional(list(object({
        execute_time   = optional(string)
        plan_cron_time = optional(string)
      })))
      scale_in = optional(list(object({
        execute_time     = optional(string)
        plan_cron_time   = optional(string)
        segment_node_num = optional(string)
      })))
      scale_out = optional(list(object({
        execute_time     = optional(string)
        plan_cron_time   = optional(string)
        segment_node_num = optional(string)
      })))
    }))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "gpdb_elastic_instance" {
  type = list(object({
    id                      = number
    seg_node_num            = number
    seg_storage_type        = string
    storage_size            = number
    instance_spec           = string
    engine                  = string
    engine_version          = string
    vswitch_id              = string
    db_instance_category    = optional(string)
    db_instance_description = optional(string)
    encryption_key          = optional(string)
    encryption_type         = optional(string)
    instance_network_type   = optional(string)
    payment_duration        = optional(number)
    payment_duration_unit   = optional(string)
    payment_type            = optional(string)
    security_ip_list        = optional(list(string))
    tags                    = optional(map(string))
    zone_id                 = optional(string)
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "gpdb_instance" {
  type = list(object({
    id                          = number
    db_instance_mode            = string
    engine_version              = string
    engine                      = string
    vswitch_id                  = string
    create_sample_data          = optional(bool)
    db_instance_category        = optional(string)
    db_instance_class           = optional(string)
    encryption_key              = optional(string)
    encryption_type             = optional(string)
    instance_group_count        = optional(number)
    instance_network_type       = optional(string)
    instance_spec               = optional(string)
    maintain_end_time           = optional(string)
    maintain_start_time         = optional(string)
    master_cu                   = optional(number)
    payment_type                = optional(string)
    period                      = optional(string)
    resource_group_id           = optional(string)
    seg_node_num                = optional(number)
    seg_storage_type            = optional(string)
    ssl_enabled                 = optional(number)
    storage_size                = optional(number)
    tags                        = optional(map(string))
    used_time                   = optional(string)
    vector_configuration_status = optional(string)
    vpc_id                      = optional(string)
    zone_id                     = optional(string)
    ip_whitelist = optional(list(object({
      ip_group_attribute = optional(string)
      ip_group_name      = optional(string)
      security_ip_list   = optional(string)
    })), [])
  }))
  default     = []
  description = <<EOF
  EOF
}
