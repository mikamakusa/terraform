variable "vpcs" {
  type        = string
  default     = null
  description = <<-EOT
    Regex that match the VPC name to be used as datasource.
EOT
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    map of strings which contains all the generic tags to apply on the resources.
EOT
}

variable "honeypot_images" {
  type    = string
  default = null
}

variable "assets" {
  type    = string
  default = null
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
    dry_run               = optional(bool) / if optional(bool, false) : sends a check request and does not create a VPC.
    enable_ipv6           = optional(bool) / Whether to enable the IPv6 network segment.
    ipv6_isp              = optional(string) / The IPv6 address segment type of the VPC.
    resource_group_id     = optional(string) / The ID of the resource group to which the VPC belongs.
    tags                  = optional(map(string)) / The tags of Vpc.
    user_cidrs            = optional(list(string)) / A list of user CIDRs.
EOT
}

variable "detection_instance" {
  type = list(map(object({
    id                     = number
    payment_type           = optional(string)
    version_code           = optional(string)
    modify_type            = optional(string)
    buy_number             = optional(string)
    container_image_scan   = optional(string)
    honeypot_id            = optional(number)
    honeypot_switch        = optional(string)
    period                 = optional(number)
    renew_period           = optional(number)
    renewal_status         = optional(string)
    renewal_period_unit    = optional(string)
    sas_anti_ransomware    = optional(string)
    sas_sc                 = optional(bool, false)
    sas_sdk                = optional(string)
    sas_sdk_switch         = optional(string)
    sas_webguard_boolean   = optional(string)
    sas_webguard_order_num = optional(string)
    threat_analysis        = optional(string)
    threat_analysis_switch = optional(string)
    v_core                 = optional(string)
  })))
  default = []
}

variable "anti_brute_force_rule" {
  type = list(map(object({
    id                         = number
    anti_brute_force_rule_name = optional(string)
    fail_count                 = optional(number)
    forbidden_time             = optional(number)
    span                       = optional(number)
    uuid_list                  = optional(list(string))
  })))
  default = []
}

variable "backup_policy" {
  type = list(map(object({
    id                 = number
    backup_policy_name = optional(string)
    policy             = optional(string)
    policy_version     = optional(string)
    uuid_list          = optional(list(string))
    policy_region_id   = optional(string)
  })))
  default = []
}

variable "baseline_strategy" {
  type = list(map(object({
    id                     = number
    baseline_strategy_name = optional(string)
    custom_type            = optional(string)
    cycle_days             = optional(number)
    end_time               = optional(string)
    risk_sub_type_name     = optional(string)
    start_time             = optional(string)
    target_type            = optional(string)
    cycle_start_time       = optional(number)
  })))
  default = []
}

variable "honeypot_node" {
  type = list(map(object({
    id                             = number
    available_probe_num            = optional(number)
    node_name                      = optional(string)
    allow_honeypot_access_internet = optional(bool, false)
    security_group_probe_ip_list   = optional(list(string))
  })))
  default = []
}

variable "honey_pot" {
  type = list(map(object({
    id                  = number
    honeypot_image_id   = optional(string)
    honeypot_image_name = optional(string)
    honeypot_name       = optional(string)
    node_id             = optional(string)
  })))
  default = []
}

variable "honeypot_preset" {
  type = list(map(object({
    id                  = number
    honeypot_image_name = optional(string)
    node_id             = optional(string)
    preset_name         = optional(string)
    meta = optional(list(object({
      burp            = optional(string)
      portrait_option = optional(bool, false)
      trojan_git      = optional(string)
    })), [])
  })))
  default = []
}

variable "honeypot_probe" {
  type = list(map(object({
    id              = number
    control_node_id = optional(string)
    display_name    = optional(string)
    probe_type      = optional(string)
    arp             = optional(bool, false)
    ping            = optional(bool, false)
    proxy_ip        = optional(string)
    probe_version   = optional(string)
    service_ip_list = optional(list(string))
    uuid            = optional(string)
    vpc_id          = optional(string)
  })))
  default = []
}

variable "vul_whitelist" {
  type = list(map(object({
    id          = number
    whitelist   = optional(string)
    target_info = optional(string)
    reason      = optional(string)
  })))
  default = []
}

variable "web_lock_config" {
  type = list(map(object({
    id                  = number
    defence_mode        = optional(string)
    dir                 = optional(string)
    local_backup_dir    = optional(string)
    mode                = optional(string)
    uuid                = optional(string)
    exclusive_dir       = optional(string)
    exclusive_file      = optional(string)
    exclusive_file_type = optional(string)
    inclusive_file_type = optional(string)
  })))
  default = []
}