# How to use this module ?

## The resource
```hcl-terraform
module "sftp" {
  source          = "../modules/AWS/Transfer"
  iam             = var.iam
  iam_policy      = var.iam_policy
  s3_bucket       = var.s3_bucket
  sftp_ssh_key    = var.sftp_ssh_key
  sftp_user       = var.sftp_user
  transfer_server = var.transfer_server
}
```

## The variables
```hcl-terraform
variable "transfer_server" {
  type = "list"
}

variable "s3_bucket" {
  type = "list"
}

variable "sftp_user" {
  type = "list"
}

variable "sftp_ssh_key" {
  type = "list"
}

variable "iam" {
  type = "list"
}

variable "iam_policy" {
  type = "list"
}
```

## The variable file
```hcl-terraform
iam = [
  {
    id   = "0"
    name = "sftp"
  }
]

iam_policy = [
  {
    id      = "0"
    role_id = "0"
    name    = "transfer-server"
  }
]

s3_bucket = [
  {
    id     = "0"
    bucket = "sftp"
    acl    = "private"
    versioning = [
      {
        enabled    = "true"
        mfa_delete = "false"
      }
    ]
    server_side_encryption_configuration = [
      {
        sse_algorithm = "AES256"
      }
    ]
  }
]

sftp = [
  {
    id                     = "0"
    identity_provider_type = "SERVICE_MANAGED"
    endpoint_type          = "PUBLIC"
    role_id                = "0"
  }
]

sftp_user = [
  {
    id        = "0"
    role_id   = "0"
    server_id = "0"
    user_name = "mike"
    bucket_id = "0"
  },
  {
    id        = "1"
    role_id   = "0"
    server_id = "0"
    user_name = "alex"
    bucket_id = "0"
  }
]

sftp_ssh_key = [
  {
    id        = "0"
    server_id = "0"
    user_id   = "0"
  },
  {
    id        = "1"
    server_id = "0"
    user_id   = "1"
  }
]
```