variable "vpn_gateways_name" {
  type        = string
  default     = null
  description = <<-EOT
Regex that matches the vpn gateway name to be used as datasource.
EOT
}

variable "vpn_gateway_vpn_attachments_name" {
  type        = string
  default     = null
  description = <<-EOT
Regex that matches the vpn gateway attachment name to be used as datasource.
EOT
}

variable "cen_instances_name" {
  type        = string
  default     = null
  description = <<-EOT
Regex that matches the cen instance name to be used as datasource
EOT
}

variable "cen_transit_routers_name" {
  type        = string
  default     = null
  description = <<-EOT
Regex that matches the cen transit router name to be used as datasource
EOT
}

variable "cen_transit_router_vpn_attachments_name" {
  type        = string
  default     = null
  description = <<-EOT
Regex that matches the cen transit router vpn attachment name to be used as datasource
EOT
}

variable "vpn_customer_gateways_name" {
  type        = string
  default     = null
  description = <<-EOT
Regex that matches the vpn customer gateway name to be used as datasource
EOT
}

variable "ssl_vpn_servers_name" {
  type        = string
  default     = null
  description = <<-EOT
Regex that matches the vpn ssl server name to be used as datasource
EOT
}

variable "vpn_connections_name" {
  type        = string
  default     = null
  description = <<-EOT
Regex that matches the vpn connection name to be used as datasource
EOT
}

