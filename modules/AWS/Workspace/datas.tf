data "aws_directory_service_directory" "this" {
  directory_id = var.directory_service_id
}