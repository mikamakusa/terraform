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
| project | n/a | `any` | n/a | yes |
| service | n/a | `list` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| location | n/a |
| name | n/a |

## How to use it
### main.tf
```hcl
module "CloudRun_service" {
  source   = "../../../modules/Google/CloudRun/Service"
  location = var.location
  project  = data.google_project.project.id
  service  = var.service
}
```

### vars.tf
```hcl
variable "service" {
  type = list
}

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
```
