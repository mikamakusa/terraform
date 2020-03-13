## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| lambda\_layer\_version | n/a | `list` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| lamba\_layer\_version\_arn | n/a |

## How to use it

#### main.tf
```hcl
module "lambda_layer_version" {
  source               = "modules/tf-lambda-layer-version"
  lambda_layer_version = var.lambda_layer_version
}
```

#### vars.tf
```hcl
variable "lambda_layer_version" {
  type = "list"
}
```

#### vars.tfvars
```
lambda_layer_version = [
  {
    id         = "0"
    layer_name = "layer"
    filename   = "layer"
  }
]
```