variable "resource_group_name" {
  type        = string
  description = "Name of the imported resource group"
}

variable "log_analythics_workspace_name" {
  type        = string
  default     = null
  description = "Name of the log analythics workspace name"
}

variable "tags" {
  type        = list(string)
  description = "list of generic tags"
}

variable "cluster" {
  type = object({
    name                                = string
    automatic_channel_upgrade           = optional(string)
    azure_policy_enabled                = optional(bool)
    disk_encryption_set_id              = optional(string)
    dns_prefix                          = optional(string)
    http_application_routing_enabled    = optional(string)
    kubernetes_version                  = optional(string)
    local_account_disabled              = optional(bool)
    node_resource_group                 = optional(string)
    oidc_issuer_enabled                 = optional(bool)
    open_service_mesh_enabled           = optional(bool)
    private_cluster_enabled             = optional(bool)
    private_cluster_public_fqdn_enabled = optional(bool)
    private_dns_zone_id                 = optional(string)
    public_network_access_enabled       = optional(bool)
    role_based_access_control_enabled   = optional(bool)
    sku_tier                            = optional(string)
    edge_zone                           = optional(string)
    image_cleaner_enabled               = optional(bool)
    image_cleaner_interval_hours        = optional(number)
    node_os_channel_upgrade             = optional(string)
    workload_identity_enabled           = optional(bool)
    run_command_enabled                 = optional(bool)
    tags                                = optional(list(string))
  })
  default     = null
  description = <<-EOT
  object({
    name                                = (mandatory) The name of the Managed Kubernetes Cluster to create.
    automatic_channel_upgrade           = (optional) The upgrade channel for this Kubernetes Cluster. Possible values are "patch", "rapid", "node-image" and "stable".
    azure_policy_enabled                = (optional) Should the Azure Policy Add-On be enabled ?
    disk_encryption_set_id              = (optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes.  
    dns_prefix                          = (optional) DNS prefix specified when creating the managed cluster.  
    http_application_routing_enabled    = (optional) Should HTTP Application Routing be enabled ?
    kubernetes_version                  = (optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time.  
    local_account_disabled              = (optional) If true local accounts will be disabled.  
    node_resource_group                 = (optional) The name of the Resource Group where the Kubernetes Nodes should exist.  
    oidc_issuer_enabled                 = (optional) Enable or Disable the OIDC issuer URL.
    open_service_mesh_enabled           = (optional) Is Open Service Mesh enabled ?
    private_cluster_enabled             = (optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located.
    private_cluster_public_fqdn_enabled = (optional) Specifies whether a Public FQDN for this Private Cluster should be added.
    private_dns_zone_id                 = (optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise, the cluster will have issues after provisioning.
    public_network_access_enabled       = (optional) Whether public network access is allowed for this Kubernetes Cluster.
    role_based_access_control_enabled   = (optional) Whether Role Based Access Control for the Kubernetes Cluster should be enabled.
    sku_tier                            = (optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free, and Standard.
    edge_zone                           = (optional) Specifies the Edge Zone within the Azure Region where this Managed Kubernetes Cluster should exist.
    image_cleaner_enabled               = (optional) Specifies whether Image Cleaner is enabled.
    image_cleaner_interval_hours        = (optional) Specifies the interval in hours when images should be cleaned up.
    node_os_channel_upgrade             = (optional) The upgrade channel for this Kubernetes Cluster Nodes' OS Image. Possible values are "Unmanaged", "SecurityPatch", "NodeImage" and "None".
    workload_identity_enabled           = (optional) Specifies whether Azure AD Workload Identity should be enabled for the Cluster.
    run_command_enabled                 = (optional) Whether to enable run command for the cluster or not.
  })
EOT
}

variable "service_mesh_profile" {
  type = list(object({
    mode = string
  }))
  default     = []
  description = <<-EOT
    mode = (optional)
EOT
}

variable "service_principal" {
  type = list(object({
    client_id     = string
    client_secret = string
  }))
  default     = []
  description = <<-EOT
    client_id     = (optional)
    client_secret = (optional)
EOT
}

variable "default_node_pool" {
  type = object({
    name                         = string
    vm_size                      = number
    enable_auto_scaling          = optional(bool, true)
    enable_host_encryption       = optional(bool, true)
    enable_node_public_ip        = optional(bool, false)
    max_count                    = optional(number)
    max_pods                     = optional(number)
    node_count                   = optional(number)
    node_labels                  = optional(map(string))
    node_taints                  = optional(list(string))
    only_critical_addons_enabled = optional(bool, true)
    orchestrator_version         = optional(string)
    os_disk_size_gb              = optional(number)
    os_disk_type                 = optional(string)
    os_sku                       = optional(string)
    pod_subnet_id                = optional(string)
    proximity_placement_group_id = optional(string)
    scale_down_mode              = optional(string)
    tags                         = optional(map(string))
    temporary_name_for_rotation  = optional(string)
    type                         = optional(string)
    ultra_ssd_enabled            = optional(bool, true)
    vnet_subnet_id               = optional(string)
    zones                        = optional(list(string))
    workload_runtime             = optional(string)
  })
  default     = []
  description = <<-EOT
    name                         = The name which should be used for the default Kubernetes Node Pool.  
    vm_size                      = The size of the Virtual Machine.  
    enable_auto_scaling          = (optional) Should the Kubernetes Auto Scaler be enabled for this Node Pool ?  
    enable_host_encryption       = (optional) Should the nodes in the Default Node Pool have host encryption enabled ?  
    enable_node_public_ip        = (optional) Should nodes in this Node Pool have a Public IP Address?  
    max_count                    = (optional) The maximum number of nodes which should exist in this Node Pool.  
    max_pods                     = (optional) The maximum number of pods that can run on each agent.  
    node_count                   = (optional) The initial number of nodes which should exist in this Node Pool.  
    node_labels                  = (optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool.  
    node_taints                  = (optional) A list of the taints added to new nodes during node pool create and scale.  
    only_critical_addons_enabled = (optional) Enabling this option will taint default node pool with "CriticalAddonsOnly=true:NoSchedule" taint.
    orchestrator_version         = (optional) Version of Kubernetes used for the Agents. If not specified, the default node pool will be created with the version specified by kubernetes_version.  
    os_disk_size_gb              = (optional) The size of the OS Disk which should be used for each agent in the Node Pool.  
    os_disk_type                 = (optional) The type of disk which should be used for the Operating System. Possible values are "Ephemeral" and "Managed".  
    os_sku                       = (optional) Specifies the OS SKU used by the agent pool. Possible values include: "AzureLinux", "Ubuntu", "Windows2019", "Windows2022".  
    pod_subnet_id                = (optional) The ID of the Subnet where the pods in the default Node Pool should exist.  
    proximity_placement_group_id = (optional) The ID of the Proximity Placement Group.  
    scale_down_mode              = (optional) Specifies the autoscaling behaviour of the Kubernetes Cluster. Allowed values are "Delete" and "Deallocate".  
    tags                         = (optional)
    temporary_name_for_rotation  = (optional) Specifies the name of the temporary node pool used to cycle the default node pool for VM resizing.  
    type                         = (optional) The type of Node Pool which should be created. Possible values are "AvailabilitySet" and "VirtualMachineScaleSets".  
    ultra_ssd_enabled            = (optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool.  
    vnet_subnet_id               = (optional) The ID of a Subnet where the Kubernetes Node Pool should exist.  
    zones                        = (optional) Specifies a list of Availability Zones in which this Kubernetes Cluster should be located.  
    workload_runtime             = (optional) Specifies the workload runtime used by the node pool. Possible values are "OCIContainer" and "KataMshvVmIsolation".
EOT
}

variable "kubelet_config" {
  type = list(object({
    allowed_unsafe_sysctls    = optional(set(string))
    container_log_max_line    = optional(number)
    container_log_max_size_mb = optional(number)
    cpu_cfs_quota_enabled     = optional(bool, true)
    cpu_cfs_quota_period      = optional(string)
    cpu_manager_policy        = optional(string)
    image_gc_high_threshold   = optional(number)
    image_gc_low_threshold    = optional(number)
    pod_max_pid               = optional(number)
    topology_manager_policy   = optional(string)
  }))
  default     = []
  description = <<-EOT
      cpu_manager_policy        = (Optional) Specifies the CPU Manager policy to use. Possible values are `none` and `static`, Changing this forces a new resource to be created.
      cpu_cfs_quota_enabled     = (Optional) Is CPU CFS quota enforcement for containers enabled? Changing this forces a new resource to be created.
      cpu_cfs_quota_period      = (Optional) Specifies the CPU CFS quota period value. Changing this forces a new resource to be created.
      image_gc_high_threshold   = (Optional) Specifies the percent of disk usage above which image garbage collection is always run. Must be between `0` and `100`. Changing this forces a new resource to be created.
      image_gc_low_threshold    = (Optional) Specifies the percent of disk usage lower than which image garbage collection is never run. Must be between `0` and `100`. Changing this forces a new resource to be created.
      topology_manager_policy   = (Optional) Specifies the Topology Manager policy to use. Possible values are `none`, `best-effort`, `restricted` or `single-numa-node`. Changing this forces a new resource to be created.
      allowed_unsafe_sysctls    = (Optional) Specifies the allow list of unsafe sysctls command or patterns (ending in `*`). Changing this forces a new resource to be created.
      container_log_max_size_mb = (Optional) Specifies the maximum size (e.g. 10MB) of container log file before it is rotated. Changing this forces a new resource to be created.
      container_log_max_files   = (Optional) Specifies the maximum number of container log files that can be present for a container. must be at least 2. Changing this forces a new resource to be created.
      pod_max_pid               = (Optional) Specifies the maximum number of processes per pod. Changing this forces a new resource to be created.
EOT
}

variable "linux_os_config" {
  type = list(object({
    swap_file_size_mb             = optional(number)
    transparent_huge_page_defrag  = optional(string)
    transparent_huge_page_enabled = optional(bool, true)
    sysctl_configs = optional(list(object({
      fs_aio_max_nr                      = optional(number)
      fs_file_max                        = optional(number)
      fs_inotify_max_user_watches        = optional(number)
      fs_nr_open                         = optional(number)
      kernel_threads_max                 = optional(number)
      net_core_netdev_max_backlog        = optional(number)
      net_core_optmem_max                = optional(number)
      net_core_rmem_default              = optional(number)
      net_core_rmem_max                  = optional(number)
      net_core_somaxconn                 = optional(number)
      net_core_wmem_default              = optional(number)
      net_core_wmem_max                  = optional(number)
      net_ipv4_ip_local_port_range_max   = optional(number)
      net_ipv4_ip_local_port_range_min   = optional(number)
      net_ipv4_neigh_default_gc_thresh1  = optional(number)
      net_ipv4_neigh_default_gc_thresh2  = optional(number)
      net_ipv4_neigh_default_gc_thresh3  = optional(number)
      net_ipv4_tcp_fin_timeout           = optional(number)
      net_ipv4_tcp_keepalive_intvl       = optional(number)
      net_ipv4_tcp_keepalive_probes      = optional(number)
      net_ipv4_tcp_keepalive_time        = optional(number)
      net_ipv4_tcp_max_syn_backlog       = optional(number)
      net_ipv4_tcp_max_tw_buckets        = optional(number)
      net_ipv4_tcp_tw_reuse              = optional(bool, true)
      net_netfilter_nf_conntrack_buckets = optional(number)
      net_netfilter_nf_conntrack_max     = optional(number)
      vm_max_map_count                   = optional(number)
      vm_swappiness                      = optional(number)
      vm_vfs_cache_pressure              = optional(number)
    })), [])
  }))
  default     = []
  description = <<-EOT
    fs_aio_max_nr                      = (Optional) The sysctl setting fs.aio-max-nr. Must be between `65536` and `6553500`. Changing this forces a new resource to be created.
    fs_file_max                        = (Optional) The sysctl setting fs.file-max. Must be between `8192` and `12000500`. Changing this forces a new resource to be created.
    fs_inotify_max_user_watches        = (Optional) The sysctl setting fs.inotify.max_user_watches. Must be between `781250` and `2097152`. Changing this forces a new resource to be created.
    fs_nr_open                         = (Optional) The sysctl setting fs.nr_open. Must be between `8192` and `20000500`. Changing this forces a new resource to be created.
    kernel_threads_max                 = (Optional) The sysctl setting kernel.threads-max. Must be between `20` and `513785`. Changing this forces a new resource to be created.
    net_core_netdev_max_backlog        = (Optional) The sysctl setting net.core.netdev_max_backlog. Must be between `1000` and `3240000`. Changing this forces a new resource to be created.
    net_core_optmem_max                = (Optional) The sysctl setting net.core.optmem_max. Must be between `20480` and `4194304`. Changing this forces a new resource to be created.
    net_core_rmem_default              = (Optional) The sysctl setting net.core.rmem_default. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.
    net_core_rmem_max                  = (Optional) The sysctl setting net.core.rmem_max. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.
    net_core_somaxconn                 = (Optional) The sysctl setting net.core.somaxconn. Must be between `4096` and `3240000`. Changing this forces a new resource to be created.
    net_core_wmem_default              = (Optional) The sysctl setting net.core.wmem_default. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.
    net_core_wmem_max                  = (Optional) The sysctl setting net.core.wmem_max. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.
    net_ipv4_ip_local_port_range_min   = (Optional) The sysctl setting net.ipv4.ip_local_port_range max value. Must be between `1024` and `60999`. Changing this forces a new resource to be created.
    net_ipv4_ip_local_port_range_max   = (Optional) The sysctl setting net.ipv4.ip_local_port_range min value. Must be between `1024` and `60999`. Changing this forces a new resource to be created.
    net_ipv4_neigh_default_gc_thresh1  = (Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh1. Must be between `128` and `80000`. Changing this forces a new resource to be created.
    net_ipv4_neigh_default_gc_thresh2  = (Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh2. Must be between `512` and `90000`. Changing this forces a new resource to be created.
    net_ipv4_neigh_default_gc_thresh3  = (Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh3. Must be between `1024` and `100000`. Changing this forces a new resource to be created.
    net_ipv4_tcp_fin_timeout           = (Optional) The sysctl setting net.ipv4.tcp_fin_timeout. Must be between `5` and `120`. Changing this forces a new resource to be created.
    net_ipv4_tcp_keepalive_intvl       = (Optional) The sysctl setting net.ipv4.tcp_keepalive_intvl. Must be between `10` and `75`. Changing this forces a new resource to be created.
    net_ipv4_tcp_keepalive_probes      = (Optional) The sysctl setting net.ipv4.tcp_keepalive_probes. Must be between `1` and `15`. Changing this forces a new resource to be created.
    net_ipv4_tcp_keepalive_time        = (Optional) The sysctl setting net.ipv4.tcp_keepalive_time. Must be between `30` and `432000`. Changing this forces a new resource to be created.
    net_ipv4_tcp_max_syn_backlog       = (Optional) The sysctl setting net.ipv4.tcp_max_syn_backlog. Must be between `128` and `3240000`. Changing this forces a new resource to be created.
    net_ipv4_tcp_max_tw_buckets        = (Optional) The sysctl setting net.ipv4.tcp_max_tw_buckets. Must be between `8000` and `1440000`. Changing this forces a new resource to be created.
    net_ipv4_tcp_tw_reuse              = (Optional) The sysctl setting net.ipv4.tcp_tw_reuse. Changing this forces a new resource to be created.
    net_netfilter_nf_conntrack_buckets = (Optional) The sysctl setting net.netfilter.nf_conntrack_buckets. Must be between `65536` and `147456`. Changing this forces a new resource to be created.
    net_netfilter_nf_conntrack_max     = (Optional) The sysctl setting net.netfilter.nf_conntrack_max. Must be between `131072` and `1048576`. Changing this forces a new resource to be created.
    vm_max_map_count                   = (Optional) The sysctl setting vm.max_map_count. Must be between `65530` and `262144`. Changing this forces a new resource to be created.
    vm_swappiness                      = (Optional) The sysctl setting vm.swappiness. Must be between `0` and `100`. Changing this forces a new resource to be created.
    vm_vfs_cache_pressure              = (Optional) The sysctl setting vm.vfs_cache_pressure. Must be between `0` and `100`. Changing this forces a new resource to be created.
    transparent_huge_page_enabled      = (Optional) Specifies the Transparent Huge Page enabled configuration. Possible values are `always`, `madvise` and `never`. Changing this forces a new resource to be created.
    transparent_huge_page_defrag       = (Optional) specifies the defrag configuration for Transparent Huge Page. Possible values are `always`, `defer`, `defer+madvise`, `madvise` and `never`. Changing this forces a new resource to be created.
    swap_file_size_mb                  = (Optional) Specifies the size of the swap file on each node in MB. Changing this forces a new resource to be created.
EOT
}

variable "upgrade_settings" {
  type = list(object({
    max_surge = optional(number)
  }))
  default     = []
  description = <<-EOT
    max_surge = (optional)
EOT
}

variable "aci_connector_linux" {
  type = list(object({
    subnet_name = optional(string)
  }))
  default     = []
  description = <<-EOT
    subnet_name = (optional) The subnet name for the virtual nodes to run.
EOT
}

variable "api_server_access_profile" {
  type = list(object({
    authorized_ip_ranges     = optional(list(string))
    subnet_id                = optional(string)
    vnet_integration_enabled = optional(bool, true)
  }))
  default     = []
  description = <<-EOT
    authorized_ip_ranges     = (optional) Set of authorized IP ranges to allow access to API server.
    subnet_id                = (optional) The ID of the Subnet where the API server endpoint is delegated to.
    vnet_integration_enabled = (optional) Should API Server VNet Integration be enabled?
EOT
}

variable "auto_scaler_profile" {
  type = list(object({
    balance_similar_node_groups      = optional(string)
    expander                         = optional(string)
    max_graceful_termination_sec     = optional(number)
    max_node_provisioning_time       = optional(number)
    max_unready_nodes                = optional(number)
    max_unready_percentage           = optional(number)
    new_pod_scale_up_delay           = optional(number)
    scale_down_delay_after_add       = optional(number)
    scale_down_delay_after_delete    = optional(number)
    scale_down_delay_after_failure   = optional(number)
    scan_interval                    = optional(number)
    scale_down_unneeded              = optional(number)
    scale_down_unready               = optional(number)
    scale_down_utilization_threshold = optional(number)
    empty_bulk_delete_max            = optional(number)
    skip_nodes_with_system_pods      = optional(bool, true)
    skip_nodes_with_local_storage    = optional(bool, true)
  }))
  default     = []
  description = <<-EOT
    balance_similar_node_groups      = (optional) Detect similar node groups and balance the number of nodes between them.  
    expander                         = (optional) Expander to use. Possible values are "least-waste", "priority", "most-pods" and "random".  
    max_graceful_termination_sec     = (optional) Maximum number of seconds the cluster autoscaler waits for pod termination when trying to scale down a node.  
    max_node_provisioning_time       = (optional) Maximum time the autoscaler waits for a node to be provisioned.  
    max_unready_nodes                = (optional) Maximum Number of allowed unready nodes.
    max_unready_percentage           = (optional) Maximum percentage of unready nodes the cluster autoscaler will stop if the percentage is exceeded.  
    new_pod_scale_up_delay           = (optional) For scenarios like burst/batch scale where you don't want CA to act before the kubernetes scheduler could schedule all the pods, you can tell CA to ignore unscheduled pods before they're a certain age.  
    scale_down_delay_after_add       = (optional) How long after the scale up of AKS nodes the scale down evaluation resumes.  
    scale_down_delay_after_delete    = (optional) How long after node deletion that scale down evaluation resumes.  
    scale_down_delay_after_failure   = (optional) How long after scale down failure that scale down evaluation resumes.  
    scan_interval                    = (optional) How often the AKS Cluster should be re-evaluated for scale up/down.  
    scale_down_unneeded              = (optional) How long a node should be unneeded before it is eligible for scale down.  
    scale_down_unready               = (optional) How long an unready node should be unneeded before it is eligible for scale down.  
    scale_down_utilization_threshold = (optional) Node utilization level, defined as sum of requested resources divided by capacity, below which a node can be considered for scale down.  
    empty_bulk_delete_max            = (optional) Maximum number of empty nodes that can be deleted at the same time.  
    skip_nodes_with_system_pods      = (optional) If true cluster autoscaler will never delete nodes with pods with local storage.  
    skip_nodes_with_local_storage    = (optional) If true cluster autoscaler will never delete nodes with pods from kube-system.
EOT
}

variable "azure_active_directory_role_based_access_control" {
  type = list(object({
    managed                = optional(bool, true)
    admin_group_object_ids = optional(list(string))
    azure_rbac_enabled     = optional(bool, true)
    client_app_id          = optional(string)
    server_app_id          = optional(string)
    server_app_secret      = optional(string)
    tenant_id              = optional(string)
  }))
  default     = []
  description = <<-EOT
    managed                 = (optional) Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration.  
    admin_group_object_ids  = (optional) When "managed" is true : A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster.  
    azure_rbac_enabled      = (optional) When "managed" is true : Is Role Based Access Control based on Azure AD enabled?  
    client_app_id           = (optional) When "managed" is false : The Client ID of an Azure Active Directory Application.  
    server_app_id           = (optional) When "managed" is false : The Server ID of an Azure Active Directory Application.  
    server_app_secret       = (optional) When "managed" is false : The Server Secret of an Azure Active Directory Application.  
    tenant_id               = (optional) The Tenant ID used for Azure Active Directory Application.  
EOT
}

variable "confidential_computing" {
  type = list(object({
    sgx_quote_helper_enabled = optional(bool, true)
  }))
  default     = []
  description = <<-EOT
    sgx_quote_helper_enabled = (optional) Should the SGX quote helper be enabled ?
EOT
}

variable "http_proxy_config" {
  type = list(object({
    http_proxy  = optional(string)
    https_proxy = optional(string)
    no_proxy    = optional(list(string))
  }))
  default     = []
  description = <<-EOT
    http_proxy  = (optional) The proxy address to be used when communicating over HTTP.  
    https_proxy = (optional) The proxy address to be used when communicating over HTTPS. 
    no_proxy    = (optional) The list of domains that will not use the proxy for communication.
EOT
}

variable "workload_autoscaler_profile" {
  type = list(object({
    keda_enabled                    = optional(bool, true)
    vertical_pod_autoscaler_enabled = optional(bool, true)
  }))
  default     = []
  description = <<-EOT
EOT
}

variable "identity" {
  type = list(object({
    type         = optional(string)
    identity_ids = optional(list(string))
  }))
  default     = []
  description = <<-EOT
    type          = (optional) Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. Possible values are "SystemAssigned" or "UserAssigned".
    identity_ids  = (optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster. 
EOT
}

variable "ingress_application_gateway" {
  type = list(object({
    gateway_id   = optional(string)
    gateway_name = optional(string)
    subnet_cidr  = optional(string)
    subnet_id    = optional(string)
  }))
  default     = []
  description = <<-EOT
    gateway_id   = (optional) The ID of the Application Gateway to integrate with the ingress controller of this Kubernetes Cluster.  
    gateway_name = (optional) The name of the Application Gateway to be used or created in the Nodepool Resource Group, which in turn will be integrated with the ingress controller of this Kubernetes Cluster.  
    subnet_cidr  = (optional) The subnet CIDR to be used to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster.  
    subnet_id    = (optional) The ID of the subnet on which to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. 
EOT
}

variable "key_management_service" {
  type = list(object({
    key_vault_key_id         = optional(string)
    key_vault_network_access = optional(string)
  }))
  default     = []
  description = <<-EOT
    key_vault_key_id         = (optional) Identifier of Azure Key Vault key.  
    key_vault_network_access = (optional) Network access of the key vault Network access of key vault. The possible values are "Public" and "Private". 
EOT
}

variable "key_vault_secrets_provider" {
  type = list(object({
    secret_rotation_enabled  = optional(bool, true)
    secret_rotation_interval = optional(number)
  }))
  default     = []
  description = <<-EOT
    secret_rotation_enabled  = (optional) Should the secret store CSI driver on the AKS cluster be enabled ?  
    secret_rotation_interval = (optional) The interval to poll for secret rotation. 
EOT
}

variable "kubelet_identity" {
  type = list(object({
    client_id                 = optional(string)
    object_id                 = optional(string)
    user_assigned_identity_id = optional(string)
  }))
  default     = []
  description = <<-EOT
    client_id                 = (optional) The Client ID of the user-defined Managed Identity to be assigned to the Kubelets.  
    object_id                 = (optional) The Object ID of the user-defined Managed Identity assigned to the Kubelets.  
    user_assigned_identity_id = (optional) he ID of the User Assigned Identity assigned to the Kubelets.  
EOT
}

variable "linux_profile" {
  type = list(object({
    admin_username = optional(string)
    ssh_key        = optional(string)
  }))
  default     = []
  description = <<-EOT
EOT
}

variable "maintenance_window" {
  type = object({
    allowed = list(object({
      day   = string
      hours = set(number)
    }))
    not_allowed = list(object({
      end   = string
      start = string
    }))
  })
  default     = null
  description = <<-EOT
EOT
}

variable "microsoft_defender" {
  type        = bool
  default     = false
  nullable    = false
  description = "Specifies the ID of the Log Analytics Workspace where the audit logs collected by Microsoft Defender should be sent to if set to true."
}

variable "monitor_metrics" {
  type = object({
    annotations_allowed = optional(string)
    labels_allowed      = optional(string)
  })
  default     = null
  description = <<-EOT
    annotations_allowed = (optional) Specifies a comma-separated list of Kubernetes annotation keys that will be used in the resource's labels metric.  
    labels_allowed      = (optional) Specifies a Comma-separated list of additional Kubernetes label keys that will be used in the resource's labels metric.
EOT
}

variable "network_profile" {
  type = object({
    network_plugin      = string
    network_mode        = optional(string)
    dns_service_ip      = optional(string)
    ebpf_data_plane     = optional(string)
    load_balancer_sku   = optional(string)
    network_plugin_mode = optional(string)
    network_policy      = optional(string)
    outbound_type       = optional(string)
    pod_cidr            = optional(string)
    service_cidr        = optional(string)
    load_balancer_profile = optional(object({
      idle_timeout_in_minutes     = optional(number)
      managed_outbound_ip_count   = optional(number)
      managed_outbound_ipv6_count = optional(number)
      outbound_ip_address_ids     = optional(list(string))
      outbound_ip_prefix_ids      = optional(list(string))
      outbound_ports_allocated    = optional(number)
    }))
  })
  default     = null
  description = <<-EOT
    network_plugin              = Network plugin to use for networking. Currently supported values are azure, kubenet and none.
    network_mode                = (optional) Network mode to be used with Azure CNI. Possible values are bridge and transparent.
    dns_service_ip              = (optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns).
    ebpf_data_plane             = (optional) Specifies the eBPF data plane used for building the Kubernetes network. Possible value is cilium.
    load_balancer_sku           = (optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard.
    network_plugin_mode         = (optional) Specifies the network plugin mode used for building the Kubernetes network. Possible value is overlay.
    network_policy              = (optional) Sets up network policy to be used with Azure CNI.
    outbound_type               = (optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway.
    pod_cidr                    = (optional) The CIDR to use for pod IP addresses. This field can only be set when network_plugin is set to kubenet.
    service_cidr                = (optional) The Network Range used by the Kubernetes service.
    idle_timeout_in_minutes     = (optional) Desired outbound flow idle timeout in minutes for the cluster load balancer. Must be between 4 and 120 inclusive.
    managed_outbound_ip_count   = (optional) Count of desired managed outbound IPs for the cluster load balancer. Must be between 1 and 100 inclusive.
    managed_outbound_ipv6_count = (optional) The desired number of IPv6 outbound IPs created and managed by Azure for the cluster load balancer.
    outbound_ip_address_ids     = (optional) The ID of the Public IP Addresses which should be used for outbound communication for the cluster load balancer.
    outbound_ip_prefix_ids      = (optional) The ID of the outbound Public IP Address Prefixes which should be used for the cluster load balancer.
    outbound_ports_allocated    = (optional) Number of desired SNAT port for each VM in the clusters load balancer. Must be between 0 and 64000 inclusive.
EOT
}

variable "oms_agent" {
  type        = bool
  default     = false
  nullable    = false
  description = "The ID of the Log Analytics Workspace which the OMS Agent should send data to when set to true"
}

variable "web_app_routing" {
  type = object({
    dns_zone_id = string
  })
  default     = null
  description = <<-EOT
    dns_zone_id = Specifies the ID of the DNS Zone in which DNS entries are created for applications deployed to the cluster when Web App Routing is enabled.
EOT
}

variable "storage_profile" {
  type = list(object({
    blob_driver_enabled         = optional(bool)
    disk_driver_enabled         = optional(bool)
    disk_driver_version         = optional(string)
    file_driver_enabled         = optional(bool)
    snapshot_controller_enabled = optional(bool)
  }))
  default     = []
  description = <<-EOT
    blob_driver_enabled         = (optional) Is the Blob CSI driver enabled ?  
    disk_driver_enabled         = (optional) Is the Disk CSI driver enabled ?  
    disk_driver_version         = (optional) Disk CSI Driver version to be used. Possible values are v1 and v2.  
    file_driver_enabled         = (optional) Is the File CSI driver enabled ?  
    snapshot_controller_enabled = (optional) Is the Snapshot Controller enabled ? 
EOT
}

variable "role_assignemnt" {
  type = map(object({
    scope                            = string
    principal_id                     = string
    skip_service_principal_aad_check = optional(bool, true)
  }))
  default     = {}
  description = <<-EOT
EOT
}

variable "node_pool" {
  type = object({
    name                          = string
    vm_size                       = string
    capacity_reservation_group_id = optional(string)
    custom_ca_trust_enabled       = optional(bool, true)
    enable_auto_scaling           = optional(bool, true)
    enable_host_encryption        = optional(bool, true)
    enable_node_public_ip         = optional(bool, true)
    eviction_policy               = optional(string)
    fips_enabled                  = optional(bool, true)
    host_group_id                 = optional(string)
    kubelet_disk_type             = optional(string)
    max_count                     = optional(number)
    max_pods                      = optional(number)
    message_of_the_day            = optional(string)
    min_count                     = optional(number)
    mode                          = optional(string)
    node_labels                   = optional(map(string))
    node_public_ip_prefix_id      = optional(string)
    node_taints                   = optional(list(string))
    orchestrator_version          = optional(string)
    os_disk_size_gb               = optional(number)
    os_disk_type                  = optional(string)
    os_sku                        = optional(string)
    os_type                       = optional(string)
    pod_subnet_id                 = optional(string)
    priority                      = optional(string)
    proximity_placement_group_id  = optional(string)
    snapshot_id                   = optional(string)
    spot_max_price                = optional(number)
    tags                          = optional(map(string))
    ultra_ssd_enabled             = optional(bool, true)
    vnet_subnet_id                = optional(string)
    workload_runtime              = optional(string)
    zones                         = optional(set(string))
  })
  default     = null
  description = <<-EOT
    name                          = (Required) The name of the Node Pool which should be created within the Kubernetes Cluster. Changing this forces a new resource to be created. A Windows Node Pool cannot have a `name` longer than 6 characters. A random suffix of 4 characters is always added to the name to avoid clashes during recreates.
    node_count                    = (Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between `0` and `1000` (inclusive) for user pools and between `1` and `1000` (inclusive) for system pools and must be a value in the range `min_count` - `max_count`.
    tags                          = (Optional) A mapping of tags to assign to the resource. At this time there's a bug in the AKS API where Tags for a Node Pool are not stored in the correct case - you [may wish to use Terraform's `ignore_changes` functionality to ignore changes to the casing](https://www.terraform.io/language/meta-arguments/lifecycle#ignore_changess) until this is fixed in the AKS API.
    vm_size                       = (Required) The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this forces a new resource to be created.
    host_group_id                 = (Optional) The fully qualified resource ID of the Dedicated Host Group to provision virtual machines from. Changing this forces a new resource to be created.
    capacity_reservation_group_id = (Optional) Specifies the ID of the Capacity Reservation Group where this Node Pool should exist. Changing this forces a new resource to be created.
    custom_ca_trust_enabled       = (Optional) Specifies whether to trust a Custom CA. This requires that the Preview Feature `Microsoft.ContainerService/CustomCATrustPreview` is enabled and the Resource Provider is re-registered, see [the documentation](https://learn.microsoft.com/en-us/azure/aks/custom-certificate-authority) for more information.
    enable_auto_scaling           = (Optional) Whether to enable [auto-scaler](https://docs.microsoft.com/azure/aks/cluster-autoscaler).
    enable_host_encryption        = (Optional) Should the nodes in this Node Pool have host encryption enabled? Changing this forces a new resource to be created.
    enable_node_public_ip         = (Optional) Should each node have a Public IP Address? Changing this forces a new resource to be created.
    eviction_policy               = (Optional) The Eviction Policy which should be used for Virtual Machines within the Virtual Machine Scale Set powering this Node Pool. Possible values are `Deallocate` and `Delete`. Changing this forces a new resource to be created. An Eviction Policy can only be configured when `priority` is set to `Spot` and will default to `Delete` unless otherwise specified.
    fips_enabled                  = (Optional) Should the nodes in this Node Pool have Federal Information Processing Standard enabled? Changing this forces a new resource to be created. FIPS support is in Public Preview - more information and details on how to opt into the Preview can be found in [this article](https://docs.microsoft.com/azure/aks/use-multiple-node-pools#add-a-fips-enabled-node-pool-preview).
    kubelet_disk_type             = (Optional) The type of disk used by kubelet. Possible values are `OS` and `Temporary`.
    max_count                     = (Optional) The maximum number of nodes which should exist within this Node Pool. Valid values are between `0` and `1000` and must be greater than or equal to `min_count`.
    max_pods                      = (Optional) The minimum number of nodes which should exist within this Node Pool. Valid values are between `0` and `1000` and must be less than or equal to `max_count`.
    message_of_the_day            = (Optional) A base64-encoded string which will be written to /etc/motd after decoding. This allows customization of the message of the day for Linux nodes. It cannot be specified for Windows nodes and must be a static string (i.e. will be printed raw and not executed as a script). Changing this forces a new resource to be created.
    mode                          = (Optional) Should this Node Pool be used for System or User resources? Possible values are `System` and `User`. Defaults to `User`.
    min_count                     = (Optional) The minimum number of nodes which should exist within this Node Pool. Valid values are between `0` and `1000` and must be less than or equal to `max_count`.
    node_labels                   = (Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool.
    node_public_ip_prefix_id      = (Optional) Resource ID for the Public IP Addresses Prefix for the nodes in this Node Pool. `enable_node_public_ip` should be `true`. Changing this forces a new resource to be created.
    node_taints                   = (Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g `key=value:NoSchedule`). Changing this forces a new resource to be created.
    orchestrator_version          = (Optional) Version of Kubernetes used for the Agents. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). AKS does not require an exact patch version to be specified, minor version aliases such as `1.22` are also supported. - The minor version's latest GA patch is automatically chosen in that case. More details can be found in [the documentation](https://docs.microsoft.com/en-us/azure/aks/supported-kubernetes-versions?tabs=azure-cli#alias-minor-version). This version must be supported by the Kubernetes Cluster - as such the version of Kubernetes used on the Cluster/Control Plane may need to be upgraded first.
    os_disk_size_gb               = (Optional) The Agent Operating System disk size in GB. Changing this forces a new resource to be created.
    os_disk_type                  = (Optional) The type of disk which should be used for the Operating System. Possible values are `Ephemeral` and `Managed`. Defaults to `Managed`. Changing this forces a new resource to be created.
    os_sku                        = (Optional) Specifies the OS SKU used by the agent pool. Possible values include: `Ubuntu`, `CBLMariner`, `Mariner`, `Windows2019`, `Windows2022`. If not specified, the default is `Ubuntu` if OSType=Linux or `Windows2019` if OSType=Windows. And the default Windows OSSKU will be changed to `Windows2022` after Windows2019 is deprecated. Changing this forces a new resource to be created.
    os_type                       = (Optional) The Operating System which should be used for this Node Pool. Changing this forces a new resource to be created. Possible values are `Linux` and `Windows`. Defaults to `Linux`.
    pod_subnet_id                 = (Optional) The ID of the Subnet where the pods in the Node Pool should exist. Changing this forces a new resource to be created.
    priority                      = (Optional) The Priority for Virtual Machines within the Virtual Machine Scale Set that powers this Node Pool. Possible values are `Regular` and `Spot`. Defaults to `Regular`. Changing this forces a new resource to be created.
    proximity_placement_group_id  = (Optional) The ID of the Proximity Placement Group where the Virtual Machine Scale Set that powers this Node Pool will be placed. Changing this forces a new resource to be created. When setting `priority` to Spot - you must configure an `eviction_policy`, `spot_max_price` and add the applicable `node_labels` and `node_taints` [as per the Azure Documentation](https://docs.microsoft.com/azure/aks/spot-node-pool).
    spot_max_price                = (Optional) The maximum price you're willing to pay in USD per Virtual Machine. Valid values are `-1` (the current on-demand price for a Virtual Machine) or a positive value with up to five decimal places. Changing this forces a new resource to be created. This field can only be configured when `priority` is set to `Spot`.
    scale_down_mode               = (Optional) Specifies how the node pool should deal with scaled-down nodes. Allowed values are `Delete` and `Deallocate`. Defaults to `Delete`.
    snapshot_id                   = (Optional) The ID of the Snapshot which should be used to create this Node Pool. Changing this forces a new resource to be created.
    ultra_ssd_enabled             = (Optional) Used to specify whether the UltraSSD is enabled in the Node Pool. Defaults to `false`. See [the documentation](https://docs.microsoft.com/azure/aks/use-ultra-disks) for more information. Changing this forces a new resource to be created.
    vnet_subnet_id                = (Optional) The ID of the Subnet where this Node Pool should exist. Changing this forces a new resource to be created. A route table must be configured on this Subnet.
    workload_runtime              = (Optional) Used to specify the workload runtime. Allowed values are `OCIContainer` and `WasmWasi`. WebAssembly System Interface node pools are in Public Preview - more information and details on how to opt into the preview can be found in [this article](https://docs.microsoft.com/azure/aks/use-wasi-node-pools)
    zones                         = (Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster Node Pool should be located. Changing this forces a new Kubernetes Cluster Node Pool to be created.        
EOT
}

variable "node_pool_kubelet_config" {
  type = list(object({
    allowed_unsafe_sysctls    = set(string)
    container_log_max_line    = number
    container_log_max_size_mb = number
    cpu_cfs_quota_enabled     = number
    cpu_cfs_quota_period      = string
    cpu_manager_policy        = string
    image_gc_high_threshold   = number
    image_gc_low_threshold    = number
    pod_max_pid               = number
    topology_manager_policy   = string
  }))
  default     = []
  description = <<-EOT
      cpu_manager_policy        = (Optional) Specifies the CPU Manager policy to use. Possible values are `none` and `static`, Changing this forces a new resource to be created.
      cpu_cfs_quota_enabled     = (Optional) Is CPU CFS quota enforcement for containers enabled? Changing this forces a new resource to be created.
      cpu_cfs_quota_period      = (Optional) Specifies the CPU CFS quota period value. Changing this forces a new resource to be created.
      image_gc_high_threshold   = (Optional) Specifies the percent of disk usage above which image garbage collection is always run. Must be between `0` and `100`. Changing this forces a new resource to be created.
      image_gc_low_threshold    = (Optional) Specifies the percent of disk usage lower than which image garbage collection is never run. Must be between `0` and `100`. Changing this forces a new resource to be created.
      topology_manager_policy   = (Optional) Specifies the Topology Manager policy to use. Possible values are `none`, `best-effort`, `restricted` or `single-numa-node`. Changing this forces a new resource to be created.
      allowed_unsafe_sysctls    = (Optional) Specifies the allow list of unsafe sysctls command or patterns (ending in `*`). Changing this forces a new resource to be created.
      container_log_max_size_mb = (Optional) Specifies the maximum size (e.g. 10MB) of container log file before it is rotated. Changing this forces a new resource to be created.
      container_log_max_files   = (Optional) Specifies the maximum number of container log files that can be present for a container. must be at least 2. Changing this forces a new resource to be created.
      pod_max_pid               = (Optional) Specifies the maximum number of processes per pod. Changing this forces a new resource to be created.
EOT
}

variable "node_pool_linux_os_config" {
  type = list(object({
    swap_file_size_mb             = number
    transparent_huge_page_defrag  = string
    transparent_huge_page_enabled = string
    sysctl_config = optional(list(object({
      fs_aio_max_nr                      = number
      fs_file_max                        = number
      fs_inotify_max_user_watches        = number
      fs_nr_open                         = number
      kernel_threads_max                 = number
      net_core_netdev_max_backlog        = number
      net_core_optmem_max                = number
      net_core_rmem_default              = number
      net_core_somaxconn                 = number
      net_core_wmem_default              = number
      net_core_wmem_max                  = number
      net_ipv4_ip_local_port_range_max   = number
      net_ipv4_ip_local_port_range_min   = number
      net_ipv4_neigh_default_gc_thresh1  = number
      net_ipv4_neigh_default_gc_thresh2  = number
      net_ipv4_neigh_default_gc_thresh3  = number
      net_ipv4_tcp_fin_timeout           = number
      net_ipv4_tcp_keepalive_intvl       = number
      net_ipv4_tcp_keepalive_probes      = number
      net_ipv4_tcp_keepalive_time        = number
      net_ipv4_tcp_max_syn_backlog       = number
      net_ipv4_tcp_max_tw_buckets        = number
      net_ipv4_tcp_tw_reuse              = number
      net_netfilter_nf_conntrack_buckets = number
      net_netfilter_nf_conntrack_max     = number
      vm_max_map_count                   = number
      vm_swappiness                      = number
      vm_vfs_cache_pressure              = number
    })), [])
  }))
  default     = []
  description = <<-EOT
    fs_aio_max_nr                      = (Optional) The sysctl setting fs.aio-max-nr. Must be between `65536` and `6553500`. Changing this forces a new resource to be created.
    fs_file_max                        = (Optional) The sysctl setting fs.file-max. Must be between `8192` and `12000500`. Changing this forces a new resource to be created.
    fs_inotify_max_user_watches        = (Optional) The sysctl setting fs.inotify.max_user_watches. Must be between `781250` and `2097152`. Changing this forces a new resource to be created.
    fs_nr_open                         = (Optional) The sysctl setting fs.nr_open. Must be between `8192` and `20000500`. Changing this forces a new resource to be created.
    kernel_threads_max                 = (Optional) The sysctl setting kernel.threads-max. Must be between `20` and `513785`. Changing this forces a new resource to be created.
    net_core_netdev_max_backlog        = (Optional) The sysctl setting net.core.netdev_max_backlog. Must be between `1000` and `3240000`. Changing this forces a new resource to be created.
    net_core_optmem_max                = (Optional) The sysctl setting net.core.optmem_max. Must be between `20480` and `4194304`. Changing this forces a new resource to be created.
    net_core_rmem_default              = (Optional) The sysctl setting net.core.rmem_default. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.
    net_core_rmem_max                  = (Optional) The sysctl setting net.core.rmem_max. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.
    net_core_somaxconn                 = (Optional) The sysctl setting net.core.somaxconn. Must be between `4096` and `3240000`. Changing this forces a new resource to be created.
    net_core_wmem_default              = (Optional) The sysctl setting net.core.wmem_default. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.
    net_core_wmem_max                  = (Optional) The sysctl setting net.core.wmem_max. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.
    net_ipv4_ip_local_port_range_min   = (Optional) The sysctl setting net.ipv4.ip_local_port_range max value. Must be between `1024` and `60999`. Changing this forces a new resource to be created.
    net_ipv4_ip_local_port_range_max   = (Optional) The sysctl setting net.ipv4.ip_local_port_range min value. Must be between `1024` and `60999`. Changing this forces a new resource to be created.
    net_ipv4_neigh_default_gc_thresh1  = (Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh1. Must be between `128` and `80000`. Changing this forces a new resource to be created.
    net_ipv4_neigh_default_gc_thresh2  = (Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh2. Must be between `512` and `90000`. Changing this forces a new resource to be created.
    net_ipv4_neigh_default_gc_thresh3  = (Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh3. Must be between `1024` and `100000`. Changing this forces a new resource to be created.
    net_ipv4_tcp_fin_timeout           = (Optional) The sysctl setting net.ipv4.tcp_fin_timeout. Must be between `5` and `120`. Changing this forces a new resource to be created.
    net_ipv4_tcp_keepalive_intvl       = (Optional) The sysctl setting net.ipv4.tcp_keepalive_intvl. Must be between `10` and `75`. Changing this forces a new resource to be created.
    net_ipv4_tcp_keepalive_probes      = (Optional) The sysctl setting net.ipv4.tcp_keepalive_probes. Must be between `1` and `15`. Changing this forces a new resource to be created.
    net_ipv4_tcp_keepalive_time        = (Optional) The sysctl setting net.ipv4.tcp_keepalive_time. Must be between `30` and `432000`. Changing this forces a new resource to be created.
    net_ipv4_tcp_max_syn_backlog       = (Optional) The sysctl setting net.ipv4.tcp_max_syn_backlog. Must be between `128` and `3240000`. Changing this forces a new resource to be created.
    net_ipv4_tcp_max_tw_buckets        = (Optional) The sysctl setting net.ipv4.tcp_max_tw_buckets. Must be between `8000` and `1440000`. Changing this forces a new resource to be created.
    net_ipv4_tcp_tw_reuse              = (Optional) The sysctl setting net.ipv4.tcp_tw_reuse. Changing this forces a new resource to be created.
    net_netfilter_nf_conntrack_buckets = (Optional) The sysctl setting net.netfilter.nf_conntrack_buckets. Must be between `65536` and `147456`. Changing this forces a new resource to be created.
    net_netfilter_nf_conntrack_max     = (Optional) The sysctl setting net.netfilter.nf_conntrack_max. Must be between `131072` and `1048576`. Changing this forces a new resource to be created.
    vm_max_map_count                   = (Optional) The sysctl setting vm.max_map_count. Must be between `65530` and `262144`. Changing this forces a new resource to be created.
    vm_swappiness                      = (Optional) The sysctl setting vm.swappiness. Must be between `0` and `100`. Changing this forces a new resource to be created.
    vm_vfs_cache_pressure              = (Optional) The sysctl setting vm.vfs_cache_pressure. Must be between `0` and `100`. Changing this forces a new resource to be created.
    transparent_huge_page_enabled      = (Optional) Specifies the Transparent Huge Page enabled configuration. Possible values are `always`, `madvise` and `never`. Changing this forces a new resource to be created.
    transparent_huge_page_defrag       = (Optional) specifies the defrag configuration for Transparent Huge Page. Possible values are `always`, `defer`, `defer+madvise`, `madvise` and `never`. Changing this forces a new resource to be created.
    swap_file_size_mb                  = (Optional) Specifies the size of the swap file on each node in MB. Changing this forces a new resource to be created.
EOT
}

variable "node_pool_node_network_profile" {
  type = object({
    node_public_ip_tags = optional(map(string))
  })
  default     = null
  description = <<-EOT
EOT
}

variable "node_pool_upgrade_settings" {
  type = object({
    max_surge = optional(string)
  })
  default     = null
  description = <<-EOT
EOT
}

variable "node_pool_windows_profile" {
  type = object({
    outbound_nat_enabled = optional(bool, true)
  })
  default     = null
  description = <<-EOT
EOT
}