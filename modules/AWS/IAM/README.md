# IAM_POLICY

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| iam\_policy | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| policy\_arn | n/a |
| policy\_name | n/a |

---

# IAM_ROLE
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| iam\_role | n/a | `list` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| iam\_role\_arn | n/a |
| iam\_role\_name | n/a |

---
# IAM_ROLE_POLICY
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| iam\_role\_policy | n/a | `list` | n/a | yes |
| policy | n/a | `any` | n/a | yes |
| role | n/a | `any` | n/a | yes |

## Outputs

No output.

---
# IAM_ROLE_POLICY_ATTACHMENT
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| iam\_policy | n/a | `any` | n/a | yes |
| iam\_role | n/a | `any` | n/a | yes |
| iam\_role\_policy\_attachment | n/a | `list` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| iam\_policy\_attachment\_role | n/a |

