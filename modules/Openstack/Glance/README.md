## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.8.3 |
| <a name="requirement_openstack"></a> [openstack](#requirement\_openstack) | 1.54.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_openstack"></a> [openstack](#provider\_openstack) | 1.54.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [openstack_images_image_access_accept_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/images_image_access_accept_v2) | resource |
| [openstack_images_image_access_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/images_image_access_v2) | resource |
| [openstack_images_image_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/images_image_v2) | resource |
| [openstack_identity_project_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/data-sources/identity_project_v3) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_access_accept_v2"></a> [image\_access\_accept\_v2](#input\_image\_access\_accept\_v2) | The following arguments are supported:<br>region - (Optional) The region in which to obtain the V2 Glance client. A Glance client is needed to manage Image memberships. If omitted, the region argument of the provider is used. Changing this creates a new membership.<br>image\_id - (Required) The proposed image ID.<br>member\_id - (Optional) The member ID, e.g. the target project ID. Optional for admin accounts. Defaults to the current scope project ID.<br>status - (Required) The membership proposal status. Can either be accepted, rejected or pending. | <pre>list(object({<br>    id        = number<br>    image_id  = number<br>    status    = string<br>    member_id = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_image_access_v2"></a> [image\_access\_v2](#input\_image\_access\_v2) | The following arguments are supported:<br>region - (Optional) The region in which to obtain the V2 Glance client. A Glance client is needed to manage Image members. If omitted, the region argument of the provider is used. Changing this creates a new resource.<br>image\_id - (Required) The image ID.<br>member\_id - (Required) The member ID, e.g. the target project ID.<br>status - (Optional) The member proposal status. Optional if admin wants to force the member proposal acceptance. Can either be accepted, rejected or pending. Defaults to pending. Foridden for non-admin users. | <pre>list(object({<br>    id        = number<br>    image_id  = number<br>    status    = optional(string)<br>    member_id = string<br>  }))</pre> | `[]` | no |
| <a name="input_image_v2"></a> [image\_v2](#input\_image\_v2) | The following arguments are supported:<br>container\_format - (Required) The container format. Must be one of "ami", "ari", "aki", "bare", "ovf".<br>disk\_format - (Required) The disk format. Must be one of "ami", "ari", "aki", "vhd", "vmdk", "raw", "qcow2", "vdi", "iso".<br>local\_file\_path - (Optional) This is the filepath of the raw image file that will be uploaded to Glance. Conflicts with image\_source\_url and web\_download.<br>image\_cache\_path - (Optional) This is the directory where the images will be downloaded. Images will be stored with a filename corresponding to the url's md5 hash. Defaults to "$HOME/.terraform/image\_cache"<br>image\_source\_url - (Optional) This is the url of the raw image. If web\_download is not used, then the image will be downloaded in the image\_cache\_path before being uploaded to Glance. Conflicts with local\_file\_path.<br>image\_source\_username - (Optional) The username of basic auth to download image\_source\_url.<br>image\_source\_password - (Optional) The password of basic auth to download image\_source\_url.<br>min\_disk\_gb - (Optional) Amount of disk space (in GB) required to boot image. Defaults to 0.<br>min\_ram\_mb - (Optional) Amount of ram (in MB) required to boot image. Defauts to 0.<br>name - (Required) The name of the image.<br>image\_id - (Optional) Unique ID (valid UUID) of image to create. Changing this creates a new image.<br>properties - (Optional) A map of key/value pairs to set freeform information about an image. See the "Notes" section for further information about properties.<br>protected - (Optional) If true, image will not be deletable. Defaults to false.<br>hidden - (Optional) If true, image will be hidden from public list. Defaults to false.<br>region - (Optional) The region in which to obtain the V2 Glance client. A Glance client is needed to create an Image that can be used with a compute instance. If omitted, the region argument of the provider is used. Changing this creates a new Image.<br>tags - (Optional) The tags of the image. It must be a list of strings. At this time, it is not possible to delete all tags of an image.<br>verify\_checksum - (Optional) If false, the checksum will not be verified once the image is finished uploading. Conflicts with web\_download. Defaults to true when not using web\_download.<br>visibility - (Optional) The visibility of the image. Must be one of "public", "private", "community", or "shared". The ability to set the visibility depends upon the configuration of the OpenStack cloud.<br>web\_download - (Optional) If true, the "web-download" import method will be used to let Openstack download the image directly from the remote source. Conflicts with local\_file\_path. Defaults to false.<br>decompress - (Optional) If true, this provider will decompress downloaded image before uploading it to OpenStack. Decompression algorithm is chosen by checking "Content-Type" header, supported algorithm are: gzip, bzip2 and xz. Defaults to false. Changing this creates a new Image. | <pre>list(object({<br>    id                    = number<br>    container_format      = string<br>    disk_format           = string<br>    name                  = string<br>    local_file_path       = optional(string)<br>    image_cache_path      = optional(string)<br>    image_source_url      = optional(string)<br>    image_source_username = optional(string)<br>    image_source_password = optional(string)<br>    min_disk_gb           = optional(number)<br>    min_ram_mb            = optional(number)<br>    image_id              = optional(string)<br>    properties            = optional(map(string))<br>    protected             = optional(bool)<br>    hidden                = optional(bool)<br>    tags                  = optional(list(string))<br>    verify_checksum       = optional(bool)<br>    visibility            = optional(string)<br>    web_download          = optional(bool)<br>    decompress            = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_image"></a> [image](#output\_image) | n/a |
| <a name="output_image_access"></a> [image\_access](#output\_image\_access) | n/a |
| <a name="output_image_access_accept"></a> [image\_access\_accept](#output\_image\_access\_accept) | n/a |
