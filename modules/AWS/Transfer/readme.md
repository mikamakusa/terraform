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

## The role
```yaml
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "transfer.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

## The service policy
To guarantee access to the bucket and send the logs to the **CloudWatch** service.
```yaml
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowFullAccesstoCloudWatchLogs",
      "Effect": "Allow",
      "Action": [
        "logs:*",
        "s3:*"
      ],
      "Resource": "arn:aws:s3:::*"
    }
  ]
}
```

## The user policy
In order to manage the user access and to prevent a user from browsing another directory than his home directory.
```yaml
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowListingOfUserFolder",
      "Action": [
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${transfer:HomeBucket}"
      ],
      "Condition": {
        "StringLike": {
          "s3:prefix": [
            "${transfer:UserName}/*",
            "${transfer:UserName}"
          ]
        }
      }
    },
    {
      "Sid": "HomeDirObjectAccess",
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObjectVersion",
        "s3:DeleteObject",
        "s3:GetObjectVersion"
      ],
      "Resource": "arn:aws:s3:::${transfer:HomeDirectory}*"
    }
  ]
}
```