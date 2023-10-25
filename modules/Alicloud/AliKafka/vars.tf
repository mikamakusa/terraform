variable "available_resource_creation" {
  type    = string
  default = null
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    map of strings which contains all the generic tags to apply on the resources.
EOT
}

variable "vpcs" {
  type        = string
  default     = null
  description = <<-EOT
    Regex that match the VPC name to be used as datasource.
EOT
}

variable "vswitches" {
  type        = string
  default     = null
  description = <<-EOT
    Regex that match the vswitch name to be used as datasource.
EOT
}

variable "security_groups" {
  type        = string
  default     = null
  description = <<-EOT
    Regex that match the security group to be used as datasource.
EOT
}

variable "resource_groups" {
  type        = string
  default     = null
  description = <<-EOT
    Regex that match the resource group to be used as datasource.
EOT
}

variable "kms_keys" {
  type        = string
  default     = null
  description = <<-EOT
    Regex that match to the kms key to be used as datasource.
EOT
}

variable "kafka_instances" {
  type        = string
  default     = null
  description = <<-EOT
    Regex that math to kafka instances to be used as datasource.
EOT
}

variable "resource_group" {
  type = list(map(object({
    id                  = number
    display_name        = string
    resource_group_name = optional(string)
  })))
  default     = []
  description = <<-EOT
    display_name        = string / The display name of the resource group.
    resource_group_name = optional(string) / The unique identifier of the resource group.
EOT
}

variable "vpc" {
  type = list(map(object({
    id                   = number
    vpc_name             = optional(string)
    cidr_block           = optional(string)
    classic_link_enabled = optional(bool, false)
    description          = optional(string)
    dry_run              = optional(bool, false)
    enable_ipv6          = optional(bool, false)
    ipv6_isp             = optional(string)
    resource_group_id    = optional(string)
    tags                 = optional(map(string))
    user_cidrs           = optional(list(string))
  })))
  default     = []
  description = <<-EOT
    vpc_name              = optional(string)
    cidr_block            = optional(string) / The CIDR block for the VPC.
    classic_link_enabled  = optional(bool, false) / The status of ClassicLink function.
    description           = optional(string) / The VPC description.
    dry_run               = optional(bool) / if true : sends a check request and does not create a VPC.
    enable_ipv6           = optional(bool) / Whether to enable the IPv6 network segment.
    ipv6_isp              = optional(string) / The IPv6 address segment type of the VPC.
    resource_group_id     = optional(string) / The ID of the resource group to which the VPC belongs.
    tags                  = optional(map(string)) / The tags of Vpc.
    user_cidrs            = optional(list(string)) / A list of user CIDRs.
EOT
}

variable "vswitch" {
  type = list(map(object({
    id                   = number
    vswitch_name         = optional(string)
    cidr_block           = string
    vpc_id               = string
    description          = optional(string)
    zone_id              = optional(string)
    enable_ipv6          = optional(bool, false)
    ipv6_cidr_block_mask = optional(bool, false)
    tags                 = optional(map(string))
  })))
  default     = []
  description = <<-EOT
    vswitch_name         = optional(string) / The name of the VSwitch.
    cidr_block           = string / The IPv4 CIDR block of the VSwitch.
    vpc_id               = string / The VPC ID.
    description          = optional(string) / The description of VSwitch.
    zone_id              = optional(string) / The AZ for the VSwitch. Note: Required for a VPC VSwitch.
    enable_ipv6          = optional(bool) / Whether the IPv6 function is enabled in the switch.
    ipv6_cidr_block_mask = optional(bool) / The IPv6 CIDR block of the VSwitch.
    tags                 = optional(map(string)) / The tags of VSwitch.
EOT
}

variable "security_group" {
  type = list(map(object({
    id                  = number
    name                = optional(string)
    description         = optional(string)
    vpc_id              = optional(string)
    resource_group_id   = optional(string)
    security_group_type = optional(string)
    inner_access_policy = optional(string)
    tags                = optional(map(string))
  })))
  default     = []
  description = <<-EOT
    name                = optional(string) / The name of the security group.
    description         = optional(string) / The security group description.
    vpc_id              = optional(string) / The VPC ID.
    resource_group_id   = optional(string) / The Id of resource group which the security_group belongs.
    security_group_type = optional(string) / The type of the security group. Valid values: normal: basic security group. enterprise: advanced security group.
    inner_access_policy = optional(string) / Whether to allow both machines to access each other on all ports in the same security group. Valid values: ["Accept", "Drop"]
    tags                = optional(map(string)) / The tags of VSwitch.
EOT
}

variable "kms_key" {
  type = list(map(object({
    description            = optional(string)
    key_usage              = optional(string)
    automatic_rotation     = optional(string)
    key_spec               = optional(string)
    status                 = optional(string)
    origin                 = optional(string)
    pending_window_in_days = optional(number)
    protection_level       = optional(string)
    rotation_interval      = optional(string)
    tags                   = optional(map(string))
  })))
  default     = []
  description = <<-EOT
    description             = optional(string) / The description of the CMK.
    key_usage               = optional(string) / The usage of the CMK. Valid values : ENCRYPT/DECRYPT and SIGN/VERIFY.
    automatic_rotation      = optional(string) / Specifies whether to enable automatic key rotation.
    key_spec                = optional(string) / The type of the CMK. Default value: Aliyun_AES_256.
    status                  = optional(string) / The status of CMK. Valid values are Disable, Enabled, PendingDeletion.
    origin                  = optional(string) / The source of key material. Valid values are Aliyub_KMS and EXTERNAL.
    pending_window_in_days  = optional(number) / The number of days before the CMK is deleted.
    protection_level        = optional(string) / The protection level of the CMK. Valid values are SOFTWARE and HSM.
    rotation_interval       = optional(string) / The interval for automatic key rotation.
    tags                    = optional(map(string)) / A mapping of tags to assign to the resource.
EOT
}

