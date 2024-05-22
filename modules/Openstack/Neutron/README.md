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
| [openstack_fw_group_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/fw_group_v2) | resource |
| [openstack_fw_policy_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/fw_policy_v2) | resource |
| [openstack_fw_rule_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/fw_rule_v2) | resource |
| [openstack_identity_project_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/data-sources/identity_project_v3) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group_v2"></a> [group\_v2](#input\_group\_v2) | The following arguments are supported:<br>name - (Optional) A name for the firewall group. Changing this updates the name of an existing firewall.<br>description - (Optional) A description for the firewall group. Changing this updates the description of an existing firewall group.<br>ingress\_firewall\_policy\_id - (Optional) The ingress firewall policy resource id for the firewall group. Changing this updates the ingress\_firewall\_policy\_id of an existing firewall group.<br>egress\_firewall\_policy\_id - (Optional) The egress firewall policy resource id for the firewall group. Changing this updates the egress\_firewall\_policy\_id of an existing firewall group.<br>admin\_state\_up - (Optional) Administrative up/down status for the firewall group (must be "true" or "false" if provided - defaults to "true"). Changing this updates the admin\_state\_up of an existing firewall group.<br>ports - (Optional) Port(s) to associate this firewall group with. Must be a list of strings. Changing this updates the associated ports of an existing firewall group.<br>shared - (Optional) Sharing status of the firewall group (must be "true" or "false" if provided). If this is "true" the firewall group is visible to, and can be used in, firewalls in other tenants. Changing this updates the shared status of an existing firewall group. Only administrative users can specify if the firewall group should be shared. | <pre>list(object({<br>    id                         = number<br>    name                       = optional(string)<br>    description                = optional(string)<br>    ingress_firewall_policy_id = optional(string)<br>    egress_firewall_policy_id  = optional(string)<br>    admin_state_up             = optional(bool)<br>    ports                      = optional(list(string))<br>    shared                     = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_policy_v2"></a> [policy\_v2](#input\_policy\_v2) | The following arguments are supported:<br>name - (Optional) A name for the firewall policy. Changing this updates the name of an existing firewall policy.<br>description - (Optional) A description for the firewall policy. Changing this updates the description of an existing firewall policy.<br>rules - (Optional) An array of one or more firewall rules that comprise the policy. Changing this results in adding/removing rules from the existing firewall policy.<br>audited - (Optional) Audit status of the firewall policy (must be "true" or "false" if provided - defaults to "false"). This status is set to "false" whenever the firewall policy or any of its rules are changed. Changing this updates the audited status of an existing firewall policy.<br>shared - (Optional) Sharing status of the firewall policy (must be "true" or "false" if provided). If this is "true" the policy is visible to, and can be used in, firewalls in other tenants. Changing this updates the shared status of an existing firewall policy. Only administrative users can specify if the policy should be shared. | <pre>list(object({<br>    id          = number<br>    name        = optional(string)<br>    description = optional(string)<br>    rules       = optional(list(string))<br>    audited     = optional(bool)<br>    shared      = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_rule_v2"></a> [rule\_v2](#input\_rule\_v2) | The following arguments are supported:<br>name - (Optional) A unique name for the firewall rule. Changing this updates the name of an existing firewall rule.<br>description - (Optional) A description for the firewall rule. Changing this updates the description of an existing firewall rule.<br>protocol - (Optional; Required if source\_port or destination\_port is not empty) The protocol type on which the firewall rule operates. Valid values are: tcp, udp, icmp, and any. Changing this updates the protocol of an existing firewall rule. Default is any.<br>action - (Optional) Action to be taken (must be "allow", "deny" or "reject") when the firewall rule matches. Changing this updates the action of an existing firewall rule. Default is deny.<br>ip\_version - (Optional) IP version, either 4 or 6. Changing this updates the ip\_version of an existing firewall rule. Default is 4.<br>source\_ip\_address - (Optional) The source IP address on which the firewall rule operates. Changing this updates the source\_ip\_address of an existing firewall rule.<br>destination\_ip\_address - (Optional) The destination IP address on which the firewall rule operates. Changing this updates the destination\_ip\_address of an existing firewall rule.<br>source\_port - (Optional) The source port on which the firewall rule operates. Changing this updates the source\_port of an existing firewall rule. Require not any or empty protocol.<br>destination\_port - (Optional) The destination port on which the firewall rule operates. Changing this updates the destination\_port of an existing firewall rule. Require not any or empty protocol.<br>shared - (Optional) Sharing status of the firewall rule (must be "true" or "false" if provided). If this is "true" the policy is visible to, and can be used in, firewalls in other tenants. Changing this updates the shared status of an existing firewall policy. On<br>enabled - (Optional) Enabled status for the firewall rule (must be "true" or "false" if provided - defaults to "true"). Changing this updates the enabled status of an existing firewall rule. | <pre>list(object({<br>    id                     = number<br>    name                   = optional(string)<br>    description            = optional(string)<br>    protocol               = optional(string)<br>    action                 = optional(string)<br>    ip_version             = optional(number)<br>    source_ip_address      = optional(string)<br>    destination_ip_address = optional(string)<br>    source_port            = optional(string)<br>    destination_port       = optional(string)<br>    shared                 = optional(bool)<br>    enabled                = optional(bool)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group"></a> [group](#output\_group) | n/a |
| <a name="output_policy"></a> [policy](#output\_policy) | n/a |
| <a name="output_rule"></a> [rule](#output\_rule) | n/a |
