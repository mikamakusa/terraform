variable "service" {
  type = "list"
}

variable "task_definition_arn" {}
variable "iam_role_arn" {}
variable "capacity_provider_name" {}
variable "elb_name" {}
variable "target_group_arn" {}
variable "subnet" {}
variable "security_group" {}
variable "registry_arn" {}