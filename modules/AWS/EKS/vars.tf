variable "tags" {
  type        = map(string)
  default     = {}
  description = ""
}

variable "access_entry" {
  type = list(map(object({
    id                = number
    cluster_id        = number
    principal_arn     = string
    kubernetes_groups = optional(list(string))
    tags              = optional(map(string))
    type              = optional(string)
    user_name         = optional(string)
  })))
  default     = []
  description = <<EOF
Access Entry Configurations for an EKS Cluster.
The following arguments are required:
cluster_id – (Required) ID of the cluster in Cluster variable.
principal_arn – (Required) The IAM Principal ARN which requires Authentication access to the EKS cluster.

The following arguments are optional:
kubernetes_groups – (Optional) List of string which can optionally specify the Kubernetes groups the user would belong to when creating an access entry.
tags - (Optional) Key-value map of resource tags. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level.
type - (Optional) Defaults to STANDARD which provides the standard workflow. EC2_LINUX, EC2_WINDOWS, FARGATE_LINUX types disallow users to input a username or groups, and prevent associations.
user_name - (Optional) Defaults to principal ARN if user is principal else defaults to assume-role/session-name is role is used.
EOF
}

variable "access_policy_association" {
  type = list(map(object({
    id            = number
    cluster_id    = number
    policy_arn    = string
    principal_arn = string
    access_scope = list(object({
      type       = string
      namespaces = optional(list(string))
    }))
  })))
  default     = []
  description = <<EOF
The following arguments are required:
cluster_name – (Required) ID of the EKS Cluster in the Cluster variable.
policy_arn – (Required) The ARN of the access policy that you're associating.
principal_arn – (Required) The IAM Principal ARN which requires Authentication access to the EKS cluster.
access_scope – (Required) The configuration block to determine the scope of the access. See access_scope Block below.
access_scope Block

The access_scope block supports the following arguments.
type - (Required) Valid values are namespace or cluster.
namespaces - (Optional) The namespaces to which the access scope applies when type is namespace.
EOF
}

variable "addon" {
  type = list(map(object({
    id                          = number
    addon_name                  = string
    cluster_id                  = number
    addon_version               = optional(string)
    configuration_values        = optional(string)
    resolve_conflicts_on_create = optional(bool)
    resolve_conflicts_on_update = optional(bool)
    tags                        = optional(map(string))
    preserve                    = optional(bool)
    service_account_role_arn    = optional(string)
  })))
  default     = []
  description = <<EOF
The following arguments are required:
addon_name – (Required) Name of the EKS add-on. The name must match one of the names returned by describe-addon-versions.
cluster_name – (Required) ID of the EKS Cluster in the Cluster variable.

The following arguments are optional:
addon_version – (Optional) The version of the EKS add-on. The version must match one of the versions returned by describe-addon-versions.
configuration_values - (Optional) custom configuration values for addons with single JSON string. This JSON string value must match the JSON schema derived from describe-addon-configuration.
resolve_conflicts_on_create - (Optional) How to resolve field value conflicts when migrating a self-managed add-on to an Amazon EKS add-on. Valid values are NONE and OVERWRITE.
resolve_conflicts_on_update - (Optional) How to resolve field value conflicts for an Amazon EKS add-on if you've changed a value from the Amazon EKS default value. Valid values are NONE, OVERWRITE, and PRESERVE.
resolve_conflicts - (Deprecated use the resolve_conflicts_on_create and resolve_conflicts_on_update attributes instead) Define how to resolve parameter value conflicts when migrating an existing add-on to an Amazon EKS add-on or when applying version updates to the add-on. Valid values are NONE, OVERWRITE and PRESERVE. Note that PRESERVE is only valid on addon update, not for initial addon creation. If you need to set this to PRESERVE, use the resolve_conflicts_on_create and resolve_conflicts_on_update attributes instead.
tags - (Optional) Key-value map of resource tags. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level.
preserve - (Optional) Indicates if you want to preserve the created resources when deleting the EKS add-on.
service_account_role_arn - (Optional) The Amazon Resource Name (ARN) of an existing IAM role to bind to the add-on's service account. The role must be assigned the IAM permissions required by the add-on. If you don't specify an existing IAM role, then the add-on uses the permissions assigned to the node IAM role.
EOF
}

