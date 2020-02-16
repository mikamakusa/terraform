output "cloudformation_stack_set_arn" {
  value = aws_cloudformation_stack_set.stack_set.*.arn
}

output "cloudformation_stack_set_name" {
  value = aws_cloudformation_stack_set.stack_set.*.id
}

output "cloudformation_stack_set_id" {
  value = aws_cloudformation_stack_set.stack_set.*.stack_set_id
}