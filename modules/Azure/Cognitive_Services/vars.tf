variable "resource_group_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "account" {
  type = list(map(object({
    id                                           = number
    kind                                         = string
    name                                         = string
    sku                                          = string
    custom_question_answering_search_service_id  = optional(string)
    custom_subdomain_name                        = optional(string)
    custom_question_answering_search_service_key = optional(string)
    dynamic_throttling_enabled                   = optional(bool)
    fqdns                                        = optional(list(string))
    local_auth_enabled                           = optional(bool)
    metrics_advisor_aad_client_id                = optional(string)
    metrics_advisor_aad_tenant_id                = optional(string)
    metrics_advisor_super_user_name              = optional(string)
    metrics_advisor_website_name                 = optional(string)
    outbound_network_access_restricted           = optional(bool)
    public_network_access_enabled                = optional(bool)
    qna_runtime_endpoint                         = optional(string)
    tags                                         = optional(map(string))
    network_acls = optional(list(object({
      default_action = string
      ip_rules       = optional(list(string))
      virtual_network_rules = optional(list(object({
        subnet_id                            = string
        ignore_missing_vnet_service_endpoint = optional(bool)
      })), [])
    })), [])
    customer_managed_key = optional(list(object({
      key_vault_key_id   = string
      identity_client_id = optional(string)
    })), [])
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })), [])
    storage = optional(list(object({
      storage_account_id = string
      identity_client_id = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
Manages a Cognitive Services Account.
EOF
}

variable "account_customer_managed_key" {
  type = list(map(object({
    id                   = number
    cognitive_account_id = number
    key_vault_key_id     = string
    identity_client_id   = optional(string)
  })))
  default     = []
  description = <<EOF
EOF
}

variable "deployment" {
  type = list(map(object({
    id                   = number
    cognitive_account_id = number
    name                 = string
    rai_policy_name      = optional(string)
    model = list(object({
      format  = string
      name    = string
      version = string
    }))
    scale = list(object({
      type     = string
      tier     = string
      size     = string
      family   = optional(string)
      capacity = optional(number)
    }))
  })))
  default = []
  description = <<EOF
Manages a Cognitive Services Account Deployment.
cognitive_account_id - (Required) : The ID of the Cognitive Services Account
model / format - (Required) : The format of the Cognitive Services Account Deployment model. Changing this forces a new resource to be created. Possible value is OpenAI
scale / type - (Required) : The name of the SKU. Ex - Standard or P3
scale / tier - (Required) : Possible values are Free, Basic, Standard, Premium, Enterprise
scale / capacity - (Optional) : Tokens-per-Minute (TPM). The unit of measure for this field is in the thousands of Tokens-per-Minute. Defaults to 1 which means that the limitation is 1000 tokens per minute. If the resources SKU supports scale in/out then the capacity field should be included in the resources' configuration.
EOF
}