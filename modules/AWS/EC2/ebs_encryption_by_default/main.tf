resource "aws_ebs_encryption_by_default" "ebs_encryption_by_default" {
  enabled = var.ebs_encryption_by_default
}