variable "graphql_api" {
  type = list

  validation {
    condition = can(regex("API_KEY|AWS_IAM|AMAZON_COGNITO_USER_POOLS|OPENID_CONNECT", lookup(var.graphql_api[count.index], "authentication_type")))
  }
}

variable "cloudwatch_logs_role_arn" {}
variable "client_id" {}
variable "user_pool_id" {}
variable "tags" {}