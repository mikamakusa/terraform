variable "tenant_id" {
  type        = string
  description = "Id of the tenant"
}

variable "floating_ip_address" {
  type        = string
  default     = null
  description = "The name of the flotting ip address - to be used as datasource in floatting ip association"
}

variable "os_images" {
  type = list(map(object({
    container_format      = string
    disk_format           = string
    name                  = string
    local_file_path       = optional(string)
    image_cache_path      = optional(string)
    image_source_url      = optional(string)
    image_source_username = optional(string)
    image_source_password = optional(string)
    min_disk_gb           = optional(number, 0)
    min_ram_mb            = optional(number, 0)
    image_id              = optional(string)
    properties            = optional(map(string))
    protected             = optional(bool, false)
    hidden                = optional(bool, false)
    region                = optional(string)
    tags                  = optional(set(string))
    verify_checksum       = optional(bool, false)
    web_download          = optional(bool, false)
    decompress            = optional(bool, false)
    visibility            = optional(string)
  })))
  default     = []
  description = <<-EOT
    container_format      = string / The container format. Must be one of "ami", "ari", "aki", "bare", "ovf".
    disk_format           = string / The disk format. Must be one of "ami", "ari", "aki", "vhd", "vmdk", "raw", "qcow2", "vdi", "iso".
    name                  = string / The name of the image.
    local_file_path       = optional(string) / This is the filepath of the raw image file that will be uploaded to Glance. Conflicts with image_source_url and web_download.
    image_cache_path      = optional(string) / This is the directory where the images will be downloaded. Images will be stored with a filename corresponding to the url's md5 hash.
    image_source_url      = optional(string) / This is the url of the raw image. If web_download is not used, then the image will be downloaded in the image_cache_path before being uploaded to Glance. Conflicts with local_file_path.
    image_source_username = optional(string) / The username of basic auth to download image_source_url.
    image_source_password = optional(string) / The password of basic auth to download image_source_url.
    min_disk_gb           = optional(number) / Amount of disk space (in GB) required to boot image.
    min_ram_mb            = optional(number) / Amount of ram (in MB) required to boot image.
    image_id              = optional(string) / Unique ID (valid UUID) of image to create.
    properties            = optional(map(string)) / A map of key/value pairs to set freeform information about an image.
    protected             = optional(bool) / If true, image will not be deletable.
    hidden                = optional(bool) / If true, image will be hidden from public list.
    region                = optional(string) / The region in which to obtain the V2 Glance client. A Glance client is needed to create an Image that can be used with a compute instance.
    tags                  = optional(set(string)) / The tags of the image.
    verify_checksum       = optional(bool) /  If false, the checksum will not be verified once the image is finished uploading.
    web_download          = optional(bool) / If true, the "web-download" import method will be used to let Openstack download the image directly from the remote source.
    decompress            = optional(bool) / If true, this provider will decompress downloaded image before uploading it to OpenStack.
    visibility            = optional(string) / The visibility of the image. Must be one of "public", "private", "community", or "shared".
EOT
}

variable "flavors" {
  type = list(map(object({
    id           = number
    disk         = string
    name         = string
    ram          = number
    vcpus        = number
    flavor_id    = optional(string)
    ephemeral    = optional(number, 0)
    swap         = optional(number, 0)
    is_public    = optional(bool, false)
    rx_tx_factor = optional(number, 1)
    extra_specs  = optional(map(string))
  })))
  default     = []
  description = <<-EOT
    id           = number
    disk         = string / The amount of disk space in GiB to use for the root (/) partition.
    name         = string / A unique name for the flavor.
    ram          = number / The amount of RAM to use, in megabytes.
    vcpus        = number / The number of virtual CPUs to use
    flavor_id    = optional(number) / Unique ID (integer or UUID) of flavor to create.
    ephemeral    = optional(number) / Unique ID (integer or UUID) of flavor to create.
    swap         = optional(number) / The amount of disk space in megabytes to use. If unspecified, the default is 0.
    is_public    = optional(bool) / Whether the flavor is public.
    rx_tx_factor = optional(number) / RX/TX bandwith factor. The default is 1.
    extra_specs  = optional(map(string)) / Key/Value pairs of metadata for the flavor.
EOT
}

