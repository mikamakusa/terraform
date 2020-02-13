variable "codebuild_project" {
  type = "list"
}

variable "codebuild_source_credential" {
  type = "list"
}

variable "codebuild_webhook" {
  type = "list"
}

variable "kms_key_id" {}
variable "security_group_id" {}
variable "subnet_id" {}
variable "vpc_id" {}