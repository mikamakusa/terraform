variable "datasource" {
  type = list

  validation {
    condition = can(regex("AWS_LAMBDA|AMAZON_DYNAMODB|AMAZON_ELASTICSEARCH|HTTP|NONE", lookup(var.datasource[count.index], "type")))
  }
}

variable "api_id" {}
variable "service_role_arn" {}
variable "table_name" {}
variable "endpoint" {}
variable "function_arn" {}