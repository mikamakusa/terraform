output "id" {
  value = aws_codebuild_project.project.*.id
}

output "arn" {
  value = aws_codebuild_project.project.*.arn
}

output "badge_url" {
  value = aws_codebuild_project.project.*.badge_url
}