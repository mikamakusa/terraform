output "policy_name" {
  value = aws_iam_policy.iam_policy.*.name
}

output "policy_arn" {
  value = aws_iam_policy.iam_policy.*.arn
}