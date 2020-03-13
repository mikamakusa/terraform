## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| lambda\_function | n/a | `list` | n/a | yes |
| layer\_arn | n/a | `any` | n/a | yes |
| role\_arn | n/a | `any` | n/a | yes |
| tags | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| lambda\_function\_arn | n/a |
| lambda\_function\_function\_name | n/a |

## How to use it

This module is to be used with the following modules :  
- tf-iam-role  
- tf-lambda-layer-version

#### main.tf
```hcl
module "lambda_function" {
  source          = "modules/tf-lambda-function"
  lambda_function = var.lambda_function
  layer_arn       = module.lambda_layer_version.lamba_layer_version_arn
  role_arn        = module.iam_role.iam_role_arn
  tags            = local.tags
}
```

#### vars.tf
```hcl
variable "lambda_function" {
  type = "list"
}
```

#### vars.tfvars
```
lambda_function = [
  {
    id            = "0"
    function_name = "xxxxxxxxx"
    role_id       = "1"
    runtime       = "python3.7"
    filename      = "xxxxxxxxx"
    memory_size   = "2048"
    layer_id      = "0"
    environment = [
      {
        xxxxxx     = "xxxxxx"
        xxxxxx     = "xxxxxxx"
      }
    ]
  }
]
```