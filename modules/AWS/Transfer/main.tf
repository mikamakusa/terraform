resource "aws_iam_role" "iam_role" {
  count              = length(var.iam)
  assume_role_policy = "${file(path.cwd)}/role/${lookup(var.iam[count.index], "assume_role_policy")}.json"
}

resource "aws_iam_role_policy" "iam_role_policy" {
  count  = length(var.iam) == "0" ? "0" : length(var.iam_policy)
  policy = "${file(path.cwd)}/policy/${lookup(var.iam_policy[count.index], "policy")}.json"
  role   = element(aws_iam_role.iam_role.*.name, lookup(var.iam_policy[count.index], "role_id"))
}

resource "aws_s3_bucket" "bucket" {
  count  = length(var.s3_bucket)
  bucket = lookup(var.s3_bucket[count.index], "bucket")
  acl    = lookup(var.s3_bucket[count.index], "acl")

  dynamic "versioning" {
    for_each = lookup(var.s3_bucket[count.index], "versioning")
    content {
      enabled    = lookup(versioning.value, "enabled")
      mfa_delete = lookup(versioning.value, "mfa_delete")
    }
  }

  dynamic "server_side_encryption_configuration" {
    for_each = lookup(var.s3_bucket[count.index], "server_side_encryption_configuration")
    content {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = lookup(server_side_encryption_configuration.value, "sse_algorithm")
        }
      }
    }
  }
}

resource "aws_transfer_server" "transfer_server" {
  count                  = length(var.transfer_server)
  endpoint_type          = lookup(var.transfer_server[count.index], "endpoint_type", null)
  invocation_role        = lookup(var.transfer_server[count.index], "invocation_role", null)
  url                    = lookup(var.transfer_server[count.index], "url", null)
  identity_provider_type = lookup(var.transfer_server[count.index], "identity_provider_type", null)
  logging_role           = lookup(var.transfer_server[count.index], "logging_role", null)
  force_destroy          = lookup(var.transfer_server[count.index], "force_destroy", false)
}

resource "aws_transfer_user" "sftp_user" {
  count          = length(var.transfer_server) == "0" ? "0" : length(var.sftp_user)
  role           = element(aws_iam_role.iam_role.*.arn, lookup(var.sftp_user[count.index], "role_id"))
  server_id      = element(aws_transfer_server.transfer_server.*.id, lookup(var.sftp_user[count.index], "server_id"))
  user_name      = lookup(var.sftp_user[count.index], "user_name")
  home_directory = "/${element(aws_s3_bucket.bucket.*.id, lookup(var.sftp_user[count.index], "bucket_id"))}/${lookup(var.sftp_user[count.index], "user_name")}"
}

resource "aws_transfer_ssh_key" "sftp_ssh_key" {
  count     = length(var.sftp_user) == "0" ? "0" : length(var.sftp_ssh_key)
  body      = "${file(path.cwd)}/ssh_keys/${element(aws_transfer_user.sftp_user.*.user_name, lookup(var.sftp_ssh_key[count.index], "user_id"))}.pub"
  server_id = element(aws_transfer_server.transfer_server.*.id, lookup(var.sftp_ssh_key[count.index], "server_id"))
  user_name = element(aws_transfer_user.sftp_user.*.user_name, lookup(var.sftp_ssh_key[count.index], "user_id"))
}