variable "flavor_access" {
  type = list(map(object({
    id        = number
    flavor_id = number
    tenant_id = number
  })))
  default     = []
  description = <<-EOT
    id        = number
    flavor_id = number / id of the flavor, related to flavor/id variable
    tenant_id = number / Id of the tenant
EOT
}

variable "instance" {
  type = list(map(object({
    id                  = number
    name                = string
    region              = optional(string)
    image_id            = number
    flavor_id           = number
    user_data           = optional(string)
    security_groups     = optional(set(string))
    availability_zone   = optional(string)
    metadata            = optional(map(string))
    admin_pass          = optional(string)
    key_pair            = optional(string)
    power_state         = optional(string)
    stop_before_destroy = optional(bool, false)
    force_delete        = optional(bool, false)
    personality = optional(object({
      content = string
      file    = string
    }), [])
    network = optional(list(object({
      uuid           = string
      name           = string
      port           = string
      fixed_ip_v4    = optional(string)
      access_network = optional(bool, false)
    })), [])
    block_device = optional(list(object({
      uuid                  = string
      source_type           = string
      guest_format          = optional(string)
      boot_index            = optional(number)
      destination_type      = optional(string)
      delete_on_termination = optional(bool, false)
      volume_type           = optional(string)
      device_type           = optional(string)
      disk_bus              = optional(string)
      multiattach           = optional(string)
    })), [])
    scheduler_hints = optional(object({
      group                 = optional(string)
      different_host        = optional(list(string))
      same_host             = optional(list(string))
      query                 = optional(list(string))
      target_cell           = optional(string)
      different_cell        = optional(list(string))
      additional_properties = optional(map(string))
      build_near_host_ip    = optional(string)
    }), [])
    vendor_options = optional(object({
      ignore_resize_confirmation  = optional(bool, false)
      detach_ports_before_destroy = optional(bool, false)
    }), [])
  })))
  default     = []
  description = <<-EOT
  type = list(map)
    id                  = number
    name                = string / A unique name for the resource.
    region              = (optional)string / The region in which to create the server instance. If omitted, the region argument of the provider is used.
    image_id            = number / related to image id of the variable os_image
    flavor_id           = number / related to flavor id of the variable flavors
    user_data           = string / The user data to provide when launching the instance.
    security_groups     = optional(set(string)) / An array of one or more security group names to associate with the server.
    availability_zone   = string / The availability zone in which to create the server.
    metadata            = map(string) / Metadata key/value pairs to make available from within the instance.
    admin_pass          = string / The administrative password to assign to the server.
    key_pair            = string / The name of a key pair to put on the server. The key pair must already be created and associated with the tenant's account.
    power_state         = string / Provide the VM state. Only 'active', 'shutoff' and 'shelved_offloaded' are supported values.
    stop_before_destroy = optional(bool, true) / Whether to try stop instance gracefully before destroying it, thus giving chance for guest OS daemons to stop correctly.
    force_delete        = optional(bool, true) / Whether to force the OpenStack instance to be forcefully deleted.
    personality = optional(object)
      content = string / The contents of the file. Limited to 255 bytes
      file    = string / The absolute path of the destination file.
    network = optional(list(object))
      uuid           = string / (Required unless port or name is provided) The network UUID to attach to the server.
      name           = string / (Required unless uuid or port is provided) The human-readable name of the network.
      port           = string / (Required unless uuid or name is provided) The port UUID of a network to attach to the server.
      fixed_ip_v4    = optional(string) / Specifies a fixed IPv4 address to be used on this network.
      access_network = optional(bool) / Specifies if this network should be used for provisioning access.
    block_device = optional(list(object))
      uuid                  = string / (Required unless source_type is set to "blank" ) The UUID of the image, volume, or snapshot.
      source_type           = string / (Required) The source type of the device. Must be one of "blank", "image", "volume", or "snapshot".
      guest_format          = optional(string) / Specifies the guest server disk file system format, such as ext2, ext3, ext4, xfs or swap. Swap block device mappings have the following restrictions: source_type must be blank and destination_type must be local and only one swap disk per server and the size of the swap disk must be less than or equal to the swap size of the flavor.
      boot_index            = optional(number) / The boot index of the volume. It defaults to 0.
      destination_type      = optional(string) / The type that gets created. Possible values are "volume" and "local".
      delete_on_termination = optional(bool) / Delete the volume / block device upon termination of the instance.
      volume_type           = optional(string) / The volume type that will be used, for example SSD or HDD storage.
      device_type           = optional(string) / The low-level device type that will be used.
      disk_bus              = optional(string) / The low-level disk bus that will be used.
      multiattach           = optional(string) / Enable the attachment of multiattach-capable volumes.
    scheduler_hints = optional(object)
      group                 = optional(string) / A UUID of a Server Group. The instance will be placed into that group.
      different_host        = optional(list(string)) / A list of instance UUIDs. The instance will be scheduled on a different host than all other instances.
      same_host             = optional(list(string)) / A list of instance UUIDs. The instance will be scheduled on the same host of those specified.
      query                 = optional(list(string)) / A conditional query that a compute node must pass in order to host an instance.
      target_cell           = optional(string) / The name of a cell to host the instance.
      different_cell        = optional(list(string)) / The names of cells where not to build the instance.
      additional_properties = optional(map(string)) / An IP Address in CIDR form
      build_near_host_ip    = optional(string) / Arbitrary key/value pairs of additional properties to pass to the scheduler.
    vendor_options = optional(object)
      ignore_resize_confirmation  = optional(bool) / Boolean to control whether to ignore manual confirmation of the instance resizing.
      detach_ports_before_destroy = optional(bool) / Whether to try to detach all attached ports to the vm before destroying it to make sure the port state is correct after the vm destruction.
EOT
}