variable "cluster" {
  type = list(map(object({
    id                        = number
    name                      = string
    role_arn                  = string
    enabled_cluster_log_types = optional(list(string))
    tags                      = optional(map(string))
    version                   = optional(string)
    vpc_config = list(object({
      subnet_ids              = list(string)
      endpoint_private_access = optional(bool)
      endpoint_public_access  = optional(bool)
      public_access_cidrs     = optional(list(string))
      security_group_ids      = optional(list(string))
    }))
    access_config = optional(list(object({
      authentication_mode                         = optional(string)
      bootstrap_cluster_creator_admin_permissions = optional(bool)
    })), [])
    encryption_config = optional(list(object({
      resources = optional(list(string))
      provider = optional(list(object({
        key_arn = string
      })), [])
    })), [])
    kubernetes_network_config = optional(list(object({
      service_ipv4_cidr = string
      ip_family         = optional(string)
    })), [])
    outpost_config = optional(list(object({
      control_plane_instance_type = string
      outpost_arns                = optional(list(string))
      control_plane_placement = optional(list(object({
        group_name = string
      })), [])
    })), [])
  })))
  default     = []
  description = <<EOF
The following arguments are required:
name – (Required) Name of the cluster. Must be between 1-100 characters in length. Must begin with an alphanumeric character, and must only contain alphanumeric characters, dashes and underscores (^[0-9A-Za-z][A-Za-z0-9\-_]*$).
role_arn - (Required) ARN of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations on your behalf. Ensure the resource configuration includes explicit dependencies on the IAM Role permissions by adding depends_on if using the aws_iam_role_policy resource or aws_iam_role_policy_attachment resource, otherwise EKS cannot delete EKS managed EC2 infrastructure such as Security Groups on EKS Cluster deletion.
vpc_config - (Required) Configuration block for the VPC associated with your cluster. Amazon EKS VPC resources have specific requirements to work properly with Kubernetes. For more information, see Cluster VPC Considerations and Cluster Security Group Considerations in the Amazon EKS User Guide. Detailed below. Also contains attributes detailed in the Attributes section.

The following arguments are optional:
access_config - (Optional) Configuration block for the access config associated with your cluster, see Amazon EKS Access Entries.
enabled_cluster_log_types - (Optional) List of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging.
encryption_config - (Optional) Configuration block with encryption configuration for the cluster. Only available on Kubernetes 1.13 and above clusters created after March 6, 2020. Detailed below.
kubernetes_network_config - (Optional) Configuration block with kubernetes network configuration for the cluster. Detailed below. If removed, Terraform will only perform drift detection if a configuration value is provided.
outpost_config - (Optional) Configuration block representing the configuration of your local Amazon EKS cluster on an AWS Outpost. This block isn't available for creating Amazon EKS clusters on the AWS cloud.
tags - (Optional) Key-value map of resource tags. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level.
version – (Optional) Desired Kubernetes master version. If you do not specify a value, the latest available version at resource creation is used and no upgrades will occur except those automatically triggered by EKS. The value must be configured and increased to upgrade the version when desired. Downgrades are not supported by EKS.

access_config
The access_config configuration block supports the following arguments:
authentication_mode - (Optional) The authentication mode for the cluster. Valid values are CONFIG_MAP, API or API_AND_CONFIG_MAP
bootstrap_cluster_creator_admin_permissions - (Optional) Whether or not to bootstrap the access config values to the cluster. Default is true.

encryption_config
The encryption_config configuration block supports the following arguments:
provider - (Required) Configuration block with provider for encryption. Detailed below.
resources - (Required) List of strings with resources to be encrypted. Valid values: secrets.

provider
The provider configuration block supports the following arguments:
key_arn - (Required) ARN of the Key Management Service (KMS) customer master key (CMK). The CMK must be symmetric, created in the same region as the cluster, and if the CMK was created in a different account, the user must have access to the CMK. For more information, see Allowing Users in Other Accounts to Use a CMK in the AWS Key Management Service Developer Guide.

vpc_config Arguments
endpoint_private_access - (Optional) Whether the Amazon EKS private API server endpoint is enabled. Default is false.
endpoint_public_access - (Optional) Whether the Amazon EKS public API server endpoint is enabled. Default is true.
public_access_cidrs - (Optional) List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled. EKS defaults this to a list with 0.0.0.0/0. Terraform will only perform drift detection of its value when present in a configuration.
security_group_ids – (Optional) List of security group IDs for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane.
subnet_ids – (Required) List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane.

kubernetes_network_config
The kubernetes_network_config configuration block supports the following arguments:
service_ipv4_cidr - (Optional) The CIDR block to assign Kubernetes pod and service IP addresses from. If you don't specify a block, Kubernetes assigns addresses from either the 10.100.0.0/16 or 172.20.0.0/16 CIDR blocks. We recommend that you specify a block that does not overlap with resources in other networks that are peered or connected to your VPC. You can only specify a custom CIDR block when you create a cluster, changing this value will force a new cluster to be created. The block must meet the following requirements:
Within one of the following private IP address blocks: 10.0.0.0/8, 172.16.0.0/12, or 192.168.0.0/16.
Doesn't overlap with any CIDR block assigned to the VPC that you selected for VPC.
Between /24 and /12.
ip_family - (Optional) The IP family used to assign Kubernetes pod and service addresses. Valid values are ipv4 (default) and ipv6. You can only specify an IP family when you create a cluster, changing this value will force a new cluster to be created.

outpost_config
The outpost_config configuration block supports the following arguments:
control_plane_instance_type - (Required) The Amazon EC2 instance type that you want to use for your local Amazon EKS cluster on Outposts. The instance type that you specify is used for all Kubernetes control plane instances. The instance type can't be changed after cluster creation. Choose an instance type based on the number of nodes that your cluster will have. If your cluster will have:
1–20 nodes, then we recommend specifying a large instance type.
21–100 nodes, then we recommend specifying an xlarge instance type.
101–250 nodes, then we recommend specifying a 2xlarge instance type.
For a list of the available Amazon EC2 instance types, see Compute and storage in AWS Outposts rack features The control plane is not automatically scaled by Amazon EKS.

control_plane_placement - (Optional) An object representing the placement configuration for all the control plane instances of your local Amazon EKS cluster on AWS Outpost. The control_plane_placement configuration block supports the following arguments:
group_name - (Required) The name of the placement group for the Kubernetes control plane instances. This setting can't be changed after cluster creation.
outpost_arns - (Required) The ARN of the Outpost that you want to use for your local Amazon EKS cluster on Outposts. This argument is a list of arns, but only a single Outpost ARN is supported currently.
EOF
}

