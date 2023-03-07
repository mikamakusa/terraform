output "content_library" {
  value = try(vsphere_content_library.publication,vsphere_content_library.subscription)
}