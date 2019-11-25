variable "kms_key" {
  type = "list"
}

variable "kms_alias" {
  type = "list"
}

variable "ciphertext" {
  type = "list"
}

variable "iam_role_id" {}

variable "kms_grant" {
  type = "list"
}

variable "external_key" {
  type = "list"
}