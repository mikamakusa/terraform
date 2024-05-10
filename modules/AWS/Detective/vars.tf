variable "tags" {
  type    = map(string)
  default = {}
}

variable "graph" {
  type = list(map(object({
    id   = number
    tags = optional(map(string))
  })))
  default     = []
  description = <<EOF
Provides a resource to manage an AWS Detective Graph.
The following arguments are optional:
tags - (Optional) A map of tags to assign to the instance. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level.
EOF
}

variable "invitation_accepter" {
  type = list(map(object({
    id       = number
    graph_id = number
  })))
  default     = []
  description = <<EOF
Provides a resource to manage an Amazon Detective Invitation Accepter.
This resource supports the following arguments:
graph_arn - (Required) ARN of the behavior graph that the member account is accepting the invitation for.
EOF
}

variable "member" {
  type = list(map(object({
    id                         = number
    account_id                 = string
    email_address              = string
    graph_id                   = number
    message                    = optional(string)
    disable_email_notification = optional(bool)
  })))
  default     = []
  description = <<EOF
Provides a resource to manage an Amazon Detective Member.
This resource supports the following arguments:
account_id - (Required) AWS account ID for the account.
email_address - (Required) Email address for the account.
graph_arn - (Required) ARN of the behavior graph to invite the member accounts to contribute their data to.
message - (Optional) A custom message to include in the invitation. Amazon Detective adds this message to the standard content that it sends for an invitation.
disable_email_notification - (Optional) If set to true, then the root user of the invited account will not receive an email notification. This notification is in addition to an alert that the root user receives in AWS Personal Health Dashboard. By default, this is set to false.
EOF
}

variable "organization_admin_account" {
  type = list(map(object({
    id         = number
    account_id = string
  })))
  default     = []
  description = <<EOF
Manages a Detective Organization Admin Account.
The following arguments are supported:
account_id - (Required) AWS account identifier to designate as a delegated administrator for Detective.
EOF
}

variable "organization_configuration" {
  type = list(map(object({
    id          = number
    auto_enable = bool
    graph_id    = number
  })))
  default = []
  description = <<EOF
Manages the Detective Organization Configuration in the current AWS Region.
The following arguments are supported:
auto_enable - (Required) When this setting is enabled, all new accounts that are created in, or added to, the organization are added as a member accounts of the organization’s Detective delegated administrator and Detective is enabled in that AWS Region.
graph_arn - (Required) ARN of the behavior graph.
EOF
}