variable "labels" {
  type = map(string)
  default = {}
}

variable "project_name" {
  type = string
}

variable "cluster_v1" {
  type = list(object({
    id                  = number
    cluster_template_id = number
    name                = optional(string)
    create_timeout      = optional(number)
    discovery_url       = optional(string)
    docker_volume_size  = optional(number)
    flavor              = optional(string)
    master_flavor       = optional(string)
    keypair             = optional(string)
    labels              = optional(map(string))
    merge_labels        = optional(bool)
    master_count        = optional(number)
    node_count          = optional(number)
    fixed_network       = optional(string)
    fixed_subnet        = optional(string)
    floating_ip_enabled = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Optional) The region in which to obtain the V1 Container Infra client. A Container Infra client is needed to create a cluster. If omitted, the region argument of the provider is used. Changing this creates a new cluster.
name - (Required) The name of the cluster. Changing this creates a new cluster.
project_id - (Optional) The project of the cluster. Required if admin wants to create a cluster in another project. Changing this creates a new cluster.
user_id - (Optional) The user of the cluster. Required if admin wants to create a cluster template for another user. Changing this creates a new cluster.
cluster_template_id - (Required) The UUID of the V1 Container Infra cluster template. Changing this creates a new cluster.
create_timeout - (Optional) The timeout (in minutes) for creating the cluster. Changing this creates a new cluster.
discovery_url - (Optional) The URL used for cluster node discovery. Changing this creates a new cluster.
docker_volume_size - (Optional) The size (in GB) of the Docker volume. Changing this creates a new cluster.
flavor - (Optional) The flavor for the nodes of the cluster. Can be set via the OS_MAGNUM_FLAVOR environment variable. Changing this creates a new cluster.
master_flavor - (Optional) The flavor for the master nodes. Can be set via the OS_MAGNUM_MASTER_FLAVOR environment variable. Changing this creates a new cluster.
keypair - (Optional) The name of the Compute service SSH keypair. Changing this creates a new cluster.
labels - (Optional) The list of key value pairs representing additional properties of the cluster. Changing this creates a new cluster.
merge_labels - (Optional) Indicates whether the provided labels should be merged with cluster template labels. Changing this creates a new cluster.
master_count - (Optional) The number of master nodes for the cluster. Changing this creates a new cluster.
node_count - (Optional) The number of nodes for the cluster.
fixed_network - (Optional) The fixed network that will be attached to the cluster. Changing this creates a new cluster.
fixed_subnet - (Optional) The fixed subnet that will be attached to the cluster. Changing this creates a new cluster.
floating_ip_enabled - (Optional) Indicates whether floating IP should be created for every cluster node. Changing this creates a new cluster.
  EOF
}

variable "clustertemplate_v1" {
  type = list(object({
    id                    = number
    coe                   = string
    image                 = string
    name                  = string
    region                = optional(string)
    project_id            = optional(string)
    user_id               = optional(string)
    apiserver_port        = optional(number)
    cluster_distro        = optional(string)
    dns_nameserver        = optional(string)
    docker_storage_driver = optional(string)
    docker_volume_size    = optional(number)
    external_network_id   = optional(string)
    fixed_network         = optional(string)
    fixed_subnet          = optional(string)
    flavor                = optional(string)
    master_flavor         = optional(string)
    floating_ip_enabled   = optional(bool)
    http_proxy            = optional(string)
    https_proxy           = optional(string)
    insecure_registry     = optional(string)
    keypair_id            = optional(string)
    labels                = optional(map(string))
    master_lb_enabled     = optional(bool)
    network_driver        = optional(string)
    no_proxy              = optional(string)
    public                = optional(bool)
    registry_enabled      = optional(bool)
    server_type           = optional(string)
    tls_disabled          = optional(bool)
    volume_driver         = optional(string)
    hidden                = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Optional) The region in which to obtain the V1 Container Infra client. A Container Infra client is needed to create a cluster template. If omitted,the region argument of the provider is used. Changing this creates a new cluster template.
name - (Required) The name of the cluster template. Changing this updates the name of the existing cluster template.
project_id - (Optional) The project of the cluster template. Required if admin wants to create a cluster template in another project. Changing this creates a new cluster template.
user_id - (Optional) The user of the cluster template. Required if admin wants to create a cluster template for another user. Changing this creates a new cluster template.
apiserver_port - (Optional) The API server port for the Container Orchestration Engine for this cluster template. Changing this updates the API server port of the existing cluster template.
coe - (Required) The Container Orchestration Engine for this cluster template. Changing this updates the engine of the existing cluster template.
cluster_distro - (Optional) The distro for the cluster (fedora-atomic, coreos, etc.). Changing this updates the cluster distro of the existing cluster template.
dns_nameserver - (Optional) Address of the DNS nameserver that is used in nodes of the cluster. Changing this updates the DNS nameserver of the existing cluster template.
docker_storage_driver - (Optional) Docker storage driver. Changing this updates the Docker storage driver of the existing cluster template.
docker_volume_size - (Optional) The size (in GB) of the Docker volume. Changing this updates the Docker volume size of the existing cluster template.
external_network_id - (Optional) The ID of the external network that will be used for the cluster. Changing this updates the external network ID of the existing cluster template.
fixed_network - (Optional) The fixed network that will be attached to the cluster. Changing this updates the fixed network of the existing cluster template.
fixed_subnet - (Optional) The fixed subnet that will be attached to the cluster. Changing this updates the fixed subnet of the existing cluster template.
flavor - (Optional) The flavor for the nodes of the cluster. Can be set via the OS_MAGNUM_FLAVOR environment variable. Changing this updates the flavor of the existing cluster template.
master_flavor - (Optional) The flavor for the master nodes. Can be set via the OS_MAGNUM_MASTER_FLAVOR environment variable. Changing this updates the master flavor of the existing cluster template.
floating_ip_enabled - (Optional) Indicates whether created cluster should create floating IP for every node or not. Changing this updates the floating IP enabled attribute of the existing cluster template.
http_proxy - (Optional) The address of a proxy for receiving all HTTP requests and relay them. Changing this updates the HTTP proxy address of the existing cluster template.
https_proxy - (Optional) The address of a proxy for receiving all HTTPS requests and relay them. Changing this updates the HTTPS proxy address of the existing cluster template.
image - (Required) The reference to an image that is used for nodes of the cluster. Can be set via the OS_MAGNUM_IMAGE environment variable. Changing this updates the image attribute of the existing cluster template.
insecure_registry - (Optional) The insecure registry URL for the cluster template. Changing this updates the insecure registry attribute of the existing cluster template.
keypair_id - (Optional) The name of the Compute service SSH keypair. Changing this updates the keypair of the existing cluster template.
labels - (Optional) The list of key value pairs representing additional properties of the cluster template. Changing this updates the labels of the existing cluster template.
master_lb_enabled - (Optional) Indicates whether created cluster should has a loadbalancer for master nodes or not. Changing this updates the attribute of the existing cluster template.
network_driver - (Optional) The name of the driver for the container network. Changing this updates the network driver of the existing cluster template.
no_proxy - (Optional) A comma-separated list of IP addresses that shouldn't be used in the cluster. Changing this updates the no proxy list of the existing cluster template.
public - (Optional) Indicates whether cluster template should be public. Changing this updates the public attribute of the existing cluster template.
registry_enabled - (Optional) Indicates whether Docker registry is enabled in the cluster. Changing this updates the registry enabled attribute of the existing cluster template.
server_type - (Optional) The server type for the cluster template. Changing this updates the server type of the existing cluster template.
tls_disabled - (Optional) Indicates whether the TLS should be disabled in the cluster. Changing this updates the attribute of the existing cluster.
volume_driver - (Optional) The name of the driver that is used for the volumes of the cluster nodes. Changing this updates the volume driver of the existing cluster template.
hidden - (Optional) Indicates whether the ClusterTemplate is hidden or not. Changing this updates the hidden attribute of the existing cluster template.
  EOF
}

variable "nodegroup_v1" {
  type = list(object({
    id                 = number
    cluster_id         = number
    name               = string
    region             = optional(string)
    project_id         = optional(string)
    docker_volume_size = optional(number)
    image_id           = optional(string)
    flavor_id          = optional(string)
    labels             = optional(map(string))
    merge_labels       = optional(bool)
    node_count         = optional(number)
    min_node_count     = optional(number)
    max_node_count     = optional(number)
    role               = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
region - (Optional) The region in which to obtain the V1 Container Infra client. A Container Infra client is needed to create a cluster. If omitted, the region argument of the provider is used. Changing this creates a new node group.
name - (Required) The name of the node group. Changing this creates a new node group.
project_id - (Optional) The project of the node group. Required if admin wants to create a cluster in another project. Changing this creates a new node group.
cluster_id - (Required) The UUID of the V1 Container Infra cluster. Changing this creates a new node group.
docker_volume_size - (Optional) The size (in GB) of the Docker volume. Changing this creates a new node group.
image_id - (Required) The reference to an image that is used for nodes of the node group. Can be set via the OS_MAGNUM_IMAGE environment variable. Changing this updates the image attribute of the existing node group.
flavor_id - (Optional) The flavor for the nodes of the node group. Can be set via the OS_MAGNUM_FLAVOR environment variable. Changing this creates a new node group.
labels - (Optional) The list of key value pairs representing additional properties of the node group. Changing this creates a new node group.
merge_labels - (Optional) Indicates whether the provided labels should be merged with cluster labels. Changing this creates a new nodegroup.
node_count - (Optional) The number of nodes for the node group. Changing this update the number of nodes of the node group.
min_node_count - (Optional) The minimum number of nodes for the node group. Changing this update the minimum number of nodes of the node group.
max_node_count - (Optional) The maximum number of nodes for the node group. Changing this update the maximum number of nodes of the node group.
role - (Optional) The role of nodes in the node group. Changing this creates a new node group.
  EOF
}
