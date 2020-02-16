output "cloudformation_stack_id" {
  value = aws_cloudformation_stack.stack.*.id
}

