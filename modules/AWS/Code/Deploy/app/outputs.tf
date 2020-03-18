output "id" {
  value = aws_codedeploy_app.app.*.id
}

output "name" {
  value = aws_codedeploy_app.app.*.name
}