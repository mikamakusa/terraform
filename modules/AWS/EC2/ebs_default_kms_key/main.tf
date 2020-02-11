resource "aws_ebs_default_kms_key" "ebs_default_kms_key" {
  count = length(var.ebs_default_kms_key)
  key_arn = element(var.kms_key_id, lookup(var.ebs_default_kms_key[count.index], "kms_key_id"))
}