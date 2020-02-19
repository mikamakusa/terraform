output "athena_workgroup_id" {
  value = aws_athena_workgroup.athena_workgroup.*.id
}