variable "alikafka_instance" {
  type = list(map(object({
    deploy_type     = number
    disk_size       = number
    disk_type       = number
    vswitch_id      = optional(string)
    name            = optional(string)
    partition_num   = optional(number)
    io_max          = optional(number)
    io_max_spec     = optional(string)
    eip_max         = optional(number)
    paid_type       = optional(string)
    spec_type       = optional(string)
    security_group  = optional(string)
    service_version = optional(string)
    config          = optional(string)
    kms_key_id      = optional(string)
    tags            = optional(map(string))
    vpc_id          = optional(string)
    zone_id         = optional(string)
    selected_zones  = optional(list(string))
  })))
  default     = []
  description = <<-EOT
    deploy_type     = number / The deployment type of the instance. Valid values : 4 or 5
    disk_size       = number / The disk size of the instance.
    disk_type       = number / The disk type of the instance. 0: efficient cloud disk , 1: SSD.
    vswitch_id      = optional(string) / The ID of attaching vswitch to instance.
    name            = optional(string) / Name of your Kafka instance.
    partition_num   = optional(number) / The number of partitions.
    io_max          = optional(number) / The max value of io of the instance.
    io_max_spec     = optional(string) / The traffic specification of the instance.
    eip_max         = optional(number) / The max bandwidth of the instance. It will be ignored when deploy_type = 5.
    paid_type       = optional(string) / The paid type of the instance. Support two type, "PrePaid": pre paid type instance, "PostPaid": post paid type instance. Default is PostPaid.
    spec_type       = optional(string) / The spec type of the instance. Support two type, "normal": normal version instance, "professional": professional version instance.
    security_group  = optional(string) / The ID of security group for this instance.
    service_version = optional(string) / The kafka openSource version for this instance. Only 0.10.2 or 2.2.0 is allowed, default is 0.10.2.
    config          = optional(string) /  The basic config for this instance. Json type.
    kms_key_id      = optional(string) / The ID of the key that is used to encrypt data on standard SSDs in the region of the instance.
    tags            = optional(map(string)) / A mapping of tags to assign to the resource.
    vpc_id          = optional(string) / The VPC ID of the instance.
    zone_id         = optional(string) / The zone ID of the instance.
    selected_zones  = optional(list(string)) / The zones among which you want to deploy the instance.
EOT
}

variable "allowed_ip_attachment" {
  type = list(map(object({
    id           = number
    allowed_ip   = string
    allowed_type = string
    instance_id  = string
    port_range   = string
  })))
  default     = []
  description = <<-EOT
    allowed_ip   = string / The allowed ip. It can be a CIDR block.
    allowed_type = string / The type of whitelist. Valid Value: vpc, internet.
    instance_id  = string / The ID of the instance.
    port_range   = string / he Port range. Valid Value: 9092/9092, 9093/9093.
EOT
}

variable "topic" {
  type = list(map(object({
    id            = number
    instance_id   = string
    remark        = string
    topic         = string
    local_topic   = optional(bool, false)
    compact_topic = optional(bool, false)
    partition_num = optional(number)
    tags          = optional(map(string))
  })))
  default     = []
  description = <<-EOT
    instance_id   = string / InstanceId of your Kafka resource
    remark        = string / This attribute is a concise description of topic.
    topic         = string / Name of the topic. Two topics on a single instance cannot have the same name.
    local_topic   = optional(bool) / Whether the topic is localTopic or not.
    compact_topic = optional(bool) / Whether the topic is compactTopic or not.
    partition_num = optional(number) / The number of partitions of the topic.
    tags          = optional(map(string)) / A mapping of tags to assign to the resource.
EOT
}

variable "sasl_user" {
  type = list(map(object({
    id          = number
    instance_id = string
    username    = string
    password    = optional(string)
    type        = optional(string)
  })))
  default     = []
  description = <<-EOT
    instance_id = string / ID of the ALIKAFKA Instance that owns the groups.
    username    = string / Username for the sasl user.
    password    = optional(string) / Operation password. It may consist of letters, digits, or underlines, with a length of 1 to 64 characters.
    type        = optional(string) / The authentication mechanism. Valid values: plain, scram.
EOT
}

variable "sasl_acl" {
  type = list(map(object({
    id                        = number
    acl_operation_type        = string
    acl_resource_name         = string
    acl_resource_pattern_type = string
    acl_resource_type         = string
    instance_id               = string
    username                  = string
  })))
  default     = []
  description = <<-EOT
    acl_operation_type        = string / Operation type for this acl. The operation type can only be "Write" and "Read".
    acl_resource_name         = string / Resource name for this acl
    acl_resource_pattern_type = string / Resource pattern type for this acl. The resource pattern support two types "LITERAL" and "PREFIXED".
    acl_resource_type         = string / Resource type for this acl. The resource type can only be "Topic" and "Group".
    instance_id               = string / ID of the ALIKAFKA Instance that owns the groups.
    username                  = string / Username for the sasl user.
EOT
}

variable "consumer_group" {
  type = list(map(object({
    id          = number
    consumer_id = string
    instance_id = string
    description = optional(string)
    tags        = optional(map(string))
  })))
  default     = []
  description = <<-EOT
    consumer_id = string / ID of the consumer group.
    instance_id = string / ID of the ALIKAFKA Instance that owns the groups.
    description = optional(string) / The description of the resource.
    tags        = optional(map(string)) / A mapping of tags to assign to the resource.
EOT
}