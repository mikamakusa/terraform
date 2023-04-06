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
| [aci_access_generic.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/access_generic) | resource |
| [aci_access_switch_policy_group.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/access_switch_policy_group) | resource |
| [aci_attachable_access_entity_profile.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/attachable_access_entity_profile) | resource |
| [aci_cdp_interface_policy.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/cdp_interface_policy) | resource |
| [aci_error_disable_recovery.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/error_disable_recovery) | resource |
| [aci_fabric_if_pol.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/fabric_if_pol) | resource |
| [aci_l2_interface_policy.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/l2_interface_policy) | resource |
| [aci_l3_domain_profile.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/l3_domain_profile) | resource |
| [aci_lacp_policy.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/lacp_policy) | resource |
| [aci_leaf_access_bundle_policy_group.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/leaf_access_bundle_policy_group) | resource |
| [aci_leaf_access_port_policy_group.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/leaf_access_port_policy_group) | resource |
| [aci_leaf_breakout_port_group.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/leaf_breakout_port_group) | resource |
| [aci_lldp_interface_policy.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/lldp_interface_policy) | resource |
| [aci_mcp_instance_policy.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/mcp_instance_policy) | resource |
| [aci_miscabling_protocol_interface_policy.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/miscabling_protocol_interface_policy) | resource |
| [aci_physical_domain.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/physical_domain) | resource |
| [aci_port_security_policy.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/port_security_policy) | resource |
| [aci_qos_instance_policy.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/qos_instance_policy) | resource |
| [aci_ranges.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/ranges) | resource |
| [aci_spanning_tree_interface_policy.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/spanning_tree_interface_policy) | resource |
| [aci_spine_port_policy_group.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/spine_port_policy_group) | resource |
| [aci_spine_switch_policy_group.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/spine_switch_policy_group) | resource |
| [aci_vlan_pool.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/vlan_pool) | resource |
| [aci_vmm_controller.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/vmm_controller) | resource |
| [aci_vmm_credential.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/vmm_credential) | resource |
| [aci_vmm_domain.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/vmm_domain) | resource |
| [aci_vpc_domain_policy.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/vpc_domain_policy) | resource |
| [aci_vswitch_policy.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/vswitch_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_generic"></a> [access\_generic](#input\_access\_generic) | n/a | <pre>map(object({<br>    annotation  = optional(string)<br>    description = optional(string)<br>    name_alias  = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_cdp_interface_policy"></a> [cdp\_interface\_policy](#input\_cdp\_interface\_policy) | n/a | <pre>map(object({<br>    admin_st    = optional(string)<br>    annotation  = optional(string)<br>    description = optional(string)<br>    name_alias  = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_error_disable_recovery"></a> [error\_disable\_recovery](#input\_error\_disable\_recovery) | n/a | <pre>map(object({<br>    annotation          = optional(string)<br>    description         = optional(string)<br>    name_alias          = optional(string)<br>    err_dis_recov_intvl = optional(string)<br>    edr_event = optional(object({<br>      event = string<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_fabric_if_pol"></a> [fabric\_if\_pol](#input\_fabric\_if\_pol) | n/a | <pre>map(object({<br>    annotation    = optional(string)<br>    description   = optional(string)<br>    name_alias    = optional(string)<br>    auto_neg      = optional(string)<br>    fec_mode      = optional(string)<br>    link_debounce = optional(number)<br>    speed         = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_l2_interface_policy"></a> [l2\_interface\_policy](#input\_l2\_interface\_policy) | n/a | <pre>map(object({<br>    annotation  = optional(string)<br>    description = optional(string)<br>    name_alias  = optional(string)<br>    qinq        = optional(string)<br>    vepa        = optional(string)<br>    vlan_scope  = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_lacp_policy"></a> [lacp\_policy](#input\_lacp\_policy) | n/a | <pre>map(object({<br>    description = optional(string)<br>    annotation  = optional(string)<br>    name_alias  = optional(string)<br>    ctrl        = optional(list(string))<br>    max_links   = optional(string)<br>    min_links   = optional(string)<br>    mode        = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_leaf_access_bundle_policy_group"></a> [leaf\_access\_bundle\_policy\_group](#input\_leaf\_access\_bundle\_policy\_group) | n/a | <pre>map(object({<br>    annotation  = optional(string)<br>    description = optional(string)<br>    name_alias  = optional(string)<br>    lag_t       = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_leaf_breakout_port_group"></a> [leaf\_breakout\_port\_group](#input\_leaf\_breakout\_port\_group) | n/a | <pre>map(object({<br>    annotation  = optional(string)<br>    description = optional(string)<br>    name_alias  = optional(string)<br>    brkout_map  = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_lldp_interface_policy"></a> [lldp\_interface\_policy](#input\_lldp\_interface\_policy) | n/a | <pre>map(object({<br>    description = optional(string)<br>    annotation  = optional(string)<br>    name_alias  = optional(string)<br>    admin_tx_st = optional(string)<br>    admin_rx_st = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_mcp_instance_policy"></a> [mcp\_instance\_policy](#input\_mcp\_instance\_policy) | n/a | <pre>map(object({<br>    annotation       = optional(string)<br>    description      = optional(string)<br>    ctrl             = optional(list(string))<br>    init_delay_time  = optional(string)<br>    name_alias       = optional(string)<br>    loop_detect_mult = optional(string)<br>    loop_detect_act  = optional(string)<br>    tx_freq          = optional(string)<br>    tx_freq_msec     = optional(string)<br>    admin_st         = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_port_security_policy"></a> [port\_security\_policy](#input\_port\_security\_policy) | n/a | <pre>map(object({<br>    annotation  = optional(string)<br>    description = optional(string)<br>    name_alias  = optional(string)<br>    maximum     = optional(string)<br>    timeout     = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_qos_instance_policy"></a> [qos\_instance\_policy](#input\_qos\_instance\_policy) | n/a | <pre>map(object({<br>    description           = optional(string)<br>    etrap_age_timer       = optional(string)<br>    etrap_bw_thresh       = optional(string)<br>    etrap_byte_ct         = optional(string)<br>    etrap_st              = optional(string)<br>    fabric_flush_interval = optional(string)<br>    fabric_flush_st       = optional(string)<br>    annotation            = optional(string)<br>    ctrl                  = optional(string)<br>    uburst_spine_queues   = optional(string)<br>    uburst_tor_queues     = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_spanning_tree_interface_policy"></a> [spanning\_tree\_interface\_policy](#input\_spanning\_tree\_interface\_policy) | n/a | <pre>map(object({<br>    ctrl        = optional(string)<br>    description = optional(string)<br>    annotation  = optional(string)<br>    name_alias  = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_vlan_pool"></a> [vlan\_pool](#input\_vlan\_pool) | n/a | <pre>map(object({<br>    alloc_mode  = string<br>    description = optional(string)<br>    annotation  = optional(string)<br>    name_alias  = optional(string)<br>    role        = optional(string)<br>    from        = string<br>    to          = string<br>  }))</pre> | n/a | yes |
| <a name="input_vmm_controller"></a> [vmm\_controller](#input\_vmm\_controller) | n/a | <pre>map(object({<br>    host_or_ip          = string<br>    root_cont_name      = string<br>    annotation          = optional(string)<br>    dvs_version         = optional(string)<br>    inventory_trig_st   = optional(string)<br>    mode                = optional(string)<br>    msft_config_err_msg = optional(string)<br>    msft_config_issues  = optional(list(string))<br>    n1kv_stats_mode     = optional(string)<br>    port                = optional(string)<br>    scope               = optional(string)<br>    stats_mode          = optional(string)<br>    seq_num             = optional(string)<br>    vxlan_depl_pref     = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_vmm_credential"></a> [vmm\_credential](#input\_vmm\_credential) | n/a | <pre>map(object({<br>    annotation    = optional(string)<br>    description   = optional(string)<br>    name_alias    = optional(string)<br>    pwd           = optional(string)<br>    usr           = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_vmm_domain"></a> [vmm\_domain](#input\_vmm\_domain) | n/a | <pre>map(object({<br>    provider_profile_dn = string<br>    access_mode         = optional(string)<br>    annotation          = optional(string)<br>    arp_learning        = optional(string)<br>    enable_ave          = optional(string)<br>    ave_time_out        = optional(string)<br>    config_infra_pg     = optional(string)<br>    ctrl_knob           = optional(string)<br>    delimiter           = optional(string)<br>    enable_tag          = optional(string)<br>    enable_vm_folder    = optional(string)<br>    encap_mode          = optional(string)<br>    enf_pref            = optional(string)<br>    ep_inventory_type   = optional(string)<br>    ep_ret_time         = optional(string)<br>    hv_avail_monitor    = optional(string)<br>    mcast_addr          = optional(string)<br>    mode                = optional(string)<br>    name_alias          = optional(string)<br>    pref_encap_mode     = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_vpc_domain_policy"></a> [vpc\_domain\_policy](#input\_vpc\_domain\_policy) | n/a | <pre>map(object({<br>    annotation  = optional(string)<br>    dead_intvl  = optional(string)<br>    name_alias  = optional(string)<br>    description = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_vswitch_policy"></a> [vswitch\_policy](#input\_vswitch\_policy) | n/a | <pre>map(object({<br>    annotation    = optional(string)<br>    description   = optional(string)<br>    name_alias    = optional(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_generic"></a> [access\_generic](#output\_access\_generic) | n/a |
| <a name="output_access_switch_policy_group"></a> [access\_switch\_policy\_group](#output\_access\_switch\_policy\_group) | n/a |
| <a name="output_attachable_access_entity_profile"></a> [attachable\_access\_entity\_profile](#output\_attachable\_access\_entity\_profile) | n/a |
| <a name="output_cdp_interface_policy"></a> [cdp\_interface\_policy](#output\_cdp\_interface\_policy) | n/a |
| <a name="output_error_disable_recovery"></a> [error\_disable\_recovery](#output\_error\_disable\_recovery) | n/a |
| <a name="output_fabric_if_pol"></a> [fabric\_if\_pol](#output\_fabric\_if\_pol) | n/a |
| <a name="output_l2_interface_policy"></a> [l2\_interface\_policy](#output\_l2\_interface\_policy) | n/a |
| <a name="output_l3_domain_profile"></a> [l3\_domain\_profile](#output\_l3\_domain\_profile) | n/a |
| <a name="output_lacp_policy"></a> [lacp\_policy](#output\_lacp\_policy) | n/a |
| <a name="output_leaf_access_bundle_policy_group"></a> [leaf\_access\_bundle\_policy\_group](#output\_leaf\_access\_bundle\_policy\_group) | n/a |
| <a name="output_leaf_access_port_policy_group"></a> [leaf\_access\_port\_policy\_group](#output\_leaf\_access\_port\_policy\_group) | n/a |
| <a name="output_leaf_breakout_port_group"></a> [leaf\_breakout\_port\_group](#output\_leaf\_breakout\_port\_group) | n/a |
| <a name="output_lldp_interface_policy"></a> [lldp\_interface\_policy](#output\_lldp\_interface\_policy) | n/a |
| <a name="output_mcp_instance_policy"></a> [mcp\_instance\_policy](#output\_mcp\_instance\_policy) | n/a |
| <a name="output_miscabling_protocol_interface_policy"></a> [miscabling\_protocol\_interface\_policy](#output\_miscabling\_protocol\_interface\_policy) | n/a |
| <a name="output_physical_domain"></a> [physical\_domain](#output\_physical\_domain) | n/a |
| <a name="output_port_security_policy"></a> [port\_security\_policy](#output\_port\_security\_policy) | n/a |
| <a name="output_qos_instance_policy"></a> [qos\_instance\_policy](#output\_qos\_instance\_policy) | n/a |
| <a name="output_ranges"></a> [ranges](#output\_ranges) | n/a |
| <a name="output_spanning_tree_interface_policy"></a> [spanning\_tree\_interface\_policy](#output\_spanning\_tree\_interface\_policy) | n/a |
| <a name="output_spine_port_policy_group"></a> [spine\_port\_policy\_group](#output\_spine\_port\_policy\_group) | n/a |
| <a name="output_spine_switch_policy_group"></a> [spine\_switch\_policy\_group](#output\_spine\_switch\_policy\_group) | n/a |
| <a name="output_vlan_pool"></a> [vlan\_pool](#output\_vlan\_pool) | n/a |
| <a name="output_vmm_controller"></a> [vmm\_controller](#output\_vmm\_controller) | n/a |
| <a name="output_vmm_credential"></a> [vmm\_credential](#output\_vmm\_credential) | n/a |
| <a name="output_vmm_domain"></a> [vmm\_domain](#output\_vmm\_domain) | n/a |
| <a name="output_vpc_domain_policy"></a> [vpc\_domain\_policy](#output\_vpc\_domain\_policy) | n/a |
| <a name="output_vswitch_policy"></a> [vswitch\_policy](#output\_vswitch\_policy) | n/a |
