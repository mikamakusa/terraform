resource "aws_secretsmanager_secret" "secret" {
  count                   = length(var.secret)
  name                    = lookup(var.secret[count.index], "name", null)
  description             = lookup(var.secret[count.index], "description", null)
  kms_key_id              = element(var.kms_key_id, lookup(var.secret[count.index], "kms_key_id"), null)
  policy                  = file(join(".", [join("/", [path.cwd, lookup(var.secret[count.index], "policy")]), "json"]), null)
  recovery_window_in_days = lookup(var.secret[count.index], "recovery_window_in_days", null)
  rotation_lambda_arn     = element(var.lambda_arn, lookup(var.secret[count.index], "lambda_id"), null)

  dynamic "rotation_rules" {
    for_each = lookup(var.secret[count.index], "rotation_rules")
    content {
      automatically_after_days = lookup(rotation_rules.value, "automatically_after_days", null)
    }
  }

  dynamic "lifecycle" {
    for_each = lookup(var.secret[count.index], "lifecycle")
    content {
      ignore_changes        = [lookup(lifecycle.value, "ignore_changes", null)]
      create_before_destroy = lookup(lifecycle.value, "create_before_destroy", null)
      prevent_destroy       = lookup(lifecycle.value, "prevent_destroy", null)
    }
  }

  tags = lookup(var.secret[count.index], "tags", null)
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  count          = length(var.secret) == "0" ? "0" : length(var.secret_version)
  secret_id      = element(aws_secretsmanager_secret.secret.*.id, lookup(var.secret_version[count.index], "secret_id"))
  secret_string  = file(join(".", [join("/", [path.cwd, lookup(var.secret_version[count.index], "secret_string")]), "json"]), null)
  version_stages = [lookup(var.secret_version[count.index], "version_stages"), null]

  dynamic "lifecycle" {
    for_each = lookup(var.secret_version[count.index], "lifecycle")
    content {
      ignore_changes        = [lookup(lifecycle.value, "ignore_changes", null)]
      create_before_destroy = lookup(lifecycle.value, "create_before_destroy", null)
      prevent_destroy       = lookup(lifecycle.value, "prevent_destroy", null)
    }
  }
}