iam_role = [
  {
    id     = "0"
    name   = "eks-cluster"
    policy = "eks_cluster"
  }
]

iam_policy = [
  {
    id   = "0"
    name = "eks-cluster-policy"
    path = "/"
  }
]

iam_role_policy_attachment = [
  {
    id          = "0"
    iam_role_id = "0"
    policy_arn  = "arn:aws:iam::aws/policy/AmazonEKSClusterPolicy"
  },
  {
    id          = "1"
    iam_role_id = "0"
    policy_arn  = "arn:aws:iam::aws/policy/AmazonEKSServicePolicy"
  },
  {
    id          = "2"
    iam_role_id = "0"
    policy_arn  = "arn:aws:iam::aws/policy/AmazonEKSWorkerNodePolicy"
  },
  {
    id          = "3"
    iam_role_id = "0"
    policy_arn  = "arn:aws:iam::aws/policy/AmazonEKS_CNI_Policy"
  },
  {
    id          = "4"
    iam_role_id = "0"
    policy_arn  = "arn:aws:iam::aws/policy/AmazonEC2ContainerRegistryReadOnly"
  }
]

instance_profile = [
  {
    id      = "0"
    name    = "terraform-eks"
    role_id = "0"
  }
]

service_linked_role = [
  {
    id               = "0"
    aws_service_name = "autoscaling"
    custom_suffix    = "eks-test-demo"
  }
]

vpc = [
  {
    id                   = "0"
    cidr_block           = "10.10.0.0/16"
    instance_tenancy     = "default"
    enable_dns_hostnames = "true"
    enable_dns_support   = "true"
  }
]

subnet = [
  {
    id                      = "0"
    vpc_id                  = "0"
    cidr_block              = "10.10.10.0/24"
    availability_zone       = "eu-west-1a"
    map_public_ip_on_launch = "true"
  },
  {
    id                      = "1"
    vpc_id                  = "0"
    cidr_block              = "10.10.20.0/24"
    availability_zone       = "eu-west-1b"
    map_public_ip_on_launch = "true"
  }
]

internet_gateway = [
  {
    id     = "0"
    vpc_id = "0"
  }
]

route_table = [
  {
    id     = "0"
    vpc_id = "0"
    route = [
      {
        cidr_block     = "0.0.0.0/0"
        gateway_id     = "0"
        nat_gateway_id = ""
      }
    ]
  },
  {
    id     = "1"
    vpc_id = "0"
    route = [
      {
        cidr_block     = "0.0.0.0/0"
        gateway_id     = ""
        nat_gateway_id = "0"
      }
    ]
  }
]

nat_gateway = [
  {
    id            = "0"
    allocation_id = "0"
    subnet_id     = "0"
  }
]

route_table_association = [
  {
    id             = "0"
    route_table_id = "0"
    subnet_id      = "0"
  },
  {
    id             = "1"
    route_table_id = "1"
    subnet_id      = "1"
  }
]

security_group = [
  {
    id          = "0"
    name        = "EKS-cluster"
    description = "ECS_security_group"
    vpc_id      = "0"
  },
  {
    id          = "1"
    name        = "EKS-nodes"
    description = "ECS_security_group"
    vpc_id      = "0"
  }
]

security_group_rules = [
  {
    id                = "0"
    type              = "ingress"
    protocol          = "TCP"
    from_port         = "22"
    to_port           = "22"
    security_group_id = "0"
    cidr_blocks       = "0.0.0.0/0"
  },
  {
    id                = "1"
    type              = "ingress"
    protocol          = "TCP"
    from_port         = "22"
    to_port           = "22"
    security_group_id = "1"
    cidr_blocks       = "0.0.0.0/0"
  },
  {
    id                = "2"
    type              = "ingress"
    protocol          = "-1"
    from_port         = "0"
    to_port           = "63535"
    security_group_id = "0"
    cidr_blocks       = "10.10.20.0/24"
  },
  {
    id                = "3"
    type              = "ingress"
    protocol          = "TCP"
    from_port         = "1025"
    to_port           = "63535"
    security_group_id = "1"
    cidr_blocks       = "10.10.10.0/24"
  },
  {
    id                = "4"
    type              = "ingress"
    protocol          = "TCP"
    from_port         = "443"
    to_port           = "443"
    security_group_id = "0"
    cidr_blocks       = "10.10.20.0/24"
  }
]

eip = [
  {
    id     = "0"
    vpc_id = "0"
  }
]

eks_cluster = [
  {
    id          = "0"
    name        = ""
    iam_role_id = "0"
    vpc_config = [
      {
        security_group_id = "0"
        subnet_id_1       = "0"
        subnet_id_2       = "1"
      }
    ]
  }
]
node_group = [
  {
    id              = "0"
    cluster_id      = "0"
    node_group_name = "worker_group_1"
    role_id         = "0"
    subnet_id       = "1"
    scaling_config = [
      {
        desired_size = "1"
        max_size     = "5"
        min_size     = "1"
      }
    ]
    remote_access = []
  }
]
log_group = []