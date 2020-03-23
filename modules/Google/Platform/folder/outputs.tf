output "folder_name" {
  value = google_folder.folder.*.name
}