# VPC
variable "state_bucket" {
}

# ElasticSearch
variable "elasticsearch" {
  type = "list"
}

variable "es_policy" {
  type = "list"
}

variable "elastic_policy_name" {}

# Security Group
variable "SecGroupName" {
}

# Security group rule
variable "SecGroupRules" {
  type = "list"
}