variable "fargate_profile" {
  type = list(map(object({
    id                     = number
    cluster_id             = number
    fargate_profile_name   = string
    pod_execution_role_arn = string
    subnet_ids             = string
    tags                   = optional(map(string))
    selector = list(object({
      namespace = string
    }))
  })))
  default     = []
  description = <<EOF
The following arguments are required:
cluster_name – (Required) Name of the EKS Cluster.
fargate_profile_name – (Required) Name of the EKS Fargate Profile.
pod_execution_role_arn – (Required) Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Fargate Profile.
selector - (Required) Configuration block(s) for selecting Kubernetes Pods to execute with this EKS Fargate Profile. Detailed below.
subnet_ids – (Required) Identifiers of private EC2 Subnets to associate with the EKS Fargate Profile. These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME (where CLUSTER_NAME is replaced with the name of the EKS Cluster).

The following arguments are optional:
tags - (Optional) Key-value map of resource tags. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level.

selector Configuration Block
The following arguments are required:
namespace - (Required) Kubernetes namespace for selection.
EOF
}

variable "identity_provider_config" {
  type = list(map(object({
    id         = number
    cluster_id = number
    tags       = optional(map(string))
    oidc = list(object({
      client_id                     = string
      identity_provider_config_name = string
      issuer_url                    = string
      groups_claim                  = optional(string)
      groups_prefix                 = optional(string)
      required_claims               = optional(map(string))
      username_claim                = optional(string)
      username_prefix               = optional(string)
    }))
  })))
  default     = []
  description = <<EOF
This resource supports the following arguments:
cluster_name – (Required) Name of the EKS Cluster.
oidc - (Required) Nested attribute containing OpenID Connect identity provider information for the cluster. Detailed below.
tags - (Optional) Key-value map of resource tags. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level.

oidc Configuration Block
client_id – (Required) Client ID for the OpenID Connect identity provider.
groups_claim - (Optional) The JWT claim that the provider will use to return groups.
groups_prefix - (Optional) A prefix that is prepended to group claims e.g., oidc:.
identity_provider_config_name – (Required) The name of the identity provider config.
issuer_url - (Required) Issuer URL for the OpenID Connect identity provider.
required_claims - (Optional) The key value pairs that describe required claims in the identity token.
username_claim - (Optional) The JWT claim that the provider will use as the username.
username_prefix - (Optional) A prefix that is prepended to username claims.
EOF
}

