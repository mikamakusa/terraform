# Application Policies Cisco Terraform Module documentation

## How to use it ?
### main.tf
```hcl
module "application_policies" {
  source              = "../../../modules/Cisco/Application_Policies"
  application_profile = {
    intranet = {
      tdn = "uni/vmmp-VMware/dom-aci_terraform_lab"
    }
  }
  bridge_domain = {
    prod = {
      tenant_dn              = "terraform-tenant"
      optimize_wan_bandwidth = "yes"
      ep_move_detect_mode    = "enable"
    }
  }
  contract = {
    https = {},
    sql   = {}
  }
  filter = {
    https = {
      prot        = "tcp"
      d_from_port = "443"
      d_to_port   = "443"
    },
    sql = {
      prot        = "tcp"
      d_from_port = "1433"
      d_to_port   = "1433"
    }
  }
  subnet = {
    "10.10.101.1/24" = {
      parent_dn = "prod_bd"
    }
  }
  tenant = {
    terraform-tenant = {}
  }
  vrf = {
    prod = {
      tenant_dn          = "terraform-tenant"
      bd_enforced_enable = "yes"
    }
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | 2.6.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | 2.6.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aci_application_profile.application_profile](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/application_profile) | resource |
| [aci_bridge_domain.bridge_domain](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/bridge_domain) | resource |
| [aci_contract.contract](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/contract) | resource |
| [aci_contract_subject.contract_subject](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/contract_subject) | resource |
| [aci_epg_to_contract.epg_to_contract](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/epg_to_contract) | resource |
| [aci_epg_to_domain.epg_to_domain](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/epg_to_domain) | resource |
| [aci_filter.filter](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/filter) | resource |
| [aci_filter_entry.filter_entry](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/filter_entry) | resource |
| [aci_subnet.subnet](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/subnet) | resource |
| [aci_tenant.tenant](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/tenant) | resource |
| [aci_vrf.vrf](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/vrf) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_profile"></a> [application\_profile](#input\_application\_profile) | n/a | <pre>map(object({<br>    tenant_dn             = string<br>    annotation            = optional(string)<br>    description           = optional(string)<br>    name_alias            = optional(string)<br>    prio                  = optional(string)<br>    tdn                   = string<br>    annotation            = optional(string)<br>    binding_type          = optional(string)<br>    allow_micro_seg       = optional(string)<br>    custom_epg_name       = optional(string)<br>    enhanced_lag_policy   = optional(string)<br>    delimiter             = optional(string)<br>    encap                 = optional(string)<br>    encap_mode            = optional(string)<br>    epg_cos               = optional(string)<br>    epg_cos_pref          = optional(string)<br>    instr_imedcy          = optional(string)<br>    netflow_dir           = optional(string)<br>    netflow_pref          = optional(string)<br>    num_ports             = optional(string)<br>    port_allocation       = optional(string)<br>    primary_encap         = optional(string)<br>    primary_encap_inner   = optional(string)<br>    res_imedcy            = optional(string)<br>    secondary_encap_inner = optional(string)<br>    switching_mode        = optional(string)<br>    vmm_allow_promiscuous = optional(string)<br>    vmm_forged_transmits  = optional(string)<br>    vmm_mac_changes       = optional(string)<br>    match_t               = optional(string)<br>    contract_type         = string<br>    contract              = string<br>  }))</pre> | n/a | yes |
| <a name="input_bridge_domain"></a> [bridge\_domain](#input\_bridge\_domain) | Manages ACI Bridge Domain with following flags :<br>      - optimize\_wan\_bandwidth which enable it or not.<br>      - arp\_fllod is a property to specify if arp flooding is enabled.<br>      - ep\_clear represents the parameter used by the node (i.e. Leaf) to clear all EPs in all leaves for this BD<br>      - host\_based\_routing enables advertising host routes<br>      - mcast\_allow which enable or not multicast | <pre>map(object({<br>    tenant_dn                   = string<br>    optimize_wan_bandwidth      = optional(string)<br>    annotation                  = optional(string)<br>    description                 = optional(string)<br>    arp_flood                   = optional(string)<br>    ep_clear                    = optional(string)<br>    ep_move_detect_mode         = optional(string)<br>    host_based_routing          = optional(string)<br>    intersite_bum_traffic_allow = optional(string)<br>    intersite_l2_stretch        = optional(string)<br>    ip_learning                 = optional(string)<br>    ipv6_mcast_allow            = optional(string)<br>    limit_ip_learn_to_subnets   = optional(string)<br>    ll_addr                     = optional(string)<br>    mac                         = optional(string)<br>    mcast_allow                 = optional(string)<br>    multi_dst_pkt_act           = optional(string)<br>    name_alias                  = optional(string)<br>    bridge_domain_type          = optional(string)<br>    unicast_route               = optional(string)<br>    unk_mac_ucast_act           = optional(string)<br>    unk_mcast_act               = optional(string)<br>    v6unk_mcast_act             = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_contract"></a> [contract](#input\_contract) | Manages ACI Contract with priority level, scope that allows communication with epgs with the same application profile and the target differentiated service code point. | <pre>map(object({<br>    tenant_dn     = string<br>    description   = optional(string)<br>    annotation    = optional(string)<br>    name_alias    = optional(string)<br>    prio          = optional(string)<br>    scope         = optional(string)<br>    target_dscp   = optional(string)<br>    cons_match_t  = optional(string)<br>    prov_match_t  = optional(string)<br>    rev_flt_ports = optional(string)<br>    target_dscp   = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_filter"></a> [filter](#input\_filter) | n/a | <pre>map(object({<br>    tenant_dn     = string<br>    description   = optional(string)<br>    annotation    = optional(string)<br>    name_alias    = optional(string)<br>    apply_to_frag = optional(string)<br>    arp_opc       = optional(string)<br>    d_from_port   = optional(string)<br>    d_to_port     = optional(string)<br>    ether_t       = optional(string)<br>    icmpv4_t      = optional(string)<br>    icmpv6_t      = optional(string)<br>    match_dscp    = optional(string)<br>    name_alias    = optional(string)<br>    prot          = optional(string)<br>    s_from_port   = optional(string)<br>    s_to_port     = optional(string)<br>    stateful      = optional(string)<br>    tcp_rules     = optional(list(string))<br>  }))</pre> | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | Manages ACI Subnets with the following flags :<br>      - *ctrl* is an optional flag which control subnet state with allowed values such as 'unspecified', 'querier', 'nd' and 'no-default-gateway'.<br>      - *scope* indicate the subnet visibility with multiple values,<br>      - *preferred* indicate if the subnet is prefered over every available alternatives | <pre>map(object({<br>    parent_dn   = string<br>    annotation  = optional(string)<br>    description = optional(string)<br>    ctrl        = optional(list(string))<br>    name_alias  = optional(string)<br>    preferred   = optional(string)<br>    scope       = optional(list(string))<br>    virtual     = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | Manages ACI tenant | <pre>map(object({<br>    annotation  = optional(string)<br>    name_alias  = optional(string)<br>    description = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_vrf"></a> [vrf](#input\_vrf) | Manages ACI VRF :<br>      - bd\_enforced\_enabled is a flag used to enable or disable bridge domain for VRF.<br>      - ip\_data\_plane\_learning specifies if known multicast is forwarded or not.<br>      - pc\_enf\_dir is about Policy Control Direction Enforcement, allowed values are 'egress' and 'ingress'<br>      - pc\_enf\_pref determines if the fabric should enforce contract policies to allow routing and packet forwarding | <pre>map(object({<br>    tenant_dn              = string<br>    annotation             = optional(string)<br>    description            = optional(string)<br>    bd_enforced_enable     = optional(string)<br>    ip_data_plane_learning = optional(string)<br>    knw_mcast_act          = optional(string)<br>    name_alias             = optional(string)<br>    pc_enf_dir             = optional(string)<br>    pc_enf_pref            = optional(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_profile"></a> [application\_profile](#output\_application\_profile) | n/a |
| <a name="output_bridge_domain"></a> [bridge\_domain](#output\_bridge\_domain) | n/a |
| <a name="output_contract"></a> [contract](#output\_contract) | n/a |
| <a name="output_epg_to_contract"></a> [epg\_to\_contract](#output\_epg\_to\_contract) | n/a |
| <a name="output_epg_to_domain"></a> [epg\_to\_domain](#output\_epg\_to\_domain) | n/a |
| <a name="output_filter"></a> [filter](#output\_filter) | n/a |
| <a name="output_filter_entry"></a> [filter\_entry](#output\_filter\_entry) | n/a |
| <a name="output_subnet"></a> [subnet](#output\_subnet) | n/a |
| <a name="output_tenant"></a> [tenant](#output\_tenant) | n/a |
| <a name="output_vrf"></a> [vrf](#output\_vrf) | n/a |

