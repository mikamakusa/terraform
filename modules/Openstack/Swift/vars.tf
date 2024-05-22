variable "project_name" {
  type = string
}

variable "metadata" {
  type    = map(string)
  default = {}
}

variable "container_v1" {
  type = list(object({
    id                 = number
    name               = string
    container_read     = optional(string)
    container_sync_key = optional(string)
    container_sync_to  = optional(string)
    container_write    = optional(string)
    versioning         = optional(number)
    metadata           = optional(map(string))
    content_type       = optional(string)
    storage_policy     = optional(string)
    force_destroy      = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Optional) The region in which to create the container. If omitted, the region argument of the provider is used. Changing this creates a new container.
name - (Required) A unique name for the container. Changing this creates a new container.
container_read - (Optional) Sets an access control list (ACL) that grants read access. This header can contain a comma-delimited list of users that can read the container (allows the GET method for all objects in the container). Changing this updates the access control list read access.
container_sync_to - (Optional) The destination for container synchronization. Changing this updates container synchronization.
container_sync_key - (Optional) The secret key for container synchronization. Changing this updates container synchronization.
container_write - (Optional) Sets an ACL that grants write access. Changing this updates the access control list write access.
versioning - (Optional) A boolean that can enable or disable object versioning. The default value is false. To use this feature, your Swift version must be 2.24 or higher (as described in the OpenStack Swift Ussuri release notes), and a cloud administrator must have set the allow_object_versioning = true configuration option in Swift. If you cannot set this versioning type, you may want to consider using versioning_legacy instead.
metadata - (Optional) Custom key/value pairs to associate with the container. Changing this updates the existing container metadata.
content_type - (Optional) The MIME type for the container. Changing this updates the MIME type.
storage_policy - (Optional) The storage policy to be used for the container. Changing this creates a new container.
force_destroy - (Optional, Default:false ) A boolean that indicates all objects should be deleted from the container so that the container can be destroyed without error. These objects are not recoverable.
EOF
}

variable "object_v1" {
  type = list(object({
    id                  = number
    container_id        = number
    name                = string
    content             = optional(string)
    content_disposition = optional(string)
    content_encoding    = optional(string)
    content_type        = optional(string)
    copy_from           = optional(string)
    delete_after        = optional(number)
    delete_at           = optional(string)
    detect_content_type = optional(bool)
    etag                = optional(string)
    object_manifest     = optional(string)
    source              = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
container_name - (Required) A unique (within an account) name for the container. The container name must be from 1 to 256 characters long and can start with any character and contain any pattern. Character set must be UTF-8. The container name cannot contain a slash (/) character because this character delimits the container and object name. For example, the path /v1/account/www/pages specifies the www container, not the www/pages container.
content - (Optional) A string representing the content of the object. Conflicts with source and copy_from.
content_disposition - (Optional) A string which specifies the override behavior for the browser. For example, this header might specify that the browser use a download program to save this file rather than show the file, which is the default.
content_encoding - (Optional) A string representing the value of the Content-Encoding metadata.
content_type - (Optional) A string which sets the MIME type for the object.
copy_from - (Optional) A string representing the name of an object used to create the new object by copying the copy_from object. The value is in form {container}/{object}. You must UTF-8-encode and then URL-encode the names of the container and object before you include them in the header. Conflicts with source and content.
delete_after - (Optional) An integer representing the number of seconds after which the system removes the object. Internally, the Object Storage system stores this value in the X-Delete-At metadata item.
delete_at - (Optional) An string representing the date when the system removes the object. For example, "2015-08-26" is equivalent to Mon, Wed, 26 Aug 2015 00:00:00 GMT.
detect_content_type - (Optional) If set to true, Object Storage guesses the content type based on the file extension and ignores the value sent in the Content-Type header, if present.
etag - (Optional) Used to trigger updates.
name - (Required) A unique name for the object.
object_manifest - (Optional) A string set to specify that this is a dynamic large object manifest object. The value is the container and object name prefix of the segment objects in the form container/prefix. You must UTF-8-encode and then URL-encode the names of the container and prefix before you include them in this header.
region - (Optional) The region in which to create the container. If omitted, the region argument of the provider is used. Changing this creates a new container.
source - (Optional) A string representing the local path of a file which will be used as the object's content. Conflicts with source and copy_from.
EOF
}

variable "tempurl_v1" {
  type = list(object({
    id           = number
    container_id = number
    object_id    = number
    ttl          = number
    method       = optional(string)
    regenerate   = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Optional) The region the tempurl is located in.
container - (Required) The container name the object belongs to.
object - (Required) The object name the tempurl is for.
ttl - (Required) The TTL, in seconds, for the URL. For how long it should be valid.
method - (Optional) The method allowed when accessing this URL. Valid values are GET, and POST. Default is GET.
regenerate - (Optional) Whether to automatically regenerate the URL when it has expired. If set to true, this will create a new resource with a new ID and new URL. Defaults to false.
EOF
}