variable "node_group" {
  type = list(map(object({
    id                   = number
    cluster_id           = number
    node_group_name      = string
    node_role_arn        = string
    subnet_ids           = list(string)
    ami_type             = optional(string)
    capacity_type        = optional(string)
    disk_size            = optional(number)
    force_update_version = optional(bool)
    instance_types       = optional(list(string))
    labels               = optional(map(string))
    release_version      = optional(string)
    tags                 = optional(map(string))
    version              = optional(string)
    launch_template = optional(list(object({
      version = string
      id      = optional(string)
      name    = optional(string)
    })), [])
    remote_access = optional(list(object({
      ec2_ssh_key               = optional(string)
      source_security_group_ids = optional(list(string))
    })), [])
    scaling_config = optional(list(object({
      desired_size = number
      max_size     = number
      min_size     = number
    })), [])
    taint = optional(list(object({
      key    = string
      effect = string
      value  = optional(string)
    })), [])
    update_config = optional(list(object({
      max_unavailable            = number
      max_unavailable_percentage = number
    })), [])
  })))
  default     = []
  description = <<EOF
The following arguments are required:
cluster_name – (Required) Name of the EKS Cluster.
node_role_arn – (Required) Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group.
scaling_config - (Required) Configuration block with scaling settings. See scaling_config below for details.
subnet_ids – (Required) Identifiers of EC2 Subnets to associate with the EKS Node Group.

The following arguments are optional:
ami_type - (Optional) Type of Amazon Machine Image (AMI) associated with the EKS Node Group. See the AWS documentation for valid values. Terraform will only perform drift detection if a configuration value is provided.
capacity_type - (Optional) Type of capacity associated with the EKS Node Group. Valid values: ON_DEMAND, SPOT. Terraform will only perform drift detection if a configuration value is provided.
disk_size - (Optional) Disk size in GiB for worker nodes. Defaults to 50 for Windows, 20 all other node groups. Terraform will only perform drift detection if a configuration value is provided.
force_update_version - (Optional) Force version update if existing pods are unable to be drained due to a pod disruption budget issue.
instance_types - (Optional) List of instance types associated with the EKS Node Group. Defaults to ["t3.medium"]. Terraform will only perform drift detection if a configuration value is provided.
labels - (Optional) Key-value map of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed.
launch_template - (Optional) Configuration block with Launch Template settings. See launch_template below for details. Conflicts with remote_access.
node_group_name – (Optional) Name of the EKS Node Group. If omitted, Terraform will assign a random, unique name. Conflicts with node_group_name_prefix. The node group name can't be longer than 63 characters. It must start with a letter or digit, but can also include hyphens and underscores for the remaining characters.
node_group_name_prefix – (Optional) Creates a unique name beginning with the specified prefix. Conflicts with node_group_name.
release_version – (Optional) AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version.
remote_access - (Optional) Configuration block with remote access settings. See remote_access below for details. Conflicts with launch_template.
tags - (Optional) Key-value map of resource tags. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level.
taint - (Optional) The Kubernetes taints to be applied to the nodes in the node group. Maximum of 50 taints per node group. See taint below for details.
update_config - (Optional) Configuration block with update settings. See update_config below for details.
version – (Optional) Kubernetes version. Defaults to EKS Cluster Kubernetes version. Terraform will only perform drift detection if a configuration value is provided.

launch_template Configuration Block
id - (Optional) Identifier of the EC2 Launch Template. Conflicts with name.
name - (Optional) Name of the EC2 Launch Template. Conflicts with id.
version - (Required) EC2 Launch Template version number. While the API accepts values like $Default and $Latest, the API will convert the value to the associated version number (e.g., 1) on read and Terraform will show a difference on next plan. Using the default_version or latest_version attribute of the aws_launch_template resource or data source is recommended for this argument.

remote_access Configuration Block
ec2_ssh_key - (Optional) EC2 Key Pair name that provides access for remote communication with the worker nodes in the EKS Node Group. If you specify this configuration, but do not specify source_security_group_ids when you create an EKS Node Group, either port 3389 for Windows, or port 22 for all other operating systems is opened on the worker nodes to the Internet (0.0.0.0/0). For Windows nodes, this will allow you to use RDP, for all others this allows you to SSH into the worker nodes.
source_security_group_ids - (Optional) Set of EC2 Security Group IDs to allow SSH access (port 22) from on the worker nodes. If you specify ec2_ssh_key, but do not specify this configuration when you create an EKS Node Group, port 22 on the worker nodes is opened to the Internet (0.0.0.0/0).

scaling_config Configuration Block
desired_size - (Required) Desired number of worker nodes.
max_size - (Required) Maximum number of worker nodes.
min_size - (Required) Minimum number of worker nodes.

taint Configuration Block
key - (Required) The key of the taint. Maximum length of 63.
value - (Optional) The value of the taint. Maximum length of 63.
effect - (Required) The effect of the taint. Valid values: NO_SCHEDULE, NO_EXECUTE, PREFER_NO_SCHEDULE.

update_config Configuration Block
The following arguments are mutually exclusive.
max_unavailable - (Optional) Desired max number of unavailable worker nodes during node group update.
max_unavailable_percentage - (Optional) Desired max percentage of unavailable worker nodes during node group update.
EOF
}

variable "pod_identity_association" {
  type = list(map(object({
    id              = number
    cluster_id      = number
    namespace       = string
    role_arn        = string
    service_account = string
    tags            = optional(map(string))
  })))
  default     = []
  description = <<EOF
The following arguments are required:
cluster_name - (Required) The name of the cluster to create the association in.
namespace - (Required) The name of the Kubernetes namespace inside the cluster to create the association in. The service account and the pods that use the service account must be in this namespace.
role_arn - (Required) The Amazon Resource Name (ARN) of the IAM role to associate with the service account. The EKS Pod Identity agent manages credentials to assume this role for applications in the containers in the pods that use this service account.
service_account - (Required) The name of the Kubernetes service account inside the cluster to associate the IAM credentials with.

The following arguments are optional:
tags - (Optional) Key-value map of resource tags. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level.
EOF
}