variable "available_resource_creation" {
  type    = string
  default = null
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Generic tags"
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

variable "cen_instance" {
  type = list(map(object({
    id                = number
    cen_instance_name = optional(string)
    name              = optional(string)
    description       = optional(string)
    tags              = optional(map(string))
    protection_level  = optional(string)
  })))
  default     = []
  description = <<-EOT
Provides a CEN instance resource. Cloud Enterprise Network (CEN) is a service that allows you to create a global network for rapidly building a distributed business system with a hybrid cloud computing solution. CEN enables you to build a secure, private, and enterprise-class interconnected network between VPCs in different regions and your local data centers. CEN provides enterprise-class scalability that automatically responds to your dynamic computing requirements.
EOT
}

variable "cen_transit_router" {
  type = list(map(object({
    id                         = number
    cen_id                     = any
    transit_router_name        = optional(string)
    transit_router_description = optional(string)
    support_multicast          = optional(bool, false)
    dry_run                    = optional(bool, false)
    tags                       = optional(map(string))
  })))
  default     = []
  description = "Provides a CEN transit router resource that associate the transitRouter with the CEN instance."
}

variable "cen_transit_router_cidr" {
  type = list(map(object({
    id                       = number
    cidr                     = string
    transit_router_id        = any
    transit_router_cidr_name = optional(string)
    description              = optional(string)
    publish_cidr_route       = optional(bool, false)
  })))
  default     = []
  description = "Provides a Cloud Enterprise Network (CEN) Transit Router Cidr resource."
}

variable "cen_transit_router_vpn_attachment" {
  type = list(map(object({
    id                                    = number
    transit_router_id                     = any
    vpn_id                                = any
    auto_publish_route_enabled            = optional(bool, false)
    cen_id                                = optional(any)
    transit_router_attachment_description = optional(string)
    transit_router_attachment_name        = optional(string)
    vpn_owner_id                          = optional(string)
    tags                                  = optional(map(string))
    zone = optional(list(object({
      zone_id = string
    })), [])
  })))
  default     = []
  description = <<-EOT
Provides a Cloud Enterprise Network (CEN) Transit Router Vpn Attachment resource.
EOT
}

variable "ssl_vpn_client_cert" {
  type = list(map(object({
    id                = number
    ssl_vpn_server_id = any
    name              = optional(string)
  })))
  default     = []
  description = "Provides a SSL VPN client cert resource."
}

variable "ssl_vpn_server" {
  type = list(map(object({
    id             = number
    client_ip_pool = string
    local_subnet   = string
    vpn_gateway_id = any
    name           = optional(string)
    protocol       = optional(string)
    cipher         = optional(string)
    port           = optional(number)
    compress       = optional(bool, false)
  })))
  default     = []
  description = "Provides a SSL VPN server resource."
}

variable "gateway" {
  type = list(map(object({
    id                   = number
    bandwidth            = number
    vpc_id               = any
    instance_charge_type = optional(string)
    period               = optional(number)
    enable_ipsec         = optional(bool, false)
    enable_ssl           = optional(bool, false)
    ssl_connections      = optional(number)
    description          = optional(string)
    vswitch_id           = optional(string)
    tags                 = optional(map(string))
    auto_pay             = optional(bool, false)
    auto_propagate       = optional(bool, false)
    network_type         = optional(string)
  })))
  default     = []
  description = "Provides a VPN gateway resource."
}

variable "customer_gateway" {
  type = list(map(object({
    id          = number
    ip_address  = string
    name        = optional(string)
    description = optional(string)
    asn         = optional(string)
  })))
  default     = []
  description = "Provides a VPN customer gateway resource."
}

variable "gateway_vpn_attachment" {
  type = list(map(object({
    id                   = number
    customer_gateway_id  = any
    local_subnet         = string
    remote_subnet        = string
    effect_immediately   = optional(bool, false)
    enable_dpd           = optional(bool, false)
    enable_nat_traversal = optional(bool, false)
    network_type         = optional(string)
    vpn_attachment_name  = optional(string)
    ike_config = optional(list(object({
      psk           = optional(string)
      ike_version   = optional(string)
      ike_mode      = optional(string)
      ike_enc_alg   = optional(string)
      ike_auth_alg  = optional(string)
      ike_pfs       = optional(string)
      ike_lifetime  = optional(number)
      ike_local_id  = optional(string)
      ike_remote_id = optional(string)
    })), [])
    ipsec_config = optional(list(object({
      ipsec_enc_alg  = optional(string)
      ipsec_auth_alg = optional(string)
      ipsec_pfs      = optional(string)
      ipsec_lifetime = optional(number)
    })), [])
    bgp_config = optional(list(object({
      enable       = optional(bool, false)
      local_asn    = optional(string)
      tunnel_cidr  = optional(string)
      local_bgp_ip = optional(string)
    })), [])
    health_check_config = optional(list(object({
      enable   = optional(bool, false)
      dip      = optional(string)
      sip      = optional(string)
      interval = optional(number)
      retry    = optional(number)
    })), [])
  })))
  default     = []
  description = <<-EOT
  Provides a VPN Gateway Vpn Attachment resource. Créer une connexion IPsec.
EOT
}

variable "connection" {
  type = list(map(object({
    id                   = number
    customer_gateway_id  = any
    local_subnet         = list(string)
    remote_subnet        = list(string)
    vpn_gateway_id       = any
    effect_immediately   = optional(bool, false)
    enable_dpd           = optional(bool, false)
    enable_nat_traversal = optional(bool, false)
    ike_config = optional(list(object({
      psk           = optional(string)
      ike_version   = optional(string)
      ike_mode      = optional(string)
      ike_enc_alg   = optional(string)
      ike_auth_alg  = optional(string)
      ike_pfs       = optional(string)
      ike_lifetime  = optional(number)
      ike_local_id  = optional(string)
      ike_remote_id = optional(string)
    })), [])
    ipsec_config = optional(list(object({
      ipsec_enc_alg  = optional(string)
      ipsec_auth_alg = optional(string)
      ipsec_pfs      = optional(string)
      ipsec_lifetime = optional(number)
    })), [])
    bgp_config = optional(list(object({
      enable       = optional(bool, false)
      local_asn    = optional(string)
      tunnel_cidr  = optional(string)
      local_bgp_ip = optional(string)
    })), [])
    health_check_config = optional(list(object({
      enable   = optional(bool, false)
      dip      = optional(string)
      sip      = optional(string)
      interval = optional(number)
      retry    = optional(number)
    })), [])
  })))
  description = "Provides a VPN connection resource."
}

variable "gateway_vco_route" {
  type = list(map(object({
    id         = number
    vpn_id     = any
    route_dest = string
    weight     = number
  })))
  default     = []
  description = <<-EOT
  Provides a VPN Gateway Vco Route resource. Ajoute une entrée de route de destination pour une connexion IPsec
EOT
}

variable "ipsec_server" {
  type = list(map(object({
    id                 = number
    client_ip_pool     = string
    local_subnet       = string
    vpn_gateway_id     = any
    dry_run            = optional(bool, false)
    effect_immediately = optional(bool, false)
    ipsec_server_name  = optional(string)
    psk                = optional(string)
    psk_enabled        = optional(bool, false)
    ike_config = optional(list(object({
      psk           = optional(string)
      ike_version   = optional(string)
      ike_mode      = optional(string)
      ike_enc_alg   = optional(string)
      ike_auth_alg  = optional(string)
      ike_pfs       = optional(string)
      ike_lifetime  = optional(number)
      ike_local_id  = optional(string)
      ike_remote_id = optional(string)
    })), [])
    ipsec_config = optional(list(object({
      ipsec_enc_alg  = optional(string)
      ipsec_auth_alg = optional(string)
      ipsec_pfs      = optional(string)
      ipsec_lifetime = optional(number)
    })), [])
  })))
  default     = []
  description = "Creates an IPsec server."
}

variable "pbr_route_entry" {
  type = list(map(object({
    id             = number
    connection_id  = any
    publish_vpc    = bool
    route_dest     = string
    route_source   = string
    vpn_gateway_id = any
    weight         = number
  })))
  default     = []
  description = "Create a Policy Based Route entry for a VPN Gateway."
}

variable "route_entry" {
  type = list(map(object({
    id             = number
    next_hop       = string
    publish_vpc    = bool
    route_dest     = string
    vpn_gateway_id = any
    weight         = number
  })))
  default     = []
  description = "Provides a VPN Route Entry resource."
}