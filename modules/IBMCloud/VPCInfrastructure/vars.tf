variable "vpc_name" {
  type    = string
  default = null
}

variable "vpc_routing_table_name" {
  type    = string
  default = null
}

variable "public_gateway_name" {
  type    = string
  default = null
}

variable "network_acl_name" {
  type    = string
  default = null
}

variable "floatting_ip_name" {
  type    = string
  default = null
}

variable "subnet_name" {
  type    = string
  default = null
}

variable "backup_policy_name" {
  type    = string
  default = null
}

variable "image_name" {
  type    = string
  default = null
}

variable "ssh_key_name" {
  type    = list(string)
  default = []
}

variable "security_group_name" {
  type    = list(string)
  default = []
}

variable "bare_metal_server_name" {
  type    = string
  default = null
}

variable "bare_metal_server_network_interface_name" {
  type    = string
  default = null
}

variable "dedicated_host_group_name" {
  type    = string
  default = null
}

variable "dedicated_host_name" {
  type    = string
  default = null
}

variable "resource_instance_name" {
  type    = string
  default = null
}

variable "bucket_name" {
  type    = string
  default = null
}

variable "placement_group_name" {
  type    = string
  default = null
}

variable "instance_template_name" {
  type    = string
  default = null
}

variable "instance_name" {
  type    = string
  default = null
}

variable "lb_name" {
  type    = string
  default = null
}

variable "lb_pool_name" {
  type    = string
  default = null
}

variable "instance_group_name" {
  type    = string
  default = null
}

variable "instance_group_manager_name" {
  type    = string
  default = null
}

variable "instance_group_membership_name" {
  type    = string
  default = null
}

variable "volume_name" {
  type    = string
  default = null
}

variable "lb_listener_id" {
  type    = string
  default = null
}

variable "reserved_id" {
  type    = string
  default = null
}

variable "virtual_endpoint_gateway_name" {
  type    = string
  default = null
}

variable "vpn_server_name" {
  type    = string
  default = null
}

variable "vpn_gateway_name" {
  type    = string
  default = null
}

variable "ike_policy_name" {
  type    = string
  default = null
}

variable "ipsec_policy_name" {
  type    = string
  default = null
}

variable "vpc" {
  type = list(map(object({
    id                          = number
    name                        = string
    access_tags                 = optional(list(string))
    address_prefix_management   = optional(string)
    classic_access              = optional(bool, false)
    default_network_acl_name    = optional(string)
    default_routing_table_name  = optional(string)
    default_security_group_name = optional(string)
    tags                        = optional(list(string))
    dns = optional(list(object({
      enable_hub = optional(bool, false)
      type       = optional(string)
      vpc_id     = optional(list(string))
      vpc_crn    = optional(list(string))
      resolver = optional(list(object({
        manual_server = optional(list(object({
          address       = optional(string)
          zone_affinity = optional(string)
        })), [])
      })), [])
    })), [])
  })))
  default = []
}

variable "vpc_address_prefix" {
  type = list(map(object({
    id         = number
    cidr       = string
    name       = string
    vpc        = any
    zone       = string
    is_default = optional(bool, false)
  })))
  default = []
}

variable "vpc_routing_table" {
  type = list(map(object({
    id                               = number
    vpc                              = any
    accept_routes_from_resource_type = optional(list(string))
    name                             = optional(string)
    route_direct_link_ingress        = optional(bool, false)
    route_internet_ingress           = optional(bool, false)
    route_transit_gateway_ingress    = optional(bool, false)
    route_vpc_zone_ingress           = optional(bool, false)
  })))
  default = []
}

variable "vpc_routing_table_route" {
  type = list(map(object({
    id            = number
    destination   = string
    next_hop      = string
    routing_table = string
    vpc           = any
    zone          = string
    name          = optional(string)
    priority      = optional(number)
  })))
  default = []
}

