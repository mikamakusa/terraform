# Application
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application | n/a | `list` | n/a | yes |
| service_role | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| id | n/a |
| name | n/a |

---
# Application_Version
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application | n/a | `any` | n/a | yes |
| application\_version | n/a | `list` | n/a | yes |
| bucket | n/a | `any` | n/a | yes |
| object | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |

---
# Configuration_Template
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application | n/a | `any` | n/a | yes |
| configuration\_template | n/a | `list` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| application | n/a |
| description | n/a |
| environment\_id | n/a |
| name | n/a |

---
# Environment
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application | n/a | `any` | n/a | yes |
| environment | n/a | `list` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| application | n/a |
| arn | n/a |
| cname | n/a |
| description | n/a |
| id | n/a |
| setting | n/a |
| tier | n/a |

---
# How to use it ?
## main.tf
```hcl
resource "aws_s3_bucket" "s3_bucket" {
  bucket = ""
}

resource "aws_s3_bucket_object" "s3_bucket_object" {
  bucket = aws_s3_bucket.s3_bucket.id
  key    = ""
}

resource "aws_iam_role" "role" {
  name = ""
  assume_role_policy = ""
}

module "Application" {
  source       = "Application"
  application  = var.application
  service_role = aws_iam_role.role.id
}

module "Application_Version" {
  source              = "Application_Version"
  application         = module.Application.name
  application_version = var.application_version
  bucket              = aws_s3_bucket.s3_bucket.id
  object              = aws_s3_bucket_object.s3_bucket_object.id
}

module "Configuration_template" {
  source                 = "Configuration_Template"
  application            = module.Application.name
  configuration_template = var.configuration_template
}

module "Environment" {
  source      = "Environment"
  application = module.Application.name
  environment = var.environment
}

```

## variables.tf
```hcl
variable "application" {
  type = list
}

variable "application_version" {
  type = list
}

variable "configuration_template" {
  type = list
}

variable "environment" {
  type = list
}
```

## vars.tfvars
```
application = [
  {
    id = ""
    name = ""
    description = "" # Optional
    tags = [ # Optional
      {
        ####
      }
    ]
    appversion_lifecycle = [
      {
        service_role_id = "" # Optional
        max_count = "" # Optional
        max_age_in_days = "" # Optional
        delete_source_from_s3 = "" # Optional
      }
    ]
  }
]

application_version = [
  {
    id = ""
    application_id = ""
    bucket_id = ""
    object_id = ""
    name = ""
    description = "" # Optional
    force_delete = "" # Optional
    tags = [
      {
        ####
      }
    ]
  }
]

configuration_template = [
  {
    id = ""
    application_id = ""
    name = ""
    description = "" # Optional
    environment_id = "" # Optional
    solution_stack_name = "" # Optional

    setting = [ # Optional
      {
        namespace = ""
        name = ""
        value = ""
        resource = "" # Optional
      }
    ]
  }
]

environment = [
  {
    id = ""
    application_id = ""
    name = ""
    cname_prefix = "" # Optional
    description = "" # Optional
    tier = "" # Optional, default value : WebServer / other value : Worker
    solution_stack_name = "" # Optional, in conflict with template_name and platform_arn
    template_name = "" # Optional, in conflict with solution_stack_name and platform_arn
    platform_arn = "" # Optional, in conflict with template_name and solution_stack_name
    wait_for_ready_timeout = "" # Optional
    poll_interval = "" # Optional
    version_label = "" # Optional
    tags = [ # Optional
      {
        ###
      }
    ]

    setting = [ # Optional
      {
        namespace = ""
        name = ""
        value = ""
        resource = "" # Optional
      }
    ]
  }
]
```