variable "floatingip" {
  type = list(map(object({
    pool   = string
    region = string
  })))
  default     = []
  description = <<-EOT
    pool   = string / The name of the pool from which to obtain the floating IP.
    region = string / The region in which to obtain the V2 Compute client.
EOT
}

variable "floatingip_associate" {
  type = list(map(object({
    floating_ip           = string
    instance_id           = string
    region                = optional(string)
    fixed_ip              = optional(string)
    wait_until_associated = optional(bool, false)
  })))
  default     = []
  description = <<-EOT
    floating_ip           = string / The floating IP to associate.
    instance_id           = string / The instance to associate the floating IP with.
    region                = optional(string) / The region in which to obtain the V2 Compute client
    fixed_ip              = optional(string) / The specific IP address to direct traffic to.
    wait_until_associated = optional(bool) / In cases where the OpenStack environment does not automatically wait until the association has finished, set this option to have Terraform poll the instance until the floating IP has been associated.
EOT
}

variable "secgroup" {
  type = list(map(object({
    description = string
    name        = string
    region      = optional(string)
    rule = optional(list(object({
      from_port     = number
      to_port       = number
      ip_protocol   = string
      cidr          = optional(string)
      from_group_id = optional(string)
      self          = optional(bool)
    })), [])
  })))
  default     = []
  description = <<-EOT
    description = string / A description for the security group.
    name        = string / A unique name for the security group.
    region      = optional(string) / The region in which to obtain the V2 Compute client.
    rule = optional(list(object)) / A rule describing how the security group operates.
      from_port     = number / An integer representing the lower bound of the port range to open.
      to_port       = number / An integer representing the upper bound of the port range to open.
      ip_protocol   = string / The protocol type that will be allowed.
      cidr          = optional(string) / Required if from_group_id or self is empty. The IP range that will be the source of network traffic to the security group. Use 0.0.0.0/0 to allow all IP addresses.
      from_group_id = optional(string) / Required if cidr or self is empty. The ID of a group from which to forward traffic to the parent group.
      self          = optional(bool, null) / Required if cidr and from_group_id is empty. If true, the security group itself will be added as a source to this ingress rule.
EOT
}

variable "images" {
  type        = string
  default     = null
  description = "the name of the image - to be used as datasource in instances"
}

variable "flavor" {
  type        = string
  default     = null
  description = "The name of the flavor - to be used as datasource in instances"
}