variable "subnet" {
  type = list(map(object({
    id                       = number
    name                     = string
    vpc                      = any
    zone                     = string
    access_tags              = optional(list(string))
    ip_version               = optional(string)
    ipv4_cidr_block          = optional(string)
    total_ipv4_address_count = optional(number)
    public_gateway           = optional(string)
    routing_table            = optional(string)
    network_acl              = optional(string)
    tags                     = optional(list(string))
  })))
  default = []
}

variable "subnet_network_acl_attachment" {
  type = list(map(object({
    id          = number
    network_acl = any
    subnet      = any
  })))
  default = []
}

variable "subnet_public_gateway_attachment" {
  type = list(map(object({
    id             = number
    public_gateway = any
    subnet         = any
  })))
  default = []
}

variable "subnet_reserved_ip" {
  type = list(map(object({
    id          = number
    subnet      = any
    address     = optional(string)
    auto_delete = optional(bool, false)
    name        = optional(string)
    target      = optional(any)
    target_crn  = optional(any)
  })))
  default = []
}

variable "subnet_routing_table_attachement" {
  type = list(map(object({
    id            = number
    routing_table = any
    subnet        = any
  })))
  default = []
}

variable "ssh_key" {
  type = list(map(object({
    id          = number
    name        = string
    public_key  = string
    access_tags = optional(list(string))
    tags        = optional(list(string))
  })))
  default = []
}

variable "backup_policy" {
  type = list(map(object({
    id                   = number
    match_user_tags      = list(string)
    name                 = string
    match_resource_types = optional(list(string))
  })))
  default = []
}

variable "backup_policy_plan" {
  type = list(map(object({
    id               = number
    backup_policy_id = any
    cron_spec        = string
    active           = optional(bool, false)
    attach_user_tags = optional(list(string))
    copy_user_tags   = optional(list(string))
    name             = optional(string)
    clone_policy = optional(list(object({
      max_snapshots = optional(number)
      zones         = optional(list(string))
    })), [])
    deletion_trigger = optional(list(object({
      delete_after      = optional(number)
      delete_over_count = optional(string)
    })), [])
    remote_region_policy = optional(list(object({
      delete_over_account = optional(number)
      encryption_key      = optional(string)
      region              = optional(string)
    })), [])
  })))
  default = []
}

variable "bare_metal_server" {
  type = list(map(object({
    id                 = number
    image              = string
    keys               = list(any)
    profile            = string
    zone               = string
    access_tags        = optional(list(string))
    delete_type        = optional(string)
    enable_secure_boot = optional(bool, false)
    name               = optional(string)
    user_data          = optional(string)
    vpc                = optional(any)
    trusted_platform_module = optional(list(object({
      mode = optional(string)
    })), [])
    network_interfaces = optional(list(object({
      name                      = string
      subnet                    = any
      allow_ip_spoofing         = optional(bool, false)
      allowed_vlans             = optional(list(string))
      enable_infrastructure_nat = optional(bool, false)
      vlan                      = optional(number)
      primary_ip = optional(list(object({
        address     = optional(string)
        auto_delete = optional(bool, false)
        name        = optional(string)
        reserved_ip = optional(string)
      })), [])
    })), [])
    primary_network_interface = optional(list(object({
      name                      = string
      subnet                    = any
      allow_ip_spoofing         = optional(bool, false)
      allowed_vlans             = optional(list(string))
      enable_infrastructure_nat = optional(bool, false)
      vlan                      = optional(number)
      primary_ip = optional(list(object({
        address     = optional(string)
        auto_delete = optional(bool, false)
        name        = optional(string)
        reserved_ip = optional(string)
      })), [])
    })), [])
  })))
  default = []
}

variable "bare_metal_server_action" {
  type = list(map(object({
    id                = number
    action            = string
    bare_metal_server = any
    stop_type         = optional(string)
  })))
  default = []
}

variable "bare_metal_server_disk" {
  type = list(map(object({
    id                = number
    bare_metal_server = any
    disk              = any
    name              = optional(string)
  })))
  default = []
}

