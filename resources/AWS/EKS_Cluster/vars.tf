variable "iam_role" {
  type = "list"
}

variable "iam_policy" {
  type = "list"
}

variable "iam_role_policy_attachment" {
  type = "list"
}

variable "instance_profile" {
  type = "list"
}

variable "service_linked_role" {
  type = "list"
}

variable "openid_connect_provider" {
  type = "list"
}

variable "vpc" {
  type = "list"
}

variable "security_group" {
  type = "list"
}

variable "security_group_rule" {
  type = "list"
}

variable "subnet" {
  type = "list"
}

variable "log_group" {
  type = "list"
}

variable "eks_cluster" {
  type = "list"
}

variable "node_group" {
  type = "list"
}