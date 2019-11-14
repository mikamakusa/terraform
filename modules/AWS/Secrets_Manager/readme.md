# How to use the module

## The resource
```hcl-terraform
module "lambda" {
  source               = "../modules/AWS/Lambdas"
}

module "kms" {
  source       = "../modules/AWS/KMS"
}

module "api_gateway" {
  source         = "../modules/AWS/Secrets_Manager"
  kms_key_id     = module.kms.*.kms_id
  lambda_arn     = module.lambda.lambda_arn
  secret         = var.secret
  secret_version = var.secret_version
}
```

## The vars
```hcl-terraform
variable "secret" {
  type = "list"
}
variable "secret_version" {
  type = "list"
}
```

## The tfvars file
```hcl-terraform
secret = [
  {
    id                      = ""
    name                    = ""
    description             = ""
    kms_key_id              = ""
    policy                  = ""
    recovery_window_in_days = "" # from 7 to 30
    lambda_id               = ""
    rotation_rules = [
      {
        automatically_after_days = "" 
      }
    ]
    lifecycle = [
      {
        ignore_changes        = ""
        create_before_destroy = ""
        prevent_destroy       = ""
      }
    ]
    tags = []
  }
]

secret_version = [
  {
    id             = ""
    secret_id      = ""
    secret_string  = ""
    version_stages = ""
    lifecycle = [
      {
        ignore_changes        = ""
        create_before_destroy = ""
        prevent_destroy       = ""
      }
    ]
  }
]
```