variable "bare_metal_server_network_interface" {
  type = list(map(object({
    id                        = number
    bare_metal_server         = any
    subnet                    = any
    allowed_vlans             = optional(list(string))
    enable_infrastructure_nat = optional(bool, false)
    hard_stop                 = optional(bool, false)
    interface_type            = optional(string)
    name                      = optional(string)
    security_groups           = optional(list(string))
    vlan                      = optional(number)
    primary_ip = optional(list(object({
      address     = optional(string)
      auto_delete = optional(bool, false)
      name        = optional(string)
      reserved_ip = optional(string)
    })), [])
  })))
  default = []
}

variable "bare_metal_server_network_interface_allow_float" {
  type = list(map(object({
    id                        = number
    bare_metal_server         = any
    subnet                    = any
    vlan                      = number
    allow_ip_spoofing         = bool
    enable_infrastructure_nat = optional(bool, false)
    name                      = optional(string)
    security_groups           = optional(list(string))
    primary_ip = optional(list(object({
      address     = optional(string)
      auto_delete = optional(bool, false)
      name        = optional(string)
      reserved_ip = optional(string)
    })), [])
  })))
  default = []
}

variable "bare_metal_server_network_interface_floating_ip" {
  type = list(map(object({
    id                = number
    bare_metal_server = any
    floating_ip       = any
    network_interface = any
  })))
  default = []
}

variable "dedicated_host" {
  type = list(map(object({
    id                         = number
    host_group                 = any
    profile                    = string
    access_tags                = optional(list(string))
    instance_placement_enabled = optional(bool, false)
    name                       = optional(string)
  })))
  default = []
}

variable "dedicated_host_disk_management" {
  type = list(map(object({
    id             = number
    dedicated_host = any
    disks = optional(list(object({
      id   = optional(any)
      name = optional(string)
    })), [])
  })))
  default = []
}

variable "dedicated_host_group" {
  type = list(map(object({
    id     = number
    class  = string
    family = string
    zone   = string
    name   = optional(string)
  })))
  default = []
}

variable "floating_ip" {
  type = list(map(object({
    id          = number
    name        = string
    access_tags = optional(list(string))
    target      = optional(string)
    tags        = optional(list(string))
    zone        = optional(string)
  })))
  default = []
}

variable "bucket" {
  type = list(map(object({
    id                   = number
    bucket_name          = string
    resource_instance_id = any
    region_location      = optional(string)
    storage_class        = optional(string)
  })))
  default = []
}

variable "flow_log" {
  type = list(map(object({
    id             = number
    name           = string
    storage_bucket = any
    target         = any
    access_tags    = optional(list(string))
    active         = optional(bool, false)
    tags           = optional(list(string))
  })))
  default = []
}

variable "ike_policy" {
  type = list(map(object({
    id                       = number
    authentication_algorithm = string
    dh_group                 = number
    encryption_algorithm     = string
    name                     = string
    ike_version              = optional(number)
    key_lifetime             = optional(number)
  })))
  default = []
}

variable "image" {
  type = list(map(object({
    id                 = number
    name               = string
    access_tags        = optional(list(string))
    encrypted_data_key = optional(string)
    encryption_key     = optional(string)
    href               = optional(string)
    operating_system   = optional(string)
    source_volume      = optional(string)
    tags               = optional(list(string))
  })))
  default = []
}

variable "image_export_job" {
  type = list(map(object({
    id     = number
    image  = any
    format = string
    name   = string
    storage_bucket = optional(list(object({
      name = optional(string)
      crn  = optional(any)
    })), [])
  })))
  default = []
}

variable "instance" {
  type = list(map(object({
    id                                = number
    name                              = string
    access_tags                       = optional(list(string))
    action                            = optional(string)
    auto_delete_volume                = optional(bool, false)
    availability_policy_host_failure  = optional(string)
    dedicated_host                    = optional(any)
    dedicated_host_group              = optional(any)
    default_trusted_profile_auto_link = optional(bool, false)
    default_trusted_profile_target    = optional(string)
    force_recovery_time               = optional(bool, false)
    image                             = optional(any)
    keys                              = optional(list(string))
    placement_group                   = optional(any)
    profile                           = optional(string)
    instance_template                 = optional(any)
    tags                              = optional(list(string))
    total_volume_bandwidth            = optional(number)
    user_data                         = optional(string)
    vpc                               = optional(any)
    zone                              = optional(string)
    network_interfaces = optional(list(object({
      name                      = string
      subnet                    = any
      allow_ip_spoofing         = optional(bool, false)
      allowed_vlans             = optional(list(string))
      enable_infrastructure_nat = optional(bool, false)
      vlan                      = optional(number)
      primary_ip = optional(list(object({
        address     = optional(string)
        auto_delete = optional(bool, false)
        name        = optional(string)
        reserved_ip = optional(string)
      })), [])
    })), [])
    primary_network_interface = optional(list(object({
      name                      = string
      subnet                    = any
      allow_ip_spoofing         = optional(bool, false)
      allowed_vlans             = optional(list(string))
      enable_infrastructure_nat = optional(bool, false)
      vlan                      = optional(number)
      primary_ip = optional(list(object({
        address     = optional(string)
        auto_delete = optional(bool, false)
        name        = optional(string)
        reserved_ip = optional(string)
      })), [])
    })), [])
    metadata_service = optional(list(object({
      enabled            = optional(bool, false)
      protocol           = optional(string)
      response_hop_limit = optional(number)
    })), [])
    catalog_offering = optional(list(object({
      offering_crn = optional(any)
      version_crn  = optional(any)
    })), [])
    boot_volume = optional(list(object({
      auto_delete_volume = optional(bool, false)
      encryption         = optional(string)
      name               = optional(string)
      size               = optional(number)
      snapshot           = optional(any)
      volume_id          = optional(any)
      tags               = optional(list(string))
    })), [])
  })))
  default = []
}

variable "instance_action" {
  type = list(map(object({
    id           = number
    action       = string
    instance     = any
    force_action = optional(bool, false)
  })))
  default = []
}

variable "instance_disk_management" {
  type = list(map(object({
    id       = number
    instance = any
    disks = optional(list(object({
      id   = any
      name = string
    })), [])
  })))
  default = []
}

variable "instance_group" {
  type = list(map(object({
    id                 = number
    instance_template  = any
    name               = string
    subnets            = list(any)
    access_tags        = optional(list(string))
    application_port   = optional(number)
    load_balancer      = optional(any)
    load_balancer_pool = optional(any)
    instance_count     = optional(number)
  })))
  default = []
}

variable "instance_group_manager" {
  type = list(map(object({
    id                   = number
    instance_group       = any
    aggregation_window   = optional(number)
    cooldown             = optional(number)
    enable_manager       = optional(bool, false)
    manager_type         = optional(string)
    max_membership_count = optional(number)
    min_membership_count = optional(number)
    name                 = optional(string)
  })))
  default = []
}

variable "instance_group_manager_action" {
  type = list(map(object({
    id                     = number
    instance_group         = any
    instance_group_manager = any
    membership_count       = optional(number)
    max_membership_count   = optional(number)
    min_membership_count   = optional(number)
    name                   = optional(string)
    run_at                 = optional(string)
    cron_spec              = optional(string)
    target_manager         = optional(any)
  })))
  default = []
}

variable "instance_group_manager_policy" {
  type = list(map(object({
    id                     = number
    instance_group         = any
    instance_group_manager = any
    metric_type            = string
    metric_value           = number
    policy_type            = string
  })))
  default = []
}

variable "instance_group_membership" {
  type = list(map(object({
    id                        = number
    instance_group            = any
    instance_group_membership = any
    name                      = optional(string)
    action_delete             = optional(bool, false)
  })))
  default = []
}

