## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| datastore\_index | n/a | `list` | n/a | yes |
| project | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
| index\_id | n/a |

## How to use it ?

### main.tf
```hcl
data "google_project" "project_id" {
  project_id = var.project_id
}

module "datastore_index" {
  source          = "../../../modules/Google/Datastore/Index"
  datastore_index = var.datastore_index
  project         = data.google_project.project_id.id
}
```

### vars.tf
```hcl
variable "project_id" {}

variable "datastore_index" {
  type = list
}
```

### vars.tfvars
```
project_id = ""

datastore_index = [
  {
    id       = "0"
    kind     = ""
    ancestor = ""
    properties = [
      {
        direction = ""
        name      = ""
      },
      {
        direction = ""
        name      = ""
      }
    ]
  }
]
```
