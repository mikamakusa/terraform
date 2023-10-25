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

variable "db_instances" {
  type        = string
  default     = null
  description = <<-EOT
    Regex that match the DB instance name to be used as datasource.
EOT
}

variable "kms_keys" {
  type        = string
  default     = null
  description = <<-EOT
    Regex that match to the kms key to be used as datasource.
EOT
}

variable "load_balancers" {
  type        = string
  default     = null
  description = <<-EOT
    Regex that match to the classic load balancer to be used as datasource.
EOT
}

variable "ess_scaling_groups" {
  type        = string
  default     = null
  description = <<-EOT
    Regex that match to the ess_scaling_groups to be used as datasource.
EOT
}

variable "ess_scaling_configurations" {
  type        = string
  default     = null
  description = <<-EOT
    Regex that match to the ess_scaling_configurations to be used as datasource.
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
    id                     = number
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

variable "ess_scaling_group" {
  type = list(map(object({
    id                                       = number
    max_size                                 = number
    min_size                                 = number
    desired_capacity                         = optional(number)
    scaling_group_name                       = optional(string)
    default_cooldown                         = optional(number)
    vswitch_ids                              = optional(set(string))
    removal_policies                         = optional(list(string))
    db_instance_ids                          = optional(set(string))
    loadbalancer_ids                         = optional(set(string))
    multi_az_policy                          = optional(string)
    on_demand_percentage_above_base_capacity = optional(number)
    on_demand_base_capacity                  = optional(number)
    spot_instance_pools                      = optional(number)
    spot_instance_remedy                     = optional(number)
    group_deletion_protection                = optional(bool, false)
    launch_template_id                       = optional(string)
    launch_template_version                  = optional(string)
    group_type                               = optional(string)
    health_check_type                        = optional(string)
    protected_instances                      = optional(set(string))
    tags                                     = optional(map(string))
  })))
  default     = []
  description = <<-EOT
    max_size                                 = number / Minimum number of ECS instances in the scaling group. Value range: [optional(number), 2optional(number)optional(number)optional(number)]
    min_size                                 = number / Maximum number of ECS instances in the scaling group. Value range: [optional(number), 2optional(number)optional(number)optional(number)]
    desired_capacity                         = optional(number) / Expected number of ECS instances in the scaling group.
    scaling_group_name                       = optional(string) / Name shown for the scaling group.
    default_cooldown                         = optional(number) / Default cool-down time (in seconds) of the scaling group.
    vswitch_ids                              = optional(set(string)) / List of virtual switch IDs in which the ecs instances to be launched.
    removal_policies                         = optional(list(string)) / RemovalPolicy is used to select the ECS instances you want to remove from the scaling group when multiple candidates for removal exist.
    db_instance_ids                          = optional(set(string)) / If an RDS instance is specified in the scaling group, the scaling group automatically attaches the Intranet IP addresses of its ECS instances to the RDS access whitelist.
    loadbalancer_ids                         = optional(set(string)) / If a Server Load Balancer instance is specified in the scaling group, the scaling group automatically attaches its ECS instances to the Server Load Balancer instance.
    multi_az_policy                          = optional(string) / Multi-AZ scaling group ECS instance expansion and contraction strategy. PRIORITY, BALANCE or COST_OPTIMIZED.
    on_demand_percentage_above_base_capacity = optional(number) / Controls the percentages of On-Demand Instances and Spot Instances for your additional capacity beyond OnDemandBaseCapacity.
    on_demand_base_capacity                  = optional(number) / The minimum amount of the Auto Scaling group's capacity that must be fulfilled by On-Demand Instances.
    spot_instance_pools                      = optional(number) / The number of Spot pools to use to allocate your Spot capacity.
    spot_instance_remedy                     = optional(number) / Whether to replace spot instances with newly created spot/onDemand instance when receive a spot recycling message.
    group_deletion_protection                = optional(bool) / Specifies whether the scaling group deletion protection is enabled.
    launch_template_id                       = optional(string) / Instance launch template ID, scaling group obtains launch configuration from instance launch template.
    launch_template_version                  = optional(string) / The version number of the launch template (Latest or Default).
    group_type                               = optional(string) / Resource type within scaling group. values: ECS, ECI.
    health_check_type                        = optional(string) / Resource type within scaling group. values: ECS, NONE.
    protected_instances                      = optional(set(string)) / Set or unset instances within group into protected status.
    tags                                     = optional(map(string)) / A mapping of tags to assign to the resource.
EOT
}

variable "db_instance" {
  type = list(map(object({
    id                             = number
    engine                         = string
    engine_version                 = string
    instance_storage               = optional(number)
    instance_type                  = optional(string)
    db_instance_storage_type       = optional(string)
    db_time_zone                   = optional(string)
    sql_collector_status           = optional(string)
    sql_collector_config_value     = optional(number)
    instance_name                  = optional(string)
    connection_string_prefix       = optional(string)
    port                           = optional(string)
    instance_charge_type           = optional(string)
    period                         = optional(number)
    monitoring_period              = optional(number)
    auto_renew                     = optional(bool, false)
    auto_renew_period              = optional(number)
    zone_id                        = optional(string)
    vswitch_id                     = optional(string)
    private_ip_address             = optional(string)
    security_ips                   = optional(set(string))
    db_instance_ip_array_name      = optional(string)
    db_instance_ip_array_attribute = optional(string)
    security_ip_type               = optional(string)
    db_is_ignore_case              = optional(bool, false)
    whitelist_network_type         = optional(string)
    modify_mode                    = optional(string)
    security_ip_mode               = optional(string)
    fresh_white_list_readins       = optional(string)
    force_restart                  = optional(bool, false)
    tags                           = optional(map(string))
    security_group_ids             = optional(set(string))
    maintain_time                  = optional(string)
    auto_upgrade_minor_version     = optional(string)
    upgrade_time                   = optional(string)
    switch_time                    = optional(string)
    target_minor_version           = optional(string)
    zone_id_slave_a                = optional(string)
    zone_id_slave_b                = optional(string)
    ssl_action                     = optional(string)
    ssl_connection_string          = optional(string)
    tde_status                     = optional(string)
    encryption_key                 = optional(string)
    ca_type                        = optional(string)
    server_cert                    = optional(string)
    server_key                     = optional(string)
    client_ca_enabled              = optional(bool, false)
    client_crl_enabled             = optional(bool, false)
    client_cert_revocation_list    = optional(string)
    acl                            = optional(string)
    replication_acl                = optional(string)
    ha_config                      = optional(string)
    manual_ha_time                 = optional(string)
    released_keep_policy           = optional(string)
    storage_auto_scale             = optional(string)
    storage_threshold              = optional(number)
    storage_upper_bound            = optional(number)
    deletion_protection            = optional(bool, false)
    tcp_connection_type            = optional(string)
    category                       = optional(string)
    babelfish_port                 = optional(string)
    vpc_id                         = optional(string)
    effective_time                 = optional(string)
    parameters = optional(list(object({
      name  = string
      value = string
    })), [])
    babelfish = optional(list(object({
      babelfish_enabled    = string
      master_user_password = string
      master_username      = string
      migration_mode       = string
    })), [])
    pg_hba_conf = optional(list(object({
      address     = string
      database    = string
      method      = string
      priority_id = number
      type        = string
      user        = string
      mask        = optional(string)
      option      = optional(string)
    })), [])
    serverless_config = optional(list(object({
      max_capacity = number
      min_capacity = number
      auto_pause   = optional(bool, false)
      switch_force = optional(bool, false)
    })), [])
  })))
  default     = []
  description = <<-EOT
    engine                         = string
    engine_version                 = string
    instance_storage               = optional(number)
    instance_type                  = optional(string)
    db_instance_storage_type       = optional(string)
    db_time_zone                   = optional(string)
    sql_collector_status           = optional(string)
    sql_collector_config_value     = optional(number)
    instance_name                  = optional(string)
    connection_string_prefix       = optional(string)
    port                           = optional(string)
    instance_charge_type           = optional(string)
    period                         = optional(number)
    monitoring_period              = optional(number)
    auto_renew                     = optional(bool)
    auto_renew_period              = optional(number)
    zone_id                        = optional(string)
    vswitch_id                     = optional(string)
    private_ip_address             = optional(string)
    security_ips                   = optional(set(string))
    db_instance_ip_array_name      = optional(string)
    db_instance_ip_array_attribute = optional(string)
    security_ip_type               = optional(string)
    db_is_ignore_case              = optional(bool)
    whitelist_network_type         = optional(string)
    modify_mode                    = optional(string)
    security_ip_mode               = optional(string)
    fresh_white_list_readins       = optional(string)
    force_restart                  = optional(bool)
    tags                           = optional(map(string))
    security_group_ids             = optional(set(string))
    maintain_time                  = optional(string)
    auto_upgrade_minor_version     = optional(string)
    upgrade_time                   = optional(string)
    switch_time                    = optional(string)
    target_minor_version           = optional(string)
    zone_id_slave_a                = optional(string)
    zone_id_slave_b                = optional(string)
    ssl_action                     = optional(string)
    ssl_connection_string          = optional(string)
    tde_status                     = optional(string)
    encryption_key                 = optional(string)
    ca_type                        = optional(string)
    server_cert                    = optional(string)
    server_key                     = optional(string)
    client_ca_enabled              = optional(bool)
    client_crl_enabled             = optional(bool)
    client_cert_revocation_list    = optional(string)
    acl                            = optional(string)
    replication_acl                = optional(string)
    ha_config                      = optional(string)
    manual_ha_time                 = optional(string)
    released_keep_policy           = optional(string)
    storage_auto_scale             = optional(string)
    storage_threshold              = optional(number)
    storage_upper_bound            = optional(number)
    deletion_protection            = optional(bool)
    tcp_connection_type            = optional(string)
    category                       = optional(string)
    babelfish_port                 = optional(string)
    vpc_id                         = optional(string)
    effective_time                 = optional(string)
    parameters = optional(list(object))
      name  = string
      value = string
    babelfish = optional(list(object))
      babelfish_enabled    = string
      master_user_password = string
      master_username      = string
      migration_mode       = string
    pg_hba_conf = optional(list(object))
      address     = string
      database    = string
      method      = string
      priority_id = number
      type        = string
      user        = string
      mask        = optional(string)
      option      = optional(string)
    serverless_config = optional(list(object))
      max_capacity = number
      min_capacity = number
      auto_pause   = optional(bool, false)
      switch_force = optional(bool, false)
EOT
}

variable "load_balancer" {
  type = list(map(object({
    id                             = number
    load_balancer_name             = optional(string)
    address_type                   = optional(string)
    internet_charge_type           = optional(string)
    instance_charge_type           = optional(string)
    bandwidth                      = optional(number)
    vswitch_id                     = optional(string)
    load_balancer_spec             = optional(string)
    tags                           = optional(map(string))
    payment_type                   = optional(string)
    period                         = optional(number)
    delete_protection              = optional(string)
    address_ip_version             = optional(string)
    address                        = optional(string)
    resource_group_id              = optional(string)
    modification_protection_reason = optional(string)
    modification_protection_status = optional(string)
    status                         = optional(string)
    specification                  = optional(string)
  })))
  default     = []
  description = <<-EOT
    load_balancer_name             = optional(string)
    address_type                   = optional(string)
    internet_charge_type           = optional(string)
    instance_charge_type           = optional(string)
    bandwidth                      = optional(number)
    vswitch_id                     = optional(string)
    load_balancer_spec             = optional(string)
    tags                           = optional(map(string))
    payment_type                   = optional(string)
    period                         = optional(number)
    delete_protection              = optional(string)
    address_ip_version             = optional(string)
    address                        = optional(string)
    resource_group_id              = optional(string)
    modification_protection_reason = optional(string)
    modification_protection_status = optional(string)
    status                         = optional(string)
    specification                  = optional(string)
EOT
}

variable "scaling_configuration" {
  type = list(map(object({
    id                = number
    scaling_group_id  = optional(string)
    image_id          = optional(string)
    instance_type     = optional(string)
    security_group_id = optional(string)
    force_delete      = optional(bool, false)
    active            = optional(bool, false)
    tags              = optional(map(string))
  })))
  default     = []
  description = <<-EOT
    scaling_group_id  = optional(string) / ID of the scaling group of a scaling configuration.
    image_id          = optional(string) / ID of an image file, indicating the image resource selected when an instance is enabled.
    instance_type     = optional(string) / Resource type of an ECS instance.
    security_group_id = optional(string) / ID of the security group used to create new instance.
    force_delete      = optional(bool) / The last scaling configuration will be deleted forcibly with deleting its scaling group.
    active            = optional(bool) / Whether active current scaling configuration in the specified scaling group.
EOT
}

variable "managed_kubernetes" {
  type = list(map(object({
    id                           = number
    worker_vswitch_ids           = list(string)
    name                         = optional(string)
    timezone                     = optional(string)
    resource_group_id            = optional(string)
    version                      = optional(string)
    security_group_id            = optional(string)
    is_enterprise_security_group = optional(bool, false)
    proxy_mode                   = optional(string)
    cluster_domain               = optional(string)
    custom_san                   = optional(string)
    user_ca                      = optional(string)
    deletion_protection          = optional(bool, false)
    enable_rrsa                  = optional(bool, false)
    service_account_issuer       = optional(string)
    api_audiences                = optional(list(string))
    tags                         = optional(map(string))
    cluster_spec                 = optional(string)
    encryption_provider_key_id   = optional(string)
    load_balancer_spec           = optional(string)
    control_plane_log_ttl        = optional(string)
    control_plane_log_components = optional(list(string))
    control_plane_log_project    = optional(string)
    retain_resources             = optional(list(string))
    pod_cidr                     = optional(string)
    pod_vswitch_ids              = optional(list(string))
    new_nat_gateway              = optional(bool, false)
    service_cidr                 = optional(string)
    node_cidr_mask               = optional(number)
    slb_internet_enabled         = optional(bool, false)
    client_cert                  = optional(string)
    client_key                   = optional(string)
    cluster_ca_cert              = optional(string)
    availability_zone            = optional(string)
    addons = optional(list(object({
      name     = optional(string)
      config   = optional(string)
      disabled = optional(bool, false)
    })), [])
    worker_data_disks = optional(list(object({
      kms_key_id  = optional(string)
      device      = optional(string)
      name        = optional(string)
      snapshot_id = optional(string)
    })), [])
    maintenance_window = optional(list(object({
      duration         = optional(string)
      enable           = optional(bool, false)
      maintenance_time = optional(string)
      weekly_period    = optional(string)
    })), [])
    log_config = optional(list(object({
      type    = optional(string)
      project = optional(string)
    })), [])
    taints = optional(list(object({
      key    = optional(string)
      value  = optional(string)
      effect = optional(string)
    })), [])
  })))
  default     = []
  description = <<-EOT
    worker_vswitch_ids           = list(string) / The vswitches used by control plane.
    name                         = optional(string) / The kubernetes cluster's name.
    timezone                     = optional(string) / When you create a cluster, set the time zones for the Master and Worker nodes.
    resource_group_id            = optional(string) / The ID of the resource group.
    version                      = optional(string) / Desired Kubernetes version.
    security_group_id            = optional(string) / The ID of the security group to which the ECS instances in the cluster belong.
    is_enterprise_security_group = optional(bool) / Enable to create advanced security group.
    proxy_mode                   = optional(string) / Proxy mode is option of kube-proxy.
    cluster_domain               = optional(string) / Cluster local domain name, Default to cluster.local.
    custom_san                   = optional(string) / Customize the certificate SAN, multiple IP or domain names are separated by English commas (,).
    user_ca                      = optional(string) / The path of customized CA cert.
    deletion_protection          = optional(bool) / Whether to enable cluster deletion protection.
    enable_rrsa                  = optional(bool) / Whether to enable cluster to support RRSA.
    service_account_issuer       = optional(string) / The issuer of the Service Account token
    api_audiences                = optional(list(string)) / A list of API audiences for Service Account Token Volume Projection. Set this to ["https://kubernetes.default.svc"] if you want to enable the Token Volume Projection feature.
    tags                         = optional(map(string)) / A map of tags assigned to the kubernetes cluster and work nodes.
    cluster_spec                 = optional(string) / The cluster specifications of kubernetes cluster,which can be empty.
    encryption_provider_key_id   = optional(string) / The disk encryption key.
    load_balancer_spec           = optional(string) / The cluster api server load balance instance specification
    control_plane_log_ttl        = optional(string) / Control plane log retention duration
    control_plane_log_components = optional(list(string)) / List of target components for which logs need to be collected.
    control_plane_log_project    = optional(string) / Control plane log project.
    retain_resources             = optional(list(string)) / Resources that are automatically created during cluster creation, including NAT gateways, SNAT rules, SLB instances, and RAM Role, will be deleted.
    pod_cidr                     = optional(string) / The CIDR block for the pod network when using Flannel.
    pod_vswitch_ids              = optional(list(string)) / The vswitches for the pod network when using Terway.
    new_nat_gateway              = optional(bool, false) / Whether to create a new nat gateway while creating kubernetes cluster.
    service_cidr                 = optional(string) / The CIDR block for the service network.
    node_cidr_mask               = optional(number) / The node cidr block to specific how many pods can run on single node.
    slb_internet_enabled         = optional(bool) / Whether to create internet load balancer for API Server.
    client_cert                  = optional(string) / The path of client certificate
    client_key                   = optional(string) / The path of client key
    cluster_ca_cert              = optional(string) / The path of cluster ca certificate
    availability_zone            = optional(string) / The Zone where new kubernetes cluster will be located.
    addons = optional(list(object))
      name     = optional(string) / This parameter specifies the name of the component.
      config   = optional(string) / If this parameter is left empty, no configurations are required.
      disabled = optional(bool) / It specifies whether to disable automatic installation.
    worker_data_disks = optional(list(object))
      kms_key_id              = optional(string) / The ID of the Key Management Service (KMS) key to use for data disk N.
      device                  = optional(string) / The mount point of data disk N.
      name                    = optional(string) / The name of data disk N.
      snapshot_id             = optional(string) / The ID of the snapshot to be used to create data disk N.
    maintenance_window = optional(list(object))
      duration         = optional(string) / The maintenance time, values range from 1 to 24,unit is hour.
      enable           = optional(bool) / Whether to open the maintenance window.
      maintenance_time = optional(string) / Initial maintenance time, For example:"03:00:00Z".
      weekly_period    = optional(string) / Maintenance cycle, you can set the values from Monday to Sunday, separated by commas when the values are multiple.
    log_config = optional(list(object))
      type    = optional(string) / Type of collecting logs, only SLS are supported currently.
      project = optional(string) / Log Service project name, cluster logs will output to this project.
    taints = optional(list(object))
      key    = optional(string) / The taint key.
      value  = optional(string) / The taint value.
      effect = optional(string) / The taint effect.
EOT
}

variable "autoscaling_config" {
  type = list(map(object({
    id                        = number
    cluster_id                = optional(string)
    cool_down_duration        = optional(string)
    unneeded_duration         = optional(string)
    utilization_threshold     = optional(string)
    gpu_utilization_threshold = optional(string)
    scan_interval             = optional(string)
    scale_down_enabled        = optional(bool, false)
    expander                  = optional(string)
  })))
  default     = []
  description = <<-EOT
    cluster_id                = optional(string)
    cool_down_duration        = optional(string)
    unneeded_duration         = optional(string)
    utilization_threshold     = optional(string)
    gpu_utilization_threshold = optional(string)
    scan_interval             = optional(string)
    scale_down_enabled        = optional(bool)
    expander                  = optional(string)
EOT
}

variable "edge_kubernetes" {
  type = list(map(object({
    id                             = number
    worker_number                  = number
    worker_vswitch_ids             = list(string)
    name                           = optional(string)
    version                        = optional(string)
    security_group_id              = optional(string)
    is_enterprise_security_group   = optional(bool, false)
    rds_instances                  = optional(list(string))
    resource_group_id              = optional(string)
    deletion_protection            = optional(bool, false)
    force_update                   = optional(bool, false)
    tags                           = optional(map(string))
    retain_resources               = optional(list(string))
    cluster_spec                   = optional(string)
    runtime                        = optional(map(string))
    availability_zone              = optional(string)
    pod_cidr                       = optional(string)
    new_nat_gateway                = optional(bool, false)
    service_cidr                   = optional(string)
    node_cidr_mask                 = optional(number)
    slb_internet_enabled           = optional(bool, false)
    load_balancer_spec             = optional(string)
    password                       = optional(string)
    key_name                       = optional(string)
    worker_instance_charge_type    = optional(string)
    worker_disk_category           = optional(string)
    worker_disk_size               = optional(number)
    install_cloud_monitor          = optional(bool, false)
    proxy_mode                     = optional(string)
    user_data                      = optional(string)
    worker_disk_performance_level  = optional(string)
    worker_disk_snapshot_policy_id = optional(string)
    client_cert                    = optional(string)
    client_key                     = optional(string)
    cluster_ca_cert                = optional(string)
    addons = optional(list(object({
      name     = optional(string)
      config   = optional(string)
      disabled = optional(bool, false)
    })), [])
    worker_data_disks = optional(list(object({
      category                = optional(string)
      size                    = optional(string)
      encrypted               = optional(string)
      performance_level       = optional(string)
      auto_snapshot_policy_id = optional(string)
      kms_key_id              = optional(string)
      device                  = optional(string)
      name                    = optional(string)
      snapshot_id             = optional(string)
    })), [])
  })))
  default     = []
  description = <<-EOT
    worker_instance_types          = list(string) / The instance types of worker node, you can set multiple types to avoid NoStock of a certain type.
    worker_number                  = number / The cloud worker node number of the edge kubernetes cluster. Default to 1.
    worker_vswitch_ids             = list(string) / The vswitches used by workers.
    name                           = optional(string) / The kubernetes cluster's name.
    version                        = optional(string) / Desired Kubernetes version.
    security_group_id              = optional(string) / The ID of the security group to which the ECS instances in the cluster belong.
    is_enterprise_security_group   = optional(bool) / Enable to create advanced security group.
    rds_instances                  = optional(list(string)) / RDS instance list, You can choose which RDS instances whitelist to add instances to.
    resource_group_id              = optional(string) / The ID of the resource group.
    deletion_protection            = optional(bool) / Whether to enable cluster deletion protection.
    force_update                   = optional(bool) / Default false, when you want to change vpc_id, you have to set this field to true, then the cluster will be recreated.
    tags                           = optional(map(string)) / A map of tags assigned to the kubernetes cluster and work node.
    retain_resources               = optional(list(string)) / Resources that are automatically created during cluster creation, including NAT gateways, SNAT rules, SLB instances, and RAM Role, will be deleted.
    cluster_spec                   = optional(string) / he cluster specifications of kubernetes cluster,which can be empty.
    runtime                        = optional(map(string)) / The runtime of containers.
    availability_zone              = optional(string) / The ID of availability zone.
    pod_cidr                       = optional(string) / [Flannel Specific] The CIDR block for the pod network when using Flannel.
    new_nat_gateway                = optional(bool) / Whether to create a new nat gateway while creating kubernetes cluster.
    service_cidr                   = optional(string) / The CIDR block for the service network.
    node_cidr_mask                 = optional(number) / The node cidr block to specific how many pods can run on single node.
    slb_internet_enabled           = optional(bool) / Whether to create internet load balancer for API Server.
    load_balancer_spec             = optional(string) / The cluster api server load balance instance specification.
    password                       = optional(string) / The password of ssh login cluster node.
    key_name                       = optional(string) / The keypair of ssh login cluster node, you have to create it first.
    worker_instance_charge_type    = optional(string) / Worker payment type, its valid value is PostPaid.
    worker_disk_category           = optional(string) / The system disk category of worker node. Its valid value are cloud_efficiency, cloud_ssd and cloud_essd.
    worker_disk_size               = optional(number) / he system disk size of worker node. Its valid value range [20~32768] in GB. Default to 40.
    install_cloud_monitor          = optional(bool) / Install cloud monitor agent on ECS. default: true.
    proxy_mode                     = optional(string) / Proxy mode is option of kube-proxy. options: iptables|ipvs.
    user_data                      = optional(string) / Windows instances support batch and PowerShell scripts.
    worker_disk_performance_level  = optional(string) / Worker node system disk performance level, when worker_disk_category values cloud_essd, the optional values are PL0, PL1, PL2 or PL3.
    worker_disk_snapshot_policy_id = optional(string) / Worker node system disk auto snapshot policy.
    client_cert                    = optional(string) / The path of client certificate
    client_key                     = optional(string) / The path of client key.
    cluster_ca_cert                = optional(string) / The path of cluster ca certificate.
    addons = optional(list(object))
      name     = optional(string) / Name of the ACK add-on.
      config   = optional(string) / The ACK add-on configurations.
      disabled = optional(bool) / Disables the automatic installation of a component.
    worker_data_disks = optional(list(object))
      category                = optional(string) / The type of the data disks. Valid values: cloud, cloud_efficiency, cloud_ssd and cloud_essd.
      size                    = optional(string) / The size of a data disk, at least 40. Unit: GiB.
      encrypted               = optional(string) / Specifies whether to encrypt data disks.
      performance_level       = optional(string) / Worker node data disk performance level, when category values cloud_essd, the optional values are PL0, PL1, PL2 or PL3, but the specific performance level is related to the disk capacity.
      auto_snapshot_policy_id = optional(string) / Worker node data disk auto snapshot policy.
      kms_key_id              = optional(string) / The id of the kms key.
      device                  = optional(string) / The device of the data disks.
      name                    = optional(string) / The name of the data disks.
      snapshot_id             = optional(string) / The id of snapshot.
EOT
}

variable "kubernetes_autoscaler" {
  type = list(map(object({
    id                      = number
    cluster_id              = number
    cool_down_duration      = string
    defer_scale_in_duration = string
    utilization             = string
    nodepools = optional(list(object({
      id     = optional(number)
      labels = optional(string)
      taints = optional(string)
    })), [])
  })))
  default     = []
  description = <<-EOT
    cluster_id              = number / ID of kubernetes cluster.
    cool_down_duration      = string / The cool_down_duration option of cluster-autoscaler.
    defer_scale_in_duration = string / The defer_scale_in_duration option of cluster-autoscaler.
    utilization             = string / The utilization option of cluster-autoscaler.
EOT
}

variable "node_pool" {
  type = list(map(object({
    id                            = number
    cluster_id                    = number
    instance_types                = list(string)
    name                          = string
    vswitch_ids                   = list(number)
    password                      = optional(string)
    key_name                      = optional(string)
    kms_encrypted_password        = optional(string)
    kms_encryption_context        = optional(map(string))
    desired_size                  = optional(number)
    system_disk_category          = optional(string)
    system_disk_size              = optional(number)
    system_disk_performance_level = optional(string)
    scaling_policy                = optional(string)
    instance_charge_type          = optional(string)
    period                        = optional(number)
    period_unit                   = optional(string)
    auto_renew                    = optional(bool, false)
    auto_renew_period             = optional(number)
    install_cloud_monitor         = optional(bool, false)
    unschedulable                 = optional(bool, false)
    resource_group_id             = optional(number)
    internet_charge_type          = optional(string)
    internet_max_bandwidth_out    = optional(number)
    spot_strategy                 = optional(string)
    keep_instance_name            = optional(bool, false)
    format_disk                   = optional(bool, false)
    image_type                    = optional(string)
    runtime_name                  = optional(string)
    runtime_version               = optional(string)
    cis_enabled                   = optional(bool, false)
    soc_enabled                   = optional(bool, false)
    rds_instances                 = optional(list(string))
    cpu_policy                    = optional(string)
    node_name_mode                = optional(string)
    user_data                     = optional(string)
    tags                          = optional(map(string))
    data_disks = optional(list(object({
      category          = optional(string)
      size              = optional(number)
      encrypted         = optional(string)
      performance_level = optional(string)
      kms_key_id        = optional(number)
      device            = optional(string)
      name              = optional(string)
    })), [])
    labels = optional(list(object({
      key   = optional(string)
      value = optional(string)
    })), [])
    taints = optional(list(object({
      key    = optional(string)
      value  = optional(string)
      effect = optional(string)
    })), [])
    management = optional(list(object({
      max_unavailable  = optional(number)
      auto_repair      = optional(bool, false)
      auto_upgrade     = optional(bool, false)
      surge            = optional(number)
      surge_percentage = optional(number)
    })), [])
    scaling_config = optional(list(object({
      max_size                 = optional(number)
      min_size                 = optional(number)
      type                     = optional(string)
      is_bond_eip              = optional(bool, false)
      eip_internet_charge_type = optional(string)
      eip_bandwidth            = optional(number)
    })), [])
    spot_price_limit = optional(list(object({
      instance_type = optional(string)
      price_limit   = optional(string)
    })), [])
    kubelet_configuration = optional(list(object({
      registry_burst             = optional(string)
      registry_pull_qps          = optional(string)
      event_record_qps           = optional(string)
      event_burst                = optional(string)
      kube_api_burst             = optional(string)
      kube_api_qps               = optional(string)
      kube_reserved              = optional(map(string))
      serialize_image_pulls      = optional(string)
      cpu_manager_policy         = optional(string)
      eviction_hard              = optional(map(string))
      eviction_soft              = optional(map(string))
      eviction_soft_grace_period = optional(map(string))
      system_reserved            = optional(map(string))
    })), [])
    rolling_policy = optional(list(object({
      max_parallelism = optional(number)
    })), [])
    rollout_policy = optional(list(object({
      max_unavailable = optional(string)
    })))
  })))
  default = []
}

variable "ram_user" {
  type = list(map(object({
    id           = number
    name         = optional(string)
    display_name = optional(string)
  })))
  default = []
}

variable "ram_policy" {
  type = list(map(object({
    id              = number
    policy_name     = optional(string)
    policy_document = optional(string)
    description     = optional(string)
    force           = optional(bool, false)
  })))
  default = []
}

variable "policy_attachement" {
  type = list(map(object({
    id        = number
    policy_id = number
    user_id   = number
  })))
  default = []
}

variable "kubernetes_permission" {
  type = list(map(object({
    id   = number
    uuid = number
    permissions = optional(list(object({
      cluster     = number
      role_name   = string
      role_type   = string
      namespace   = optional(string)
      is_ram_role = optional(bool, true)
      is_custom   = optional(bool, false)
    })), [])
  })))
  default = []
}

variable "serverless_kubernetes" {
  type = list(map(object({
    id                             = number
    vpc_id                         = number
    name                           = optional(string)
    version                        = optional(string)
    vswitch_ids                    = optional(list(number))
    new_nat_gateway                = optional(bool, false)
    endpoint_public_access_enabled = optional(bool, false)
    service_discovery_types        = optional(list(string))
    deletion_protection            = optional(bool, fase)
    enable_rrsa                    = optional(bool, false)
    force_update                   = optional(bool, false)
    tags                           = optional(map(string))
    client_cert                    = optional(string)
    client_key                     = optional(string)
    cluster_ca_cert                = optional(string)
    security_group_id              = optional(number)
    resource_group_id              = optional(number)
    load_balancer_spec             = optional(string)
    time_zone                      = optional(string)
    zone_id                        = optional(number)
    service_cidr                   = optional(string)
    logging_type                   = optional(string)
    sls_project_name               = optional(string)
    retain_resources               = optional(list(string))
    cluster_spec                   = optional(string)
    create_v2_cluster              = optional(bool, false)
    addons = optional(list(object({
      name     = optional(string)
      config   = optional(string)
      disabled = optional(bool, false)
    })), [])
  })))
  default = []
}