variable "instance_network_interface" {
  type = list(map(object({
    id                = number
    instance          = any
    name              = string
    subnet            = any
    floating_ip       = optional(any)
    allow_ip_spoofing = optional(bool, false)
    security_groups   = optional(list(any))
    primary_ip = optional(list(object({
      address     = optional(string)
      auto_delete = optional(bool, false)
      name        = optional(string)
      reserved_ip = optional(string)
    })), [])
  })))
  default = []
}

variable "instance_network_interface_floating_ip" {
  type = list(map(object({
    id                = number
    floating_ip       = any
    instance          = any
    network_interface = any
  })))
  default = []
}

variable "instance_template" {
  type = list(map(object({
    id                                = number
    keys                              = list(string)
    profile                           = string
    vpc                               = any
    zone                              = string
    availability_policy_host_failure  = optional(string)
    dedicated_host                    = optional(any)
    dedicated_host_group              = optional(any)
    default_trusted_profile_auto_link = optional(bool, false)
    default_trusted_profile_target    = optional(string)
    name                              = optional(string)
    placement_group                   = optional(any)
    total_volume_bandwidth            = optional(number)
    user_data                         = optional(string)
    network_interfaces = optional(list(object({
      name                      = string
      subnet                    = any
      allow_ip_spoofing         = optional(bool, false)
      allowed_vlans             = optional(list(string))
      enable_infrastructure_nat = optional(bool, false)
      vlan                      = optional(number)
      primary_ip = optional(list(object({
        address     = optional(string)
        auto_delete = optional(bool, false)
        name        = optional(string)
        reserved_ip = optional(string)
      })), [])
    })), [])
    primary_network_interface = optional(list(object({
      name                      = string
      subnet                    = any
      allow_ip_spoofing         = optional(bool, false)
      allowed_vlans             = optional(list(string))
      enable_infrastructure_nat = optional(bool, false)
      vlan                      = optional(number)
      primary_ip = optional(list(object({
        address     = optional(string)
        auto_delete = optional(bool, false)
        name        = optional(string)
        reserved_ip = optional(string)
      })), [])
    })), [])
    metadata_service = optional(list(object({
      enabled            = optional(bool, false)
      protocol           = optional(string)
      response_hop_limit = optional(number)
    })), [])
    catalog_offering = optional(list(object({
      offering_crn = optional(any)
      version_crn  = optional(any)
    })), [])
    boot_volume = optional(list(object({
      auto_delete_volume = optional(bool, false)
      encryption         = optional(string)
      name               = optional(string)
      size               = optional(number)
      snapshot           = optional(any)
      volume_id          = optional(any)
      tags               = optional(list(string))
    })), [])
  })))
  default = []
}

variable "instance_volume_attachment" {
  type = list(map(object({
    id                                 = number
    instance                           = any
    capacity                           = number
    delete_volume_on_attachment_delete = optional(bool, false)
    delete_volume_on_instance_delete   = optional(bool, false)
    encryption_key                     = optional(string)
    iops                               = optional(number)
    id                                 = optional(string)
    name                               = optional(string)
    profile                            = optional(string)
    snapshot                           = optional(string)
    volume                             = optional(any)
    volume_name                        = optional(string)
    tags                               = optional(list(string))
  })))
  default = []
}

variable "ipsec_policy" {
  type = list(map(object({
    id                       = number
    authentication_algorithm = string
    encryption_algorithm     = string
    name                     = string
    pfs                      = string
    key_lifetime             = optional(number)
  })))
  default = []
}

variable "lb" {
  type = list(map(object({
    id              = number
    name            = string
    subnets         = list(any)
    access_tags     = optional(list(string))
    logging         = optional(bool, false)
    profile         = optional(string)
    route_mode      = optional(string)
    security_groups = optional(list(any))
    tags            = optional(list(string))
    type            = optional(string)
    dns = optional(list(object({
      instance_crn = any
      zone_id      = any
    })), [])
  })))
  default = []
}

variable "lb_listener" {
  type = list(map(object({
    id                         = number
    lb                         = any
    protocol                   = string
    port                       = optional(number)
    port_min                   = optional(number)
    port_max                   = optional(number)
    default_pool               = optional(string)
    certificate_instance       = optional(string)
    connection_limit           = optional(number)
    idle_connection_timeout    = optional(number)
    https_redirect_listener    = optional(string)
    https_redirect_status_code = optional(number)
    https_redirect_uri         = optional(string)
    accept_proxy_protocol      = optional(bool, false)
  })))
  default = []
}

variable "lb_listener_policy" {
  type = list(map(object({
    id                                = number
    action                            = string
    lb                                = any
    listener                          = any
    priority                          = number
    name                              = optional(string)
    target_id                         = optional(any)
    target_url                        = optional(string)
    target_http_status_code           = optional(number)
    target_https_redirect_listener    = optional(any)
    target_https_redirect_uri         = optional(string)
    target_https_redirect_status_code = optional(number)
    rules = optional(list(object({
      condition = string
      type      = string
      value     = string
      field     = optional(string)
    })), [])
  })))
  default = []
}

variable "lb_listener_policy_rule" {
  type = list(map(object({
    id        = number
    condition = string
    lb        = any
    listener  = any
    policy    = any
    type      = string
    value     = string
    field     = optional(string)
  })))
  default = []
}

variable "lb_pool" {
  type = list(map(object({
    id                                  = number
    algorithm                           = string
    health_delay                        = number
    health_retries                      = number
    health_timeout                      = number
    health_type                         = string
    lb                                  = any
    name                                = string
    protocol                            = string
    health_monitor_url                  = optional(string)
    health_monitor_port                 = optional(number)
    proxy_protocol                      = optional(string)
    session_persistence_type            = optional(string)
    session_persistence_app_cookie_name = optional(string)
  })))
  default = []
}

variable "lb_pool_member" {
  type = list(map(object({
    id             = number
    lb             = any
    pool           = any
    port           = number
    target_address = optional(string)
    target_id      = optional(any)
    weight         = optional(number)
  })))
  default = []
}

variable "network_acl" {
  type = list(map(object({
    id          = number
    access_tags = optional(list(string))
    name        = optional(string)
    tags        = optional(list(string))
    vpc         = optional(any)
    rules = optional(list(object({
      action      = string
      destination = string
      direction   = string
      name        = string
      source      = string
      udp = optional(list(object({
        port_max        = optional(number)
        port_min        = optional(number)
        source_port_max = optional(number)
        source_port_min = optional(number)
      })), [])
      tcp = optional(list(object({
        port_max        = optional(number)
        port_min        = optional(number)
        source_port_max = optional(number)
        source_port_min = optional(number)
      })), [])
      icmp = optional(list(object({
        code = optional(number)
        type = optional(number)
      })), [])
    })), [])
  })))
  default = []
}

variable "network_acl_rule" {
  type = list(map(object({
    id          = number
    action      = string
    destination = string
    direction   = string
    network_acl = any
    source      = string
    before      = optional(string)
    udp = optional(list(object({
      port_max        = optional(number)
      port_min        = optional(number)
      source_port_max = optional(number)
      source_port_min = optional(number)
    })), [])
    tcp = optional(list(object({
      port_max        = optional(number)
      port_min        = optional(number)
      source_port_max = optional(number)
      source_port_min = optional(number)
    })), [])
    icmp = optional(list(object({
      code = optional(number)
      type = optional(number)
    })), [])
  })))
  default = []
}

variable "placement_group" {
  type = list(map(object({
    id          = number
    name        = string
    strategy    = string
    access_tags = optional(list(string))
    tags        = optional(list(string))
  })))
  default = []
}

variable "public_gateway" {
  type = list(map(object({
    id          = number
    name        = string
    vpc         = any
    zone        = string
    access_tags = optional(list(string))
    floating_ip = optional(map(any))
    id          = optional(string)
    tags        = optional(list(string))
  })))
  default = []
}

variable "security_group" {
  type = list(map(object({
    id          = number
    vpc         = any
    name        = optional(string)
    access_tags = optional(list(string))
    tags        = optional(list(string))
  })))
  default = []
}

variable "security_group_rule" {
  type = list(map(object({
    id         = number
    direction  = string
    group      = any
    ip_version = optional(string)
    remote     = optional(string)
    udp = optional(list(object({
      port_max        = optional(number)
      port_min        = optional(number)
      source_port_max = optional(number)
      source_port_min = optional(number)
    })), [])
    tcp = optional(list(object({
      port_max        = optional(number)
      port_min        = optional(number)
      source_port_max = optional(number)
      source_port_min = optional(number)
    })), [])
    icmp = optional(list(object({
      code = optional(number)
      type = optional(number)
    })), [])
  })))
  default = []
}

variable "security_group_target" {
  type = list(map(object({
    id             = number
    security_group = any
    target         = any
  })))
  default = []
}

variable "virtual_endpoint_gateway" {
  type = list(map(object({
    id              = number
    name            = string
    vpc             = any
    access_tags     = optional(list(string))
    security_groups = optional(list(any))
    tags            = optional(list(string))
    ips = optional(list(object({
      id     = optional(string)
      name   = optional(string)
      subnet = optional(string)
    })), [])
    target = optional(list(object({
      resource_type = optional(string)
      crn           = optional(string)
      name          = optional(string)
    })), [])
  })))
  default = []
}

variable "virtual_endpoint_gateway_ip" {
  type = list(map(object({
    id          = number
    gateway     = any
    reserved_ip = any
  })))
  default = []
}

variable "volume" {
  type = list(map(object({
    id                   = number
    name                 = string
    profile              = string
    zone                 = string
    access_tags          = optional(list(string))
    capacity             = optional(number)
    delete_all_snapshots = optional(bool, false)
    encryption_key       = optional(string)
    iops                 = optional(string)
    source_snapshot      = optional(string)
    tags                 = optional(list(string))
  })))
  default = []
}

variable "vpn_server" {
  type = list(map(object({
    id                     = number
    certificate_crn        = any
    client_ip_pool         = any
    subnets                = list(any)
    access_tags            = optional(list(string))
    client_dns_server_ips  = optional(list(any))
    client_idle_timeout    = optional(number)
    enable_split_tunneling = optional(bool, false)
    name                   = optional(string)
    port                   = optional(number)
    protocol               = optional(string)
    security_groups        = optional(list(any))
    client_authentication = optional(list(object({
      method            = string
      identity_provider = optional(string)
      client_ca_crn     = optional(string)
    })), [])
  })))
  default = []
}

variable "vpn_server_client" {
  type = list(map(object({
    id         = number
    vpn_client = any
    vpn_server = string
    delete     = optional(bool, false)
  })))
  default = []
}

variable "vpn_server_route" {
  type = list(map(object({
    id          = number
    destination = string
    vpn_server  = any
    action      = optional(string)
    name        = optional(string)
  })))
  default = []
}

variable "vpn_gateway" {
  type = list(map(object({
    id          = number
    name        = string
    subnet      = any
    mode        = optional(string)
    tags        = optional(list(string))
    access_tags = optional(list(string))
  })))
  default = []
}

variable "vpn_gateway_connection" {
  type = list(map(object({
    id             = number
    name           = string
    peer_address   = string
    preshared_key  = string
    vpn_gateway    = any
    action         = optional(string)
    admin_state_up = optional(bool, false)
    ike_policy     = optional(any)
    interval       = optional(string)
    ipsec_policy   = optional(any)
    local_cidrs    = optional(list(string))
    peer_cidrs     = optional(list(string))
    timeout        = optional(number)
  })))
  default = []
}