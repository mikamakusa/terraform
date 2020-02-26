output "service_linked_role_arn" {
  value = aws_iam_service_linked_role.service_linked_role.*.arn
}