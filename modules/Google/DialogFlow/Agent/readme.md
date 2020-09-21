## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| agent | n/a | `list` | n/a | yes |
| project | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| avatar\_uri\_backend | n/a |
| id | n/a |

## How to Use it ?
### main.tf
```hcl
data "google_project" "project" {
  project_id = var.project_id
}

module "dialogflow_Agent" {
  source  = "../../../modules/Google/DialogFlow/Agent"
  agent   = var.agent
  project = data.google_project.project.project_id
}
```

### vars.tf
```hcl
variable "agent" {
  type = list
}

variable "project" {}
```

### vars.tfvars
```
project_id = "cka-test-project"

agent = [
  {
    id                       = "0"
    display_name             = "test_agent"
    default_language_code    = "fr"
    time_zone                = "Europe/Paris"
    supported_language_codes = ["de", "es", "en"]
    enable_logging           = "true"
    match_mode               = "MATCH_MODE_ML_ONLY"
    classification_threshold = "0.3"
    api_version              = "API_VERSION_V2_BETA_1"
    tier                     = "TIER_STANDARD"
  }
]
```
