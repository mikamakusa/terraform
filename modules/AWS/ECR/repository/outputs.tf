output "ecr_repository_name" {
  value = aws_ecr_repository.repository.*.name
}