## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cloudwatch\_event\_rule\_arn | n/a | `any` | n/a | yes |
| lambda\_function\_arn | n/a | `any` | n/a | yes |
| lambda\_permission | n/a | `list` | n/a | yes |
| s3\_bucket\_arn | n/a | `any` | n/a | yes |

## Outputs

No output.

## How to use it

this module is to be used with the following modules : 
- tf-cloudwatch-event-rule
- tf-lambda-function
- tf-s3

The cloudwatch and s3 modules are not required, if not used please leave them empty (lambda module is required)  

#### main.tf
```hcl
module "lambda_permission" {
  source                    = "modules/tf-lambda-permission"
  cloudwatch_event_rule_arn = module.cloudwatch_event_rule.cloudwatch_event_rule_arn
  lambda_function_arn       = module.lambda_function.lambda_function_arn
  lambda_permission         = var.lambda_permission
  s3_bucket_arn             = module.s3.s3_bucket_arn
}
```

#### vars.tf
```hcl
variable "lambda_permission" {
  type = "list"
}
```

#### vars.tfvars
```
lambda_permission = [
  {
    id          = "0"
    function_id = "0"
    bucket_id   = "0"
    source      = "s3"
  }
]
```