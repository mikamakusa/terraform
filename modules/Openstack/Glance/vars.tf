variable "project_name" {
  type = string
}

variable "image_v2" {
  type = list(object({
    id                    = number
    container_format      = string
    disk_format           = string
    name                  = string
    local_file_path       = optional(string)
    image_cache_path      = optional(string)
    image_source_url      = optional(string)
    image_source_username = optional(string)
    image_source_password = optional(string)
    min_disk_gb           = optional(number)
    min_ram_mb            = optional(number)
    image_id              = optional(string)
    properties            = optional(map(string))
    protected             = optional(bool)
    hidden                = optional(bool)
    tags                  = optional(list(string))
    verify_checksum       = optional(bool)
    visibility            = optional(string)
    web_download          = optional(bool)
    decompress            = optional(bool)
  }))
  default     = optional(map(string))
  description = <<EOF
The following arguments are supported:
container_format - (Required) The container format. Must be one of "ami", "ari", "aki", "bare", "ovf".
disk_format - (Required) The disk format. Must be one of "ami", "ari", "aki", "vhd", "vmdk", "raw", "qcow2", "vdi", "iso".
local_file_path - (Optional) This is the filepath of the raw image file that will be uploaded to Glance. Conflicts with image_source_url and web_download.
image_cache_path - (Optional) This is the directory where the images will be downloaded. Images will be stored with a filename corresponding to the url's md5 hash. Defaults to "$HOME/.terraform/image_cache"
image_source_url - (Optional) This is the url of the raw image. If web_download is not used, then the image will be downloaded in the image_cache_path before being uploaded to Glance. Conflicts with local_file_path.
image_source_username - (Optional) The username of basic auth to download image_source_url.
image_source_password - (Optional) The password of basic auth to download image_source_url.
min_disk_gb - (Optional) Amount of disk space (in GB) required to boot image. Defaults to 0.
min_ram_mb - (Optional) Amount of ram (in MB) required to boot image. Defauts to 0.
name - (Required) The name of the image.
image_id - (Optional) Unique ID (valid UUID) of image to create. Changing this creates a new image.
properties - (Optional) A map of key/value pairs to set freeform information about an image. See the "Notes" section for further information about properties.
protected - (Optional) If true, image will not be deletable. Defaults to false.
hidden - (Optional) If true, image will be hidden from public list. Defaults to false.
region - (Optional) The region in which to obtain the V2 Glance client. A Glance client is needed to create an Image that can be used with a compute instance. If omitted, the region argument of the provider is used. Changing this creates a new Image.
tags - (Optional) The tags of the image. It must be a list of strings. At this time, it is not possible to delete all tags of an image.
verify_checksum - (Optional) If false, the checksum will not be verified once the image is finished uploading. Conflicts with web_download. Defaults to true when not using web_download.
visibility - (Optional) The visibility of the image. Must be one of "public", "private", "community", or "shared". The ability to set the visibility depends upon the configuration of the OpenStack cloud.
web_download - (Optional) If true, the "web-download" import method will be used to let Openstack download the image directly from the remote source. Conflicts with local_file_path. Defaults to false.
decompress - (Optional) If true, this provider will decompress downloaded image before uploading it to OpenStack. Decompression algorithm is chosen by checking "Content-Type" header, supported algorithm are: gzip, bzip2 and xz. Defaults to false. Changing this creates a new Image.
  EOF
}

variable "image_access_accept_v2" {
  type = list(object({
    id        = number
    image_id  = number
    status    = string
    member_id = optional(string)
  }))
  default     = optional(map(string))
  description = <<EOF
The following arguments are supported:
region - (Optional) The region in which to obtain the V2 Glance client. A Glance client is needed to manage Image memberships. If omitted, the region argument of the provider is used. Changing this creates a new membership.
image_id - (Required) The proposed image ID.
member_id - (Optional) The member ID, e.g. the target project ID. Optional for admin accounts. Defaults to the current scope project ID.
status - (Required) The membership proposal status. Can either be accepted, rejected or pending.
  EOF
}

variable "image_access_v2" {
  type = list(object({
    id        = number
    image_id  = number
    status    = optional(string)
    member_id = string
  }))
  default     = optional(map(string))
  description = <<EOF
The following arguments are supported:
region - (Optional) The region in which to obtain the V2 Glance client. A Glance client is needed to manage Image members. If omitted, the region argument of the provider is used. Changing this creates a new resource.
image_id - (Required) The image ID.
member_id - (Required) The member ID, e.g. the target project ID.
status - (Optional) The member proposal status. Optional if admin wants to force the member proposal acceptance. Can either be accepted, rejected or pending. Defaults to pending. Foridden for non-admin users.  
  EOF
}
