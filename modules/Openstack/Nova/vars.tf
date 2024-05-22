variable "project_name" {
  type = string
}

variable "metadata" {
  type    = map(string)
  default = {}
}

variable "image_name" {
  type    = string
  default = null
}

variable "volume_name" {
  type = string
  default = null
}

variable "aggregate_v2" {
  type = list(object({
    id       = number
    name     = string
    zone     = optional(string)
    hosts    = optional(list(string))
    metadata = optional(map(string))
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Optional) The region in which to create the Host Aggregate. If omitted, the region argument of the provider is used. Changing this creates a new Host Aggregate.
name - The name of the Host Aggregate
zone - (Optional) The name of the Availability Zone to use. If ommited, it will take the default availability zone.
hosts - (Optional) The list of hosts contained in the Host Aggregate. The hosts must be added to Openstack and visible in the web interface, or the provider will fail to add them to the host aggregate.
metadata - (Optional) The metadata of the Host Aggregate. Can be useful to indicate scheduler hints.
  EOF
}

variable "flavor_access_v2" {
  type = list(object({
    id        = number
    flavor_id = number
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Optional) The region in which to obtain the V2 Compute client. If omitted, the region argument of the provider is used. Changing this creates a new flavor access.
flavor_id - (Required) The UUID of flavor to use. Changing this creates a new flavor access.
  EOF
}

variable "flavor_v2" {
  type = list(object({
    id           = number
    disk         = number
    name         = string
    ram          = number
    vcpus        = number
    description  = optional(string)
    flavor_id    = optional(string)
    ephemeral    = optional(bool)
    swap         = optional(number)
    rx_tx_factor = optional(number)
    is_public    = optional(bool)
    extra_specs  = optional(map(string))
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Optional) The region in which to obtain the V2 Compute client. Flavors are associated with accounts, but a Compute client is needed to create one. If omitted, the region argument of the provider is used. Changing this creates a new flavor.
name - (Required) A unique name for the flavor. Changing this creates a new flavor.
description - (Optional) The description of the flavor. Changing this updates the description of the flavor. Requires microversion >= 2.55.
ram - (Required) The amount of RAM to use, in megabytes. Changing this creates a new flavor.
flavor_id - (Optional) Unique ID (integer or UUID) of flavor to create. Changing this creates a new flavor.
vcpus - (Required) The number of virtual CPUs to use. Changing this creates a new flavor.
disk - (Required) The amount of disk space in GiB to use for the root (/) partition. Changing this creates a new flavor.
ephemeral - (Optional) The amount of ephemeral in GiB. If unspecified, the default is 0. Changing this creates a new flavor.
swap - (Optional) The amount of disk space in megabytes to use. If unspecified, the default is 0. Changing this creates a new flavor.
rx_tx_factor - (Optional) RX/TX bandwith factor. The default is 1. Changing this creates a new flavor.
is_public - (Optional) Whether the flavor is public. Changing this creates a new flavor.
extra_specs - (Optional) Key/Value pairs of metadata for the flavor.
  EOF
}

variable "instance_v2" {
  type = list(object({
    id                      = number
    name                    = string
    image_id                = optional(number)
    flavor_id               = optional(number)
    user_data               = optional(string)
    security_groups         = optional(list(string))
    availability_zone_hints = optional(string)
    availability_zone       = optional(string)
    network_mode            = optional(string)
    metadata                = optional(map(string))
    config_drive            = optional(bool)
    admin_pass              = optional(string)
    key_pair                = optional(string)
    stop_before_destroy     = optional(bool)
    force_delete            = optional(bool)
    power_state             = optional(string)
    tags                    = optional(list(string))
    network = optional(list(object({
      uuid           = string
      name           = string
      port           = string
      fixed_ip_v4    = optional(string)
      fixed_ip_v6    = optional(string)
      access_network = optional(bool)
    })), [])
    block_device = optional(list(object({
      source_type           = string
      uuid                  = optional(string)
      disk_bus              = optional(string)
      volume_size           = optional(number)
      volume_type           = optional(string)
      guest_format          = optional(string)
      boot_index            = optional(number)
      destination_type      = optional(string)
      delete_on_termination = optional(bool)
      device_type           = optional(string)
      multiattach           = optional(bool)
    })), [])
    scheduler_hints = optional(list(object({
      group                 = optional(string)
      different_host        = optional(list(string))
      same_host             = optional(list(string))
      query                 = optional(list(string))
      target_cell           = optional(string)
      different_cell        = optional(list(string))
      build_near_host_ip    = optional(string)
      additional_properties = optional(map(string))
    })), [])
    personality = optional(list(object({
      content = string
      file    = string
    })), [])
    vendor_options = optional(list(object({
      ignore_resize_confirmation  = optional(bool)
      detach_ports_before_destroy = optional(bool)
    })), [])
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Optional) The region in which to create the server instance. If omitted, the region argument of the provider is used. Changing this creates a new server.
name - (Required) A unique name for the resource.
image_id - (Optional; Required if image_name is empty and not booting from a volume. Do not specify if booting from a volume.) The image ID of the desired image for the server. Changing this rebuilds the existing server.
image_name - (Optional; Required if image_id is empty and not booting from a volume. Do not specify if booting from a volume.) The name of the desired image for the server. Changing this rebuilds the existing server.
flavor_id - (Optional; Required if flavor_name is empty) The flavor ID of the desired flavor for the server. Changing this resizes the existing server.
flavor_name - (Optional; Required if flavor_id is empty) The name of the desired flavor for the server. Changing this resizes the existing server.
user_data - (Optional) The user data to provide when launching the instance. Changing this creates a new server.
security_groups - (Optional) An array of one or more security group names to associate with the server. Changing this results in adding/removing security groups from the existing server. Note: When attaching the instance to networks using Ports, place the security groups on the Port and not the instance. Note: Names should be used and not ids, as ids trigger unnecessary updates.
availability_zone_hints - (Optional) The availability zone in which to create the server. This argument is preferred to availability_zone, when scheduling the server on a particular host or node. Conflicts with availability_zone. Changing this creates a new server.
availability_zone - (Optional) The availability zone in which to create the server. Conflicts with availability_zone_hints. Changing this creates a new server.
network - (Optional) An array of one or more networks to attach to the instance. The network object structure is documented below. Changing this creates a new server.
network_mode - (Optional) Special string for network option to create the server. network_mode can be "auto" or "none". Please see the following reference for more information. Conflicts with network.
metadata - (Optional) Metadata key/value pairs to make available from within the instance. Changing this updates the existing server metadata.
config_drive - (Optional) Whether to use the config_drive feature to configure the instance. Changing this creates a new server.
admin_pass - (Optional) The administrative password to assign to the server. Changing this changes the root password on the existing server.
key_pair - (Optional) The name of a key pair to put on the server. The key pair must already be created and associated with the tenant's account. Changing this creates a new server.
block_device - (Optional) Configuration of block devices. The block_device structure is documented below. Changing this creates a new server. You can specify multiple block devices which will create an instance with multiple disks. This configuration is very flexible, so please see the following reference for more information.
scheduler_hints - (Optional) Provide the Nova scheduler with hints on how the instance should be launched. The available hints are described below.
personality - (Optional) Customize the personality of an instance by defining one or more files and their contents. The personality structure is described below. Changing this rebuilds the existing server.
stop_before_destroy - (Optional) Whether to try stop instance gracefully before destroying it, thus giving chance for guest OS daemons to stop correctly. If instance doesn't stop within timeout, it will be destroyed anyway.
force_delete - (Optional) Whether to force the OpenStack instance to be forcefully deleted. This is useful for environments that have reclaim / soft deletion enabled.
power_state - (Optional) Provide the VM state. Only 'active', 'shutoff' and 'shelved_offloaded' are supported values. Note: If the initial power_state is the shutoff the VM will be stopped immediately after build and the provisioners like remote-exec or files are not supported.
tags - (Optional) A set of string tags for the instance. Changing this updates the existing instance tags.
vendor_options - (Optional) Map of additional vendor-specific options. Supported options are described below.

The network block supports:
uuid - (Required unless port or name is provided) The network UUID to attach to the server. Changing this creates a new server.
name - (Required unless uuid or port is provided) The human-readable name of the network. Changing this creates a new server.
port - (Required unless uuid or name is provided) The port UUID of a network to attach to the server. Changing this creates a new server.
fixed_ip_v4 - (Optional) Specifies a fixed IPv4 address to be used on this network. Changing this creates a new server.
access_network - (Optional) Specifies if this network should be used for provisioning access. Accepts true or false. Defaults to false.

The block_device block supports:
uuid - (Required unless source_type is set to "blank" ) The UUID of the image, volume, or snapshot. Changing this creates a new server.
source_type - (Required) The source type of the device. Must be one of "blank", "image", "volume", or "snapshot". Changing this creates a new server.
volume_size - The size of the volume to create (in gigabytes). Required in the following combinations: source=image and destination=volume, source=blank and destination=local, and source=blank and destination=volume. Changing this creates a new server.
guest_format - (Optional) Specifies the guest server disk file system format, such as ext2, ext3, ext4, xfs or swap. Swap block device mappings have the following restrictions: source_type must be blank and destination_type must be local and only one swap disk per server and the size of the swap disk must be less than or equal to the swap size of the flavor. Changing this creates a new server.
boot_index - (Optional) The boot index of the volume. It defaults to 0. Changing this creates a new server.
destination_type - (Optional) The type that gets created. Possible values are "volume" and "local". Changing this creates a new server.
delete_on_termination - (Optional) Delete the volume / block device upon termination of the instance. Defaults to false. Changing this creates a new server.
volume_type - (Optional) The volume type that will be used, for example SSD or HDD storage. The available options depend on how your specific OpenStack cloud is configured and what classes of storage are provided. Changing this creates a new server.
device_type - (Optional) The low-level device type that will be used. Most common thing is to leave this empty. Changing this creates a new server.
disk_bus - (Optional) The low-level disk bus that will be used. Most common thing is to leave this empty. Changing this creates a new server.
multiattach - (Optional) Enable the attachment of multiattach-capable volumes.

The scheduler_hints block supports:
group - (Optional) A UUID of a Server Group. The instance will be placed into that group.
different_host - (Optional) A list of instance UUIDs. The instance will be scheduled on a different host than all other instances.
same_host - (Optional) A list of instance UUIDs. The instance will be scheduled on the same host of those specified.
query - (Optional) A conditional query that a compute node must pass in order to host an instance. The query must use the JsonFilter syntax which is described here. At this time, only simple queries are supported. Compound queries using and, or, or not are not supported. An example of a simple query is:
[">=", "$free_ram_mb", "1024"]
Copy
target_cell - (Optional) The name of a cell to host the instance.
different_cell - (Optional) The names of cells where not to build the instance.
build_near_host_ip - (Optional) An IP Address in CIDR form. The instance will be placed on a compute node that is in the same subnet.
additional_properties - (Optional) Arbitrary key/value pairs of additional properties to pass to the scheduler.

The personality block supports:
file - (Required) The absolute path of the destination file.
content - (Required) The contents of the file. Limited to 255 bytes.

The vendor_options block supports:
ignore_resize_confirmation - (Optional) Boolean to control whether to ignore manual confirmation of the instance resizing. This can be helpful to work with some OpenStack clouds which automatically confirm resizing of instances after some timeout.
detach_ports_before_destroy - (Optional) Whether to try to detach all attached ports to the vm before destroying it to make sure the port state is correct after the vm destruction. This is helpful when the port is not deleted.
  EOF
}

variable "interface_attach_v2" {
  type = list(object({
    id          = number
    instance_id = number
    port_id     = optional(string)
    network_id  = optional(number)
    fixed_ip    = optional(string)
  }))
  default     = []
  description = <<EOF
The following attributes are exported:
region - See Argument Reference above.
instance_id - See Argument Reference above.
port_id - See Argument Reference above.
network_id - See Argument Reference above.
fixed_ip - See Argument Reference above.
  EOF
}

variable "keypair_v2" {
  type = list(object({
    id          = number
    name        = string
    public_key  = optional(string)
    user_id     = optional(string)
    value_specs = optional(map(string))
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Optional) The region in which to obtain the V2 Compute client. Keypairs are associated with accounts, but a Compute client is needed to create one. If omitted, the region argument of the provider is used. Changing this creates a new keypair.
name - (Required) A unique name for the keypair. Changing this creates a new keypair.
public_key - (Optional) A pregenerated OpenSSH-formatted public key. Changing this creates a new keypair. If a public key is not specified, then a public/private key pair will be automatically generated. If a pair is created, then destroying this resource means you will lose access to that keypair forever.
user_id - (Optional) This allows administrative users to operate key-pairs of specified user ID. For this feature your need to have openstack microversion 2.10 (Liberty) or later.
value_specs - (Optional) Map of additional options.
  EOF
}

variable "quotaset_v2" {
  type = list(object({
    id                          = number
    fixed_ips                   = optional(number)
    floating_ips                = optional(number)
    injected_file_content_bytes = optional(number)
    injected_file_path_bytes    = optional(number)
    injected_files              = optional(number)
    key_pairs                   = optional(number)
    metadata_items              = optional(number)
    ram                         = optional(number)
    security_group_rules        = optional(number)
    security_groups             = optional(number)
    server_group_members        = optional(number)
    server_groups               = optional(number)
    cores                       = optional(number)
    instances                   = optional(number)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Optional) The region in which to create the volume. If omitted, the region argument of the provider is used. Changing this creates a new quotaset.
project_id - (Required) ID of the project to manage quotas. Changing this creates a new quotaset.
fixed_ips - (Optional) Quota value for fixed IPs. Changing this updates the existing quotaset.
floating_ips - (Optional) Quota value for floating IPs. Changing this updates the existing quotaset.
injected_file_content_bytes - (Optional) Quota value for content bytes of injected files. Changing this updates the existing quotaset.
injected_file_path_bytes - (Optional) Quota value for path bytes of injected files. Changing this updates the existing quotaset.
injected_files - (Optional) Quota value for injected files. Changing this updates the existing quotaset.
key_pairs - (Optional) Quota value for key pairs. Changing this updates the existing quotaset.
metadata_items - (Optional) Quota value for metadata items. Changing this updates the existing quotaset.
ram - (Optional) Quota value for RAM. Changing this updates the existing quotaset.
security_group_rules - (Optional) Quota value for security group rules. Changing this updates the existing quotaset.
security_groups - (Optional) Quota value for security groups. Changing this updates the existing quotaset.
cores - (Optional) Quota value for cores. Changing this updates the existing quotaset.
instances - (Optional) Quota value for instances. Changing this updates the existing quotaset.
server_groups - (Optional) Quota value for server groups. Changing this updates the existing quotaset.
server_group_members - (Optional) Quota value for server groups members. Changing this updates the existing quotaset.
  EOF
}

variable "servergroup_v2" {
  type = list(object({
    id          = number
    name        = string
    policies    = optional(list(string))
    value_specs = optional(map(string))
    rules = optional(list(object({
      max_server_per_host = optional(number)
    })), [])
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Optional) The region in which to obtain the V2 Compute client. If omitted, the region argument of the provider is used. Changing this creates a new server group.
name - (Required) A unique name for the server group. Changing this creates a new server group.
policies - (Optional) A list of exactly one policy name to associate with the server group. See the Policies section for more information. Changing this creates a new server group.
value_specs - (Optional) Map of additional options.
rules - (Optional) The rules which are applied to specified policy. Currently, only the max_server_per_host rule is supported for the anti-affinity policy.

Policies
affinity - All instances/servers launched in this group will be hosted on the same compute node.
anti-affinity - All instances/servers launched in this group will be hosted on different compute nodes.
soft-affinity - All instances/servers launched in this group will be hosted on the same compute node if possible, but if not possible they still will be scheduled instead of failure. To use this policy your OpenStack environment should support Compute service API 2.15 or above.
soft-anti-affinity - All instances/servers launched in this group will be hosted on different compute nodes if possible, but if not possible they still will be scheduled instead of failure. To use this policy your OpenStack environment should support Compute service API 2.15 or above.
  EOF
}

variable "volume_attach_v2" {
  type = list(object({
    id          = number
    instance_id = number
    volume_id   = string
    device      = optional(string)
    multiattach = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Optional) The region in which to obtain the V2 Compute client. A Compute client is needed to create a volume attachment. If omitted, the region argument of the provider is used. Changing this creates a new volume attachment.
instance_id - (Required) The ID of the Instance to attach the Volume to.
volume_id - (Required) The ID of the Volume to attach to an Instance.
device - (Optional) The device of the volume attachment (ex: /dev/vdc). NOTE: Being able to specify a device is dependent upon the hypervisor in use. There is a chance that the device specified in Terraform will not be the same device the hypervisor chose. If this happens, Terraform will wish to update the device upon subsequent applying which will cause the volume to be detached and reattached indefinitely. Please use with caution.
multiattach - (Optional) Enable attachment of multiattach-capable volumes.
vendor_options - (Optional) Map of additional vendor-specific options. Supported options are described below.

The vendor_options block supports:
ignore_volume_confirmation - (Optional) Boolean to control whether to ignore volume status confirmation of the attached volume. This can be helpful to work with some OpenStack clouds which don't have the Block Storage V3 API available.
  EOF
}
