variable "billing_account" {}

variable "billing_account_iam_binding" {
  type = list
}

variable "billing_account_iam_member" {
  type = list
}

variable "billing_account_iam_policy" {
  type = list
}

variable "policy_data" {}