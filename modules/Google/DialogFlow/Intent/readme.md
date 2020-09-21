## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| depends | n/a | `any` | n/a | yes |
| intent | n/a | `list` | n/a | yes |
| project | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
| name | n/a |
| root\_followup\_intent\_name | n/a |

## How to use it ?
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

module "dialogflow_intent" {
  source  = "../../../modules/Google/DialogFlow/Intent"
  intent  = var.intent
  project = data.google_project.project.project_id
  depends = module.dialogflow_Agent
}
```

### vars.tf
```hcl
variable "agent" {
  type = list
}

variable "intent" {
  type = list
}
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

intent = [
  {
    id             = "0"
    display_name   = "test_intent"
    priority       = "1"
    is_fallback    = "false"
    ml_disabled    = "true"
    action         = "some_action"
    reset_contexts = "true"
  }
]
```
