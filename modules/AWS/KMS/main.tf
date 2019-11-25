resource "aws_kms_key" "kms_key" {
  count               = length(var.kms_key)
  description         = lookup(var.kms_key[count.index], "description", null)
  key_usage           = lookup(var.kms_key[count.index], "key_usage", null)
  enable_key_rotation = lookup(var.kms_key[count.index], "enable_key_rotation", false)
  policy              = lookup(var.kms_key[count.index], "policy", null)
  is_enabled          = lookup(var.kms_key[count.index], "is_enabled", true)
}

resource "aws_kms_alias" "kms_key_alias" {
  count         = length(var.kms_key) == "0" ? "0" : length(var.kms_alias)
  name          = lookup(var.kms_alias[count.index], "name", null)
  target_key_id = element(aws_kms_key.kms_key.*.id, lookup(var.kms_alias[count.index], "key_id"))
}

resource "aws_kms_ciphertext" "kms_ciphertext" {
  count     = length(var.kms_key) == "0" ? "0" : length(var.ciphertext)
  key_id    = element(aws_kms_key.kms_key.*.id, lookup(var.ciphertext[count.index], "key_id"))
  plaintext = file("${path.cwd}/cipher/${lookup(var.ciphertext[count.index], "plaintext")}.json")
}

resource "aws_kms_grant" "kms_grant" {
  count                 = length(var.kms_key) == "0" ? "0" : length(var.kms_grant)
  grantee_principal     = element(var.iam_role_id, lookup(var.kms_grant[count.index], "role_id"))
  key_id                = element(aws_kms_key.kms_key.*.id, lookup(var.kms_grant[count.index], "key_id"))
  operations            = [lookup(var.kms_grant[count.index], "operations")]
  retiring_principal    = lookup(var.kms_grant[count.index], "retiring_principal", null)
  retire_on_delete      = lookup(var.kms_grant[count.index], "retire_on_delete", false)
  grant_creation_tokens = [lookup(var.kms_grant[count.index], "grant_creation_tokens", null)]
}

resource "aws_kms_external_key" "external_key" {
  count                   = length(var.external_key)
  description             = lookup(var.external_key[count.index], "description", null)
  deletion_window_in_days = lookup(var.external_key[count.index], "deletion_window_in_days")
  enabled                 = lookup(var.external_key[count.index], "enabled", false)
  key_material_base64     = lookup(var.external_key[count.index], "key_material_base64", null)
  policy                  = file("${path.cwd}/kms/${lookup(var.external_key[count.index], "name")}.json")
  valid_to                = lookup(var.external_key[count.index], "valid_to", null)
}