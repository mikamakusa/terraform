## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| location | n/a | `any` | n/a | yes |
| policy\_data | n/a | `any` | n/a | yes |
| project | n/a | `any` | n/a | yes |
| service | n/a | `any` | n/a | yes |
| service\_iam\_binding | n/a | `list` | n/a | yes |
| service\_iam\_member | n/a | `list` | n/a | yes |
| service\_iam\_policy | n/a | `list` | n/a | yes |

## Outputs

No output.

## How to use it
### main.tf
```hcl
module "CloudRun_service" {
  source   = "../../../modules/Google/CloudRun/Service"
  location = var.location
  project  = data.google_project.project.id
  service  = var.service
}

module "CloudRun_IAM" {
  source              = "../../../modules/Google/CloudRun/Service_IAM"
  location            = var.location
  policy_data         = ""
  project             = data.google_project.project.id
  service             = module.CloudRun_service.name
  service_iam_binding = var.service_iam_binding
  service_iam_member  = var.service_iam_member
  service_iam_policy  = var.service_iam_policy
}
```

### vars.tf
```hcl
variable "service" {
  type = list
}

variable "service" {
  type = list
}

variable "service_iam_member" {
  type = list
}

variable "service_iam_binding" {
  type = list
}

variable "service_iam_policy" {
  type = list
}

variable "project" {}
variable "location" {}

variable "project" {}
variable "location" {}

```

### vars.tfvars
```
project  = "cka-test-project"
location = "europe-west1"

service = [
  {
    id   = "0"
    name = "test"
    template = [
      {
        metadata = []
        spec = [
          {
            containers = [
              {
                image   = "gcr.io/cloudrun/hello"
                args    = []
                command = []
                env = [
                  {
                    name  = "SOURCE"
                    value = "remote"
                  },
                  {
                    name  = "TARGET"
                    value = "home"
                  }
                ]
                resources = []
              }
            ]
          }
        ]
      }
    ]
    traffic = [
      {
        percent         = "100"
        latest_revision = "true"
      }
    ]
  }
]

service_iam_binding = [
  {
    id         = "0"
    service_id = "0"
    role       = "roles/run.invoker"
    members    = ["allUsers"]
  }
]

service_iam_policy = []

service_iam_member = []
```
