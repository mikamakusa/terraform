output "iam_policy_attachment_role" {
  value = aws_iam_role_policy_attachment.iam_policy_attachement.*.role
}