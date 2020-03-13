## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| function\_name | n/a | `any` | n/a | yes |
| lambda\_function\_event\_invoke\_config | n/a | `list` | n/a | yes |
| on\_failure\_sns\_topic\_arn | n/a | `any` | n/a | yes |
| on\_success\_sns\_topic\_arn | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| lambda\_function\_event\_invoke\_config\_id | n/a |

## How to use it

This module is to be used with the following modules : 
- tf-lambda-function
- tf-sns-topic

#### main.tf
```hcl
module "lambda_function_event_invoke_config" {
  source                              = "modules/tf-lambda-function-event-invoke-config"
  function_name                       = module.lambda_function.lambda_function_arn
  lambda_function_event_invoke_config = var.lambda_function_event_invoke_config
  on_failure_sns_topic_arn            = module.sns_topic.sns_topic_arn
  on_success_sns_topic_arn            = module.sns_topic.sns_topic_arn
}
```

#### vars.tf
```hcl
variable "lambda_function_event_invoke_config" {}
```

#### vars.tfvars
```
lambda_function_event_invoke_config = [
    {
        id                              = ""
        function_id                     = ""
        maximum_event_age_in_seconds    = "" // optionnal
        maximum_retry_attempts          = "" // optionnal
        destination_config = [
            {
                on_failure_sns_topic_id = ""
                on_success_sns_topic_id = ""
            }
        ]
    }
]
```