variable "project_name" {
  type = string
}

variable "group_v2" {
  type = list(object({
    id                         = number
    name                       = optional(string)
    description                = optional(string)
    ingress_firewall_policy_id = optional(string)
    egress_firewall_policy_id  = optional(string)
    admin_state_up             = optional(bool)
    ports                      = optional(list(string))
    shared                     = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
name - (Optional) A name for the firewall group. Changing this updates the name of an existing firewall.
description - (Optional) A description for the firewall group. Changing this updates the description of an existing firewall group.
ingress_firewall_policy_id - (Optional) The ingress firewall policy resource id for the firewall group. Changing this updates the ingress_firewall_policy_id of an existing firewall group.
egress_firewall_policy_id - (Optional) The egress firewall policy resource id for the firewall group. Changing this updates the egress_firewall_policy_id of an existing firewall group.
admin_state_up - (Optional) Administrative up/down status for the firewall group (must be "true" or "false" if provided - defaults to "true"). Changing this updates the admin_state_up of an existing firewall group.
ports - (Optional) Port(s) to associate this firewall group with. Must be a list of strings. Changing this updates the associated ports of an existing firewall group.
shared - (Optional) Sharing status of the firewall group (must be "true" or "false" if provided). If this is "true" the firewall group is visible to, and can be used in, firewalls in other tenants. Changing this updates the shared status of an existing firewall group. Only administrative users can specify if the firewall group should be shared.
  EOF
}

variable "policy_v2" {
  type = list(object({
    id          = number
    name        = optional(string)
    description = optional(string)
    rules       = optional(list(string))
    audited     = optional(bool)
    shared      = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
name - (Optional) A name for the firewall policy. Changing this updates the name of an existing firewall policy.
description - (Optional) A description for the firewall policy. Changing this updates the description of an existing firewall policy.
rules - (Optional) An array of one or more firewall rules that comprise the policy. Changing this results in adding/removing rules from the existing firewall policy.
audited - (Optional) Audit status of the firewall policy (must be "true" or "false" if provided - defaults to "false"). This status is set to "false" whenever the firewall policy or any of its rules are changed. Changing this updates the audited status of an existing firewall policy.
shared - (Optional) Sharing status of the firewall policy (must be "true" or "false" if provided). If this is "true" the policy is visible to, and can be used in, firewalls in other tenants. Changing this updates the shared status of an existing firewall policy. Only administrative users can specify if the policy should be shared.
  EOF
}

variable "rule_v2" {
  type = list(object({
    id                     = number
    name                   = optional(string)
    description            = optional(string)
    protocol               = optional(string)
    action                 = optional(string)
    ip_version             = optional(number)
    source_ip_address      = optional(string)
    destination_ip_address = optional(string)
    source_port            = optional(string)
    destination_port       = optional(string)
    shared                 = optional(bool)
    enabled                = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
name - (Optional) A unique name for the firewall rule. Changing this updates the name of an existing firewall rule.
description - (Optional) A description for the firewall rule. Changing this updates the description of an existing firewall rule.
protocol - (Optional; Required if source_port or destination_port is not empty) The protocol type on which the firewall rule operates. Valid values are: tcp, udp, icmp, and any. Changing this updates the protocol of an existing firewall rule. Default is any.
action - (Optional) Action to be taken (must be "allow", "deny" or "reject") when the firewall rule matches. Changing this updates the action of an existing firewall rule. Default is deny.
ip_version - (Optional) IP version, either 4 or 6. Changing this updates the ip_version of an existing firewall rule. Default is 4.
source_ip_address - (Optional) The source IP address on which the firewall rule operates. Changing this updates the source_ip_address of an existing firewall rule.
destination_ip_address - (Optional) The destination IP address on which the firewall rule operates. Changing this updates the destination_ip_address of an existing firewall rule.
source_port - (Optional) The source port on which the firewall rule operates. Changing this updates the source_port of an existing firewall rule. Require not any or empty protocol.
destination_port - (Optional) The destination port on which the firewall rule operates. Changing this updates the destination_port of an existing firewall rule. Require not any or empty protocol.
shared - (Optional) Sharing status of the firewall rule (must be "true" or "false" if provided). If this is "true" the policy is visible to, and can be used in, firewalls in other tenants. Changing this updates the shared status of an existing firewall policy. On
enabled - (Optional) Enabled status for the firewall rule (must be "true" or "false" if provided - defaults to "true"). Changing this updates the enabled status of an existing firewall rule.
  EOF
}
