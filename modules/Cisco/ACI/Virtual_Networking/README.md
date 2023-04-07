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
| [aci_rest_managed.domain_uplinks](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/rest_managed) | resource |
| [aci_rest_managed.vmm_uplinks](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/rest_managed) | resource |
| [aci_vmm_controller.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/vmm_controller) | resource |
| [aci_vmm_credential.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/vmm_credential) | resource |
| [aci_vmm_domain.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/vmm_domain) | resource |
| [aci_vswitch_policy.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/vswitch_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_relation_vmm_rs_vswitch_exporter_pol"></a> [relation\_vmm\_rs\_vswitch\_exporter\_pol](#input\_relation\_vmm\_rs\_vswitch\_exporter\_pol) | n/a | <pre>object({<br>    active_flow_time_out = optional(string)<br>    idle_flow_time_out   = optional(string)<br>    sampling_rate        = optional(string)<br>    target_dn            = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_uplink_names"></a> [uplink\_names](#input\_uplink\_names) | n/a | `list(string)` | n/a | yes |
| <a name="input_vmm_controller"></a> [vmm\_controller](#input\_vmm\_controller) | n/a | <pre>map(object({<br>    host_or_ip          = string<br>    root_cont_name      = string<br>    annotation          = optional(string)<br>    dvs_version         = optional(string)<br>    inventory_trig_st   = optional(string)<br>    mode                = optional(string)<br>    msft_config_err_msg = optional(string)<br>    msft_config_issues  = optional(list(string))<br>    n1kv_stats_mode     = optional(string)<br>    port                = optional(string)<br>    scope               = optional(string)<br>    stats_mode          = optional(string)<br>    seq_num             = optional(string)<br>    vxlan_depl_pref     = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_vmm_credential"></a> [vmm\_credential](#input\_vmm\_credential) | n/a | <pre>map(object({<br>    annotation  = optional(string)<br>    description = optional(string)<br>    name_alias  = optional(string)<br>    pwd         = optional(string)<br>    usr         = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_vmm_domain"></a> [vmm\_domain](#input\_vmm\_domain) | n/a | <pre>map(object({<br>    provider_profile_dn = string<br>    access_mode         = optional(string)<br>    annotation          = optional(string)<br>    arp_learning        = optional(string)<br>    enable_ave          = optional(string)<br>    ave_time_out        = optional(string)<br>    config_infra_pg     = optional(string)<br>    ctrl_knob           = optional(string)<br>    delimiter           = optional(string)<br>    enable_tag          = optional(string)<br>    enable_vm_folder    = optional(string)<br>    encap_mode          = optional(string)<br>    enf_pref            = optional(string)<br>    ep_inventory_type   = optional(string)<br>    ep_ret_time         = optional(string)<br>    hv_avail_monitor    = optional(string)<br>    mcast_addr          = optional(string)<br>    mode                = optional(string)<br>    name_alias          = optional(string)<br>    pref_encap_mode     = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_vswitch_policy"></a> [vswitch\_policy](#input\_vswitch\_policy) | n/a | <pre>map(object({<br>    annotation  = optional(string)<br>    description = optional(string)<br>    name_alias  = optional(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_uplinks"></a> [domain\_uplinks](#output\_domain\_uplinks) | n/a |
| <a name="output_vmm_controller"></a> [vmm\_controller](#output\_vmm\_controller) | n/a |
| <a name="output_vmm_credential"></a> [vmm\_credential](#output\_vmm\_credential) | n/a |
| <a name="output_vmm_domain"></a> [vmm\_domain](#output\_vmm\_domain) | n/a |
| <a name="output_vmm_uplinks"></a> [vmm\_uplinks](#output\_vmm\_uplinks) | n/a |
| <a name="output_vswitch_policy"></a> [vswitch\_policy](#output\_vswitch\_policy